"""
Responsible for calling the appropirate interfaces to perform a given experiment.

Args:
    Expriment instructions : Experiment
        All parameters to run the experiment
    Mill: Mill object
    Pump: Pump object
    Potentiostat: Potentiostat object
    Camera: Camera object
    OBS: OBS object
    Wellplate: Wellplate object
    Vials: Vials object
    Scale: Scale object

Returns:
    ExperimentResult: The results of the experiment.
    Wellplate: The updated wellplate object.
    Vials: The updated vials object.
"""

# pylint: disable=line-too-long, too-many-arguments, too-many-lines, broad-exception-caught

# Standard library imports
import logging
import math
import os

# Third party or custom imports
from pathlib import Path
from typing import Optional, Sequence, Tuple, Union
from PIL import Image

# Local application imports
from panda_lib.flir_camera import capture_new_image
from panda_lib.config.config import (
    AIR_GAP,
    DRIP_STOP,
    PATH_TO_DATA,
    PATH_TO_LOGS,
    read_testing_config,
)
from panda_lib.correction_factors import correction_factor
from panda_lib.errors import (
    CAFailure,
    CVFailure,
    DepositionFailure,
    NoAvailableSolution,
    OCPFailure,
)
from panda_lib.experiment_class import (
    EchemExperimentBase,
    ExperimentBase,
    ExperimentResult,
    ExperimentStatus,
)
from panda_lib.image_tools import add_data_zone
from panda_lib.log_tools import CustomLoggingFilter
from panda_lib.mill_control import Instruments, Mill, MockMill
from panda_lib.obs_controls import OBSController, MockOBSController
from panda_lib.syringepump import MockPump, SyringePump
from panda_lib.instrument_toolkit import Toolkit
from panda_lib.vials import StockVial, WasteVial
from panda_lib.wellplate import Well

TESTING = read_testing_config()

if TESTING:
    from panda_lib.gamry_control_WIP_mock import GamryPotentiostat as echem
    from panda_lib.gamry_control_WIP_mock import (
        potentiostat_chrono_parameters,
        potentiostat_cv_parameters,
        potentiostat_ocp_parameters,
    )
else:
    import panda_lib.gamry_control_WIP as echem
    from panda_lib.gamry_control_WIP import (
        potentiostat_chrono_parameters,
        potentiostat_cv_parameters,
        potentiostat_ocp_parameters,
    )

# set up logging to log to both the pump_control.log file and the ePANDA.log file
logger = logging.getLogger("e_panda")
logger.setLevel(logging.DEBUG)  # change to INFO to reduce verbosity
formatter = logging.Formatter(
    "%(asctime)s&%(name)s&%(levelname)s&%(module)s&%(funcName)s&%(lineno)d&%(message)s"
)
system_handler = logging.FileHandler(PATH_TO_LOGS / "ePANDA.log")
system_handler.setFormatter(formatter)
logger.addHandler(system_handler)

# Add a testing logger
testing_logger = logging.getLogger("testing")
testing_logger.setLevel(logging.DEBUG)
testing_handler = logging.FileHandler(PATH_TO_LOGS / "testing.log")
testing_handler.setFormatter(formatter)
testing_logger.addHandler(testing_handler)


def forward_pipette_v2(
    volume: float,
    from_vessel: Union[Well, StockVial, WasteVial],
    to_vessel: Union[Well, WasteVial],
    pump: Union[SyringePump, MockPump],
    mill: Union[Mill, MockMill],
    pumping_rate: Optional[float] = None,
):
    """
    Pipette a volume from one vessel to another

    Depending on the supplied vessels, this function will perform one of the following:
    1. Pipette from a stock vial to a well
    2. Pipette from a well to a waste vial*
    3. Pipette from a stock vial to a waste vial*
        * When pipetting to a waste vial the dispesnsing height will be above the solution depth to avoid contamination

    It will not allow:
    1. Pipetting from a waste vial to a well
    2. Pipetting from a well to a stock vial
    3. Pipetting from a stock vial toa  stock vial

    The steps that this function will perform:
    1. Determine the number of repetitions
    2. Withdraw the solution from the source
        a. Withdraw an air gap to engage the screw
        b. Move to the source
        c. Withdraw the solution
        d. Move back to safe height
        e. Withdraw an air gap to prevent dripping
    3. Deposit the solution into the destination vessel
        a. Move to the destination
        b. Deposit the solution and blow out
        c. Move back to safe height
        d. If depositing stock solution into a well, the recorded weight change will be saved to the target well
            in the wellplate object and the stock vial object will be updated with a corrected new volume based on the density of the solution.
    4. Repeat 2-3 until all repetitions are complete

    Args:
        volume (float): The volume to be pipetted in microliters
        from_vessel (Vial or Well): The vessel object to be pipetted from (must be selected before calling this function)
        to_vessel (Vial or Well): The vessel object to be pipetted to (must be selected before calling this function)
        pumping_rate (float): The pumping rate in ml/min
        pump (object): The pump object
        mill (object): The mill object
        wellplate (Wells object): The wellplate object

    Returns:
        None (void function) since the objects are passed by reference

    """
    if volume > float(0.00):
        logger.info(
            "Forward pipetting %f ul from %s to %s",
            volume,
            from_vessel.name,
            to_vessel.name,
        )
        # Check to ensure that the from_vessel and to_vessel are an allowed combination
        if isinstance(from_vessel, Well) and isinstance(to_vessel, StockVial):
            raise ValueError("Cannot pipette from a well to a stock vial")
        if isinstance(from_vessel, WasteVial) and isinstance(to_vessel, Well):
            raise ValueError("Cannot pipette from a waste vial to a well")
        if isinstance(from_vessel, StockVial) and isinstance(to_vessel, StockVial):
            raise ValueError("Cannot pipette from a stock vial to a stock vial")

        # Calculate the number of repetitions
        # based on pipette capacity and drip stop
        if pumping_rate is None:
            pumping_rate = pump.max_pump_rate

        repetitions = int(
            math.ceil(volume / (pump.pipette.capacity_ul - DRIP_STOP))
        )  # We first round up, then declare an int
        repetition_vol = volume / repetitions

        for j in range(repetitions):
            logger.info("Repetition %d of %d", j + 1, repetitions)
            # region First half: pick up solution
            logger.debug("Withdrawing %f of air gap...", AIR_GAP)

            # withdraw a little to engage screw receive nothing
            pump.withdraw(
                volume_to_withdraw=AIR_GAP, solution=None, rate=pump.max_pump_rate
            )  # withdraw air gap to engage screw

            # if isinstance(from_vessel, Well):
            #     logger.info(
            #         "Moving to %s at %s...", from_vessel.name, from_vessel.coordinates
            #     )
            #     from_vessel: Well = from_vessel
            #     mill.safe_move(
            #         from_vessel.coordinates["x"],
            #         from_vessel.coordinates["y"],
            #         from_vessel.depth,
            #         Instruments.PIPETTE,
            #     )
            # else:
            logger.info("Moving to %s at %s...", from_vessel.name, from_vessel.position)
            mill.safe_move(
                from_vessel.coordinates["x"],
                from_vessel.coordinates["y"],
                from_vessel.depth,
                Instruments.PIPETTE,
            )  # go to solution depth

            # Withdraw the solution from the source and receive the updated vessel object
            pump.withdraw(
                volume_to_withdraw=repetition_vol,
                solution=from_vessel,
                rate=pumping_rate,
                weigh=False,
            )  # pipette now has air gap + repetition vol

            if isinstance(from_vessel, Well):
                pump.withdraw(
                    volume_to_withdraw=20,
                    solution=None,
                    rate=pump.max_pump_rate,
                    weigh=False,
                )  # If the from vessel is a well withdraw a little extra to ensure cleared well

            mill.move_to_safe_position()

            # Withdraw an air gap to prevent dripping, receive nothing
            pump.withdraw(
                volume_to_withdraw=DRIP_STOP,
                solution=None,
                rate=pump.max_pump_rate,
                weigh=False,
            )

            logger.debug(
                "From Vessel %s volume: %f depth: %f",
                from_vessel.name,
                from_vessel.volume,
                from_vessel.depth,
            )
            # endregion
            # region Second Half: Deposit to to_vessel
            logger.info("Moving to: %s...", to_vessel.name)

            if isinstance(to_vessel, Well):
                to_vessel: Well = to_vessel
            else:
                to_vessel: WasteVial = to_vessel

            mill.safe_move(
                to_vessel.coordinates.x,
                to_vessel.coordinates.y,
                to_vessel.coordinates.z_top,
                Instruments.PIPETTE,
            )

            weigh = bool(isinstance(to_vessel, Well))

            # Infuse into the to_vessel
            # try:
            pump.infuse(
                volume_to_infuse=repetition_vol,
                being_infused=from_vessel,
                infused_into=to_vessel,
                rate=pump.max_pump_rate,
                blowout_ul=(
                    AIR_GAP + DRIP_STOP + 20
                    if isinstance(from_vessel, Well)
                    else AIR_GAP + DRIP_STOP
                ),
                weigh=weigh,
            )
            # except OverFillException as e:
            #     logger.error(
            #         "Overfill exception occurred during pipette into %s. %s", to_vessel.name, e
            #     )
            #     new_to_vessel = waste_selector(waste_vials, "waste", 0)
            # endregion


def rinse_v2(
    instructions: EchemExperimentBase,
    toolkit: Toolkit,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """
    Rinse the well with rinse_vol ul.
    Involves pipetteing and then clearing the well with no purging steps

    Args:
        instructions (Experiment): The experiment instructions
        toolkit (Toolkit): The toolkit object
        stock_vials (list): The list of stock vials
        waste_vials (list): The list of waste vials
    Returns:
        None (void function) since the objects are passed by reference
    """

    logger.info(
        "Rinsing well %s %dx...", instructions.well_id, instructions.rinse_count
    )
    instructions.set_status_and_save(ExperimentStatus.RINSING)
    for _ in range(instructions.rinse_count):
        # Pipette the rinse solution into the well
        forward_pipette_v2(
            volume=correction_factor(instructions.rinse_vol),
            from_vessel=solution_selector(
                stock_vials,
                "rinse",
                correction_factor(instructions.rinse_vol),
            ),
            to_vessel=toolkit.wellplate.wells[instructions.well_id],
            pump=toolkit.pump,
            mill=toolkit.mill,
            pumping_rate=toolkit.pump.max_pump_rate,
        )
        toolkit.mill.safe_move(
            x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
            y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
            z_coord=toolkit.wellplate.z_top,
            instrument=Instruments.PIPETTE,
        )
        # Clear the well
        forward_pipette_v2(
            volume=correction_factor(instructions.rinse_vol),
            from_vessel=toolkit.wellplate.wells[instructions.well_id],
            to_vessel=waste_selector(
                waste_vials,
                "waste",
                correction_factor(instructions.rinse_vol),
            ),
            pump=toolkit.pump,
            mill=toolkit.mill,
        )

    return 0


def flush_v2(
    waste_vials: Sequence[WasteVial],
    stock_vials: Sequence[StockVial],
    flush_solution_name: str,
    mill: Union[Mill, MockMill],
    pump: Union[SyringePump, MockPump],
    pumping_rate=float(0.5),
    flush_volume: float = float(120.0),
    flush_count=1,
    instructions: Optional[ExperimentBase] = None,
):
    """
    Flush the pipette tip with the designated flush_volume ul of DMF to remove any residue
    Args:
        waste_vials (list): The list of waste vials
        stock_vials (list): The list of stock vials
        flush_solution_name (str): The name of the solution to flush with
        mill (object): The mill object
        pump (object): The pump object
        pumping_rate (float): The pumping rate in ml/min
        flush_volume (float): The volume to flush with in microliters
        flush_count (int): The number of times to flush

    Returns:
        stock_vials (list): The updated list of stock vials
        waste_vials (list): The updated list of waste vials
    """

    if flush_volume > 0.000:
        if instructions is not None:
            instructions.set_status_and_save(ExperimentStatus.FLUSHING)
        logger.info(
            "Flushing pipette tip with %f ul of %s...",
            flush_volume,
            flush_solution_name,
        )

        for _ in range(flush_count):

            forward_pipette_v2(
                flush_volume,
                from_vessel=solution_selector(
                    stock_vials, flush_solution_name, flush_volume
                ),
                to_vessel=waste_selector(waste_vials, "waste", flush_volume),
                pump=pump,
                mill=mill,
                pumping_rate=pumping_rate,
            )

        logger.info(
            "Flushed pipette tip with %f ul of %s %dx times...",
            flush_volume,
            flush_solution_name,
            flush_count,
        )
    else:
        logger.info("No flushing required. Flush volume is 0. Continuing...")
    return 0


def purge_pipette(
    waste_vials: Sequence[WasteVial],
    mill: Union[Mill, MockMill],
    pump: Union[SyringePump, MockPump],
):
    """
    Move the pipette over an available waste vessel and purge its contents

    Args:
        waste_vials (Sequence[WasteVial]): _description_
        mill (Union[Mill, MockMill]): _description_
        pump (Union[Pump, MockPump]): _description_
    """
    liquid_volume = pump.pipette.liquid_volume()
    total_volume = pump.pipette.volume
    purge_vial = waste_selector(waste_vials, "waste", liquid_volume)

    # Move to the purge vial
    mill.safe_move(
        purge_vial.coordinates.x,
        purge_vial.coordinates.y,
        purge_vial.coordinates.z_top,
        Instruments.PIPETTE,
    )

    # Purge the pipette
    pump.infuse(
        volume_to_infuse=liquid_volume,
        being_infused=None,
        infused_into=purge_vial,
        blowout_ul=total_volume - liquid_volume,
    )


def solution_selector(
    solutions: Sequence[StockVial], solution_name: str, volume: float
) -> StockVial:
    """
    Select the solution from which to withdraw from, from the list of solution objects
    Args:
        solutions (list): The list of solution objects
        solution_name (str): The name of the solution to select
        volume (float): The volume to be pipetted
    Returns:
        solution (object): The solution object
    """
    for solution in solutions:
        # if the solution names match and the requested volume is less than the available volume (volume - 10% of capacity)
        if solution.name.lower() == solution_name.lower() and round(
            float(solution.volume) - float(0.10) * float(solution.capacity), 6
        ) > (volume):
            logger.debug(
                "Selected stock vial: %s in position %s",
                solution.name,
                solution.position,
            )
            return solution
    raise NoAvailableSolution(solution_name)


def waste_selector(
    solutions: Sequence[WasteVial], solution_name: str, volume: float
) -> WasteVial:
    """
    Select the solution in which to deposit into from the list of solution objects
    Args:
        solutions (list): The list of solution objects
        solution_name (str): The name of the solution to select
        volume (float): The volume to be pipetted
    Returns:
        solution (object): The solution object
    """
    solution_name = solution_name.lower()
    for waste_solution in solutions:
        if (
            waste_solution.name.lower() == solution_name
            and round((float(waste_solution.volume) + float(str(volume))), 6)
            < waste_solution.capacity
        ):
            logger.debug(
                "Selected waste vial: %s in position %s",
                waste_solution.name,
                waste_solution.position,
            )
            return waste_solution
    raise NoAvailableSolution(solution_name)


def chrono_amp(
    ca_instructions: EchemExperimentBase,
    file_tag: str = None,
    custom_parameters: potentiostat_chrono_parameters = None,
) -> Tuple[EchemExperimentBase, ExperimentResult]:
    """
    Deposition of the solutions onto the substrate. This includes the OCP and CA steps.

    No pipetting is performed in this step.

    Args:
        dep_instructions (Experiment): The experiment instructions
        file_tag (str): The file tag to be used for the data files
    Returns:
        dep_instructions (Experiment): The updated experiment instructions
        dep_results (ExperimentResult): The updated experiment results
    """
    try:
        # echem setup
        logger.info("Setting up eChem deposition experiments...")

        if TESTING:
            pstat = echem()
        else:
            pstat = echem
        pstat.pstatconnect()

        # echem OCP
        logger.info("Beginning eChem OCP of well: %s", ca_instructions.well_id)
        ca_instructions.set_status_and_save(ExperimentStatus.OCPCHECK)

        base_filename = pstat.setfilename(
            ca_instructions.experiment_id,
            file_tag + "_OCP_CA" if file_tag else "OCP_CA",
            ca_instructions.project_id,
            ca_instructions.project_campaign_id,
            ca_instructions.well_id,
        )
        ca_results = ca_instructions.results
        pstat.OCP(
            potentiostat_ocp_parameters.OCPvi,
            potentiostat_ocp_parameters.OCPti,
            potentiostat_ocp_parameters.OCPrate,
        )  # OCP
        pstat.activecheck()
        ocp_dep_pass, ocp_char_final_voltage = pstat.check_vf_range(base_filename)
        ca_results.set_ocp_ca_file(
            base_filename, ocp_dep_pass, ocp_char_final_voltage, file_tag
        )
        logger.info(
            "OCP of well %s passed: %s",
            ca_instructions.well_id,
            ocp_dep_pass,
        )

        # echem CA - deposition
        if not ocp_dep_pass:
            ca_instructions.set_status_and_save(ExperimentStatus.ERROR)
            raise OCPFailure("CA")

        try:
            ca_instructions.set_status_and_save(ExperimentStatus.EDEPOSITING)
            logger.info(
                "Beginning eChem deposition of well: %s", ca_instructions.well_id
            )
            deposition_data_file = pstat.setfilename(
                ca_instructions.experiment_id,
                file_tag + "_CA" if file_tag else "CA",
                ca_instructions.project_id,
                ca_instructions.project_campaign_id,
                ca_instructions.well_id,
            )

            # FEATURE have chrono return the max and min values for the deposition
            # and save them to the results
            if custom_parameters:  # if not none then use the custom parameters
                pstat.chrono(
                    CAvi=custom_parameters.CAvi,
                    CAti=custom_parameters.CAti,
                    CAv1=custom_parameters.CAv1,
                    CAt1=custom_parameters.CAt1,
                    CAv2=custom_parameters.CAv2,
                    CAt2=custom_parameters.CAt2,
                    CAsamplerate=custom_parameters.CAsamplerate,
                )  # unpack the custom parameters
            else:
                pstat.chrono(
                    CAvi=ca_instructions.ca_prestep_voltage,
                    CAti=ca_instructions.ca_prestep_time_delay,
                    CAv1=ca_instructions.ca_step_1_voltage,
                    CAt1=ca_instructions.ca_step_1_time,
                    CAv2=ca_instructions.ca_step_2_voltage,
                    CAt2=ca_instructions.ca_step_2_time,
                    CAsamplerate=ca_instructions.ca_sample_period,
                )  # CA

            pstat.activecheck()
            ca_results.set_ca_data_file(deposition_data_file, context=file_tag)
        except Exception as e:
            ca_instructions.set_status_and_save(ExperimentStatus.ERROR)
            logger.error("Exception occurred during deposition: %s", e)
            raise CAFailure(
                ca_instructions.experiment_id, ca_instructions.well_id
            ) from e

    except OCPFailure as e:
        ca_instructions.set_status_and_save(ExperimentStatus.ERROR)
        logger.error("OCP of well %s failed", ca_instructions.well_id)
        raise e

    except CAFailure as e:
        ca_instructions.set_status_and_save(ExperimentStatus.ERROR)
        logger.error("CA of well %s failed", ca_instructions.well_id)
        raise e

    except Exception as e:
        ca_instructions.set_status_and_save(ExperimentStatus.ERROR)
        logger.error("Exception occurred during deposition: %s", e)
        raise DepositionFailure(
            ca_instructions.experiment_id, ca_instructions.well_id
        ) from e

    finally:
        pstat.pstatdisconnect()

    return ca_instructions, ca_results


def cyclic_volt(
    cv_instructions: EchemExperimentBase,
    file_tag: str = None,
    overwrite_inital_voltage: bool = True,
    custom_parameters: potentiostat_cv_parameters = None,
) -> Tuple[EchemExperimentBase, ExperimentResult]:
    """
    Cyclicvoltamety in a well. This includes the OCP and CV steps.
    Will perform OCP and then set the initial voltage for the CV based on the final OCP voltage.
    To not change the instructions object, set overwrite_inital_voltage to False.
    No pipetting is performed in this step.
    Rinse the electrode after characterization.

    Args:
        char_instructions (Experiment): The experiment instructions

    Returns:
        char_instructions (Experiment): The updated experiment instructions
        char_results (ExperimentResult): The updated experiment results
    """
    try:
        # echem OCP
        if file_tag:
            logger.info(
                "Beginning %s OCP of well: %s", file_tag, cv_instructions.well_id
            )
        else:
            logger.info("Beginning OCP of well: %s", cv_instructions.well_id)
        if TESTING:
            pstat = echem()
        else:
            pstat = echem

        pstat.pstatconnect()
        cv_instructions.set_status_and_save(ExperimentStatus.OCPCHECK)
        ocp_char_file = pstat.setfilename(
            cv_instructions.experiment_id,
            file_tag + "_OCP_CV" if file_tag else "OCP_CV",
            cv_instructions.project_id,
            cv_instructions.project_campaign_id,
            cv_instructions.well_id,
        )

        try:
            pstat.OCP(
                OCPvi=potentiostat_ocp_parameters.OCPvi,
                OCPti=potentiostat_ocp_parameters.OCPti,
                OCPrate=potentiostat_ocp_parameters.OCPrate,
            )  # OCP
            pstat.activecheck()

        except Exception as e:
            cv_instructions.set_status_and_save(ExperimentStatus.ERROR)
            logger.error("Exception occurred during OCP: %s", e)
            raise OCPFailure("CV") from e
        (
            ocp_char_pass,
            ocp_final_voltage,
        ) = pstat.check_vf_range(ocp_char_file)
        cv_instructions.results.set_ocp_cv_file(
            ocp_char_file, ocp_char_pass, ocp_final_voltage, file_tag
        )
        logger.info(
            "OCP of well %s passed: %s",
            cv_instructions.well_id,
            ocp_char_pass,
        )

        if not ocp_char_pass:
            cv_instructions.set_status_and_save(ExperimentStatus.ERROR)
            logger.error("OCP of well %s failed", cv_instructions.well_id)
            raise OCPFailure("CV")

        # echem CV - characterization
        if cv_instructions.baseline == 1:
            test_type = "CV_baseline"
            cv_instructions.set_status_and_save(ExperimentStatus.BASELINE)
        else:
            test_type = "CV"
            cv_instructions.set_status_and_save(ExperimentStatus.CHARACTERIZING)

        logger.info(
            "Beginning eChem %s of well: %s", test_type, cv_instructions.well_id
        )

        characterization_data_file = pstat.setfilename(
            cv_instructions.experiment_id,
            file_tag + "_CV" if file_tag else test_type,
            cv_instructions.project_id,
            cv_instructions.project_campaign_id,
            cv_instructions.well_id,
        )
        cv_instructions.results.set_cv_data_file(characterization_data_file, file_tag)
        # FEATURE have cyclic return the max and min values for the characterization
        # and save them to the results
        if overwrite_inital_voltage:
            cv_instructions.cv_initial_voltage = ocp_final_voltage

        try:
            if custom_parameters:  # if not none then use the custom parameters
                custom_parameters.CVvi = ocp_final_voltage  # still need to set the initial voltage, not overwriting the original
                pstat.cyclic(
                    CVvi=custom_parameters.CVvi,
                    CVap1=custom_parameters.CVap1,
                    CVap2=custom_parameters.CVap2,
                    CVvf=custom_parameters.CVvf,
                    CVsr1=custom_parameters.CVsr1,
                    CVsr2=custom_parameters.CVsr2,
                    CVsr3=custom_parameters.CVsr3,
                    CVsamplerate=custom_parameters.CVsamplerate,
                    CVcycle=custom_parameters.CVcycle,
                )  # unpack the custom parameters
            else:
                pstat.cyclic(
                    CVvi=ocp_final_voltage,  # we always start where we left off in the OCP but don't always change the initial voltage
                    CVap1=cv_instructions.cv_first_anodic_peak,
                    CVap2=cv_instructions.cv_second_anodic_peak,
                    CVvf=cv_instructions.cv_final_voltage,
                    CVsr1=cv_instructions.cv_scan_rate_cycle_1,
                    CVsr2=cv_instructions.cv_scan_rate_cycle_2,
                    CVsr3=cv_instructions.cv_scan_rate_cycle_3,
                    CVsamplerate=cv_instructions.cv_sample_rate,
                    CVcycle=cv_instructions.cv_cycle_count,
                )
            pstat.activecheck()

        except Exception as e:
            cv_instructions.set_status_and_save(ExperimentStatus.ERROR)
            logger.error("Exception occurred during CV: %s", e)
            raise CVFailure(
                cv_instructions.experiment_id, cv_instructions.well_id
            ) from e

    except OCPFailure as e:
        cv_instructions.set_status_and_save(ExperimentStatus.ERROR)
        logger.error("OCP of well %s failed", cv_instructions.well_id)
        raise e
    except CVFailure as e:
        cv_instructions.set_status_and_save(ExperimentStatus.ERROR)
        logger.error("CV of well %s failed", cv_instructions.well_id)
        raise e
    except Exception as e:
        cv_instructions.set_status_and_save(ExperimentStatus.ERROR)
        logger.error("An unknown exception occurred during CV: %s", e)
        raise CVFailure(cv_instructions.experiment_id, cv_instructions.well_id) from e
    finally:
        pstat.pstatdisconnect()

    return cv_instructions, cv_instructions.results


def apply_log_filter(
    experiment_id: int = None,
    target_well: Optional[str] = None,
    campaign_id: Optional[str] = None,
    test: bool = TESTING,
):
    """Add custom value to log format"""
    experiment_formatter = logging.Formatter(
        "%(asctime)s&%(name)s&%(levelname)s&%(module)s&%(funcName)s&%(lineno)d&%(custom1)s&%(custom2)s&%(custom3)s&%(message)s&%(custom4)s"
    )
    system_handler.setFormatter(experiment_formatter)
    custom_filter = CustomLoggingFilter(campaign_id, experiment_id, target_well, test)
    logger.addFilter(custom_filter)


def volume_correction(
    volume: float, density: float = None, viscosity: float = None
) -> float:
    """
    Corrects the volume of the solution based on the density and viscosity of the solution

    Args:
        volume (float): The volume to be corrected
        density (float): The density of the solution
        viscosity (float): The viscosity of the solution

    Returns:
        corrected_volume (float): The corrected volume
    """
    if density is None:
        density = float(1.0)
    if viscosity is None:
        viscosity = float(1.0)
    corrected_volume = round(
        volume * (float(1.0) + (float(1.0) - density) * (float(1.0) - viscosity)), 6
    )
    return float(corrected_volume)


def image_well(
    toolkit: Toolkit,
    instructions: EchemExperimentBase = None,
    step_description: str = None,
):
    """
    Image the well with the camera

    Args:
        toolkit (Toolkit): The toolkit object
        instructions (Experiment): The experiment instructions
        step_description (str): The description of the step

    Returns:
        None (void function) since the objects are passed by reference
    """
    try:
        instructions.set_status_and_save(ExperimentStatus.IMAGING)
        logger.info("Imaging well %s", instructions.well_id)
        # capture image
        logger.debug("Capturing image of well %s", instructions.well_id)

        exp_id = instructions.experiment_id or "test"
        well_id = well_id = instructions.well_id or "test"
        # create file path
        filepath = image_filepath_generator(
            exp_id, well_id, instructions.project_campaign_id, step_description
        )

        # position lens above the well
        logger.info("Moving camera above well %s", well_id)
        if well_id != "test":
            toolkit.mill.safe_move(
                toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
                toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
                toolkit.wellplate.image_height,
                Instruments.LENS,
            )
        else:
            pass

        if TESTING:
            Path(filepath).touch()
        else:
            capture_new_image(save=True, num_images=1, file_name=filepath)

            dz_filename = filepath.stem + "_dz" + filepath.suffix
            dz_filepath = filepath.with_name(dz_filename)

            img: Image = add_data_zone(
                experiment=instructions,
                image=Image.open(filepath),
                context=step_description,
            )
            img.save(dz_filepath)
            instructions.results.append_image_file(
                dz_filepath, context=step_description + "_dz"
            )
        logger.debug("Image of well %s captured", instructions.well_id)

        instructions.results.append_image_file(filepath, context=step_description)

        # Post to obs
        try:
            if os.environ.get("PANDA_SDL_TESTING") == "1" or os.environ["PANDA_SDL_USE_OBS"] == '0':
                obs = MockOBSController()
            else:
                obs = OBSController()
            obs.change_image(new_image_path=filepath)
        except:
            # Not critical if the image is not posted to OBS
            logger.exception("Failed to post image to OBS")

    except Exception as e:
        logger.exception(
            "Failed to image well %s. Error %s occured", instructions.well_id, e
        )
        # raise ImageCaputreFailure(instructions.well_id) from e
        # don't raise anything and continue with the experiment. The image is not critical to the experiment
    finally:
        # move camera to safe position
        if well_id != "test":
            logger.info("Moving camera to safe position")
            toolkit.mill.move_to_safe_position()  # move to safe height above target well


def image_filepath_generator(
    exp_id: int = "test",
    project_id: int = "test",
    project_campaign_id: int = "test",
    well_id: str = "test",
    step_description: str = None,
) -> Path:
    """
    Generate the file path for the image
    """
    # create file name
    if step_description is not None:
        file_name = f"{project_id}_{project_campaign_id}_{exp_id}_{well_id}_{step_description}_image"
    else:
        file_name = f"{project_id}_{project_campaign_id}_{exp_id}_{well_id}_image"
    file_name = file_name.replace(" ", "_")  # clean up the file name
    file_name_start = file_name + "_0"  # enumerate the file name
    filepath = Path(PATH_TO_DATA / str(file_name_start)).with_suffix(".tiff")
    i = 1
    while filepath.exists():
        next_file_name = f"{file_name}_{i}"
        filepath = Path(PATH_TO_DATA / str(next_file_name)).with_suffix(".tiff")
        i += 1
    return filepath


if __name__ == "__main__":
    pass
