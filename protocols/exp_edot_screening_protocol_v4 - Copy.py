"""The sequence of steps for a pedotLHSv1_screening experiment."""

# Standard imports
from typing import Sequence

# Non-standard imports
from panda_lib.controller import Toolkit
from panda_lib.actions import (
    forward_pipette_v2,
    solution_selector,
    chrono_amp,
    waste_selector,
    image_well,
    flush_v2,
    OCPFailure,
    CAFailure,
    CVFailure,
    DepositionFailure
)
from panda_lib.actions_pedot import (
    chrono_amp_edot_bleaching,
    chrono_amp_edot_coloring,
    cyclic_volt_edot_characterizing,
)
from panda_lib.experiment_class import EdotExperiment, ExperimentStatus
from panda_lib.vials import StockVial, WasteVial
from panda_lib.correction_factors import correction_factor
from panda_lib.mill_control import Instruments
from panda_lib.utilities import solve_vials_ilp


def main(
    instructions: EdotExperiment,
    toolkit: Toolkit,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """
    Wrapper function for the pedotLHSv1_screening function.
    This function is called by the ePANDA scheduler.
    It is the main function for the pedotLHSv1_screening protocol.
    """
    pedot_lhs_v1_screening(
        instructions=instructions,
        toolkit=toolkit,
        stock_vials=stock_vials,
        waste_vials=waste_vials,
    )


def pedot_lhs_v1_screening(
    instructions: EdotExperiment,
    toolkit: Toolkit,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """
    The initial screening of the edot solution
    Per experiment:
    0. Apply correction factor to the programmed volumes
    1. pedotdeposition
    2. pedotbleaching
    3. pedotcoloring

    """
    # Apply correction factor to the programmed volumes
    toolkit.global_logger.info("Applying correction factor to the programmed volumes")
    for solution in instructions.solutions:
        instructions.solutions_corrected[solution] = correction_factor(
            instructions.solutions[solution],
            solution_selector(
                stock_vials,
                solution,  # The solution name
                instructions.solutions[solution],  # The volume of the solution
            ).viscosity_cp,
        )

    # Run the experiment based on its experiment type
    # if instructions.process_type in [0,1]:
    #     pedotdeposition(
    #         instructions=instructions,
    #         toolkit=toolkit,
    #         stock_vials=stock_vials,
    #         waste_vials=waste_vials,
    #     )
    #     pedotbleaching(
    #         instructions=instructions,
    #         toolkit=toolkit,
    #         stock_vials=stock_vials,
    #         waste_vials=waste_vials,
    #     )
    #     pedotcoloring(
    #         instructions=instructions,
    #         toolkit=toolkit,
    #         stock_vials=stock_vials,
    #         waste_vials=waste_vials,
    #     )

    # elif instructions.process_type == 2:
    #     pedotbleaching(
    #         instructions=instructions,
    #         toolkit=toolkit,
    #         stock_vials=stock_vials,
    #         waste_vials=waste_vials,
    #     )
    #     pedotcoloring(
    #         instructions=instructions,
    #         toolkit=toolkit,
    #         stock_vials=stock_vials,
    #         waste_vials=waste_vials,
    #     )


    # elif instructions.process_type == 3:
    #     pedotcoloring(
    #         instructions=instructions,
    #         toolkit=toolkit,
    #         stock_vials=stock_vials,
    #         waste_vials=waste_vials,
    #     )
    pedotdeposition(
            instructions=instructions,
            toolkit=toolkit,
            stock_vials=stock_vials,
            waste_vials=waste_vials,
        )
    pedotbleaching(
        instructions=instructions,
        toolkit=toolkit,
        stock_vials=stock_vials,
        waste_vials=waste_vials,
    )
    pedotcoloring(
        instructions=instructions,
        toolkit=toolkit,
        stock_vials=stock_vials,
        waste_vials=waste_vials,
    )

    instructions.set_status_and_save(ExperimentStatus.COMPLETE)


def pedotdeposition(
    instructions: EdotExperiment,
    toolkit: Toolkit,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """
    0. Imaging the well
    1. Depositing EDOT into well
    2. Moving electrode to well
    3. Performing CA
    4. Rinsing electrode
    5. Clearing well contents into waste
    6. Flushing the pipette tip
    7. Rinsing the well 4x with rinse
    8. Take after image

    Args:
        instructions (EchemExperimentBase): _description_
        toolkit (Toolkit): _description_
        stock_vials (Sequence[StockVial]): _description_
        waste_vials (Sequence[WasteVial]): _description_
    """
    toolkit.global_logger.info("Running experimnet %s part 1", instructions.experiment_id)
    toolkit.global_logger.info("0. Imaging the well")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(toolkit, instructions, "BeforeDeposition")

    instructions.set_status_and_save(new_status=ExperimentStatus.DEPOSITING)
    ## Deposit the experiment solution into the well
    toolkit.global_logger.info("1. Depositing EDOT into well: %s", instructions.well_id)

    # Determine the available edot stock vials and their concentrations
    # Calculate the combination of the available edot vials that will give the
    # desired concentration at the desired volume. Calculations are done using units of 20 ul
    # as that is our minimum pipetting volume. However once the calculations are done, the
    # actual volume to be pipetted is calculated using the correction factor.

    edot_vials = [
        vial
        for vial in stock_vials
        if vial.name == "edot" and vial.volume > 0
    ]

    # If there are no edot vials, raise an error
    if not edot_vials:
        toolkit.global_logger.error("No edot vials available")
        raise ValueError("No edot vials available")

    # There are one or more vials, let's calculate the volume to be pipetted from each
    # vial to get the desired volume and concentration
    edot_vial_volumes, deviation = solve_vials_ilp(

        # Concentrations of each vial in mM
        vial_concentrations=[vial.concentration for vial in edot_vials],

        # Total volume to achieve in uL
        v_total=instructions.solutions["edot"],

        # Target concentration in mM
        c_target=instructions.edot_concentration,
    )

    # If the volumes are not found, raise an error
    if edot_vial_volumes is None:
        raise ValueError("No solution found for edot vial volumes")
    toolkit.global_logger.info(
        "Volumes to draw from each edot vial: %s uL", edot_vial_volumes
    )
    toolkit.global_logger.info(
        "Deviation from target concentration: %s mM", deviation
    )

    # Pipette the calculated volumes from the edot vials into the well
    for vial, volume in zip(edot_vials, edot_vial_volumes):
        volume = correction_factor(volume, vial.viscosity_cp)
        forward_pipette_v2(
            volume=volume,
            from_vessel=vial,
            to_vessel=toolkit.wellplate.wells[instructions.well_id],
            pump=toolkit.pump,
            mill=toolkit.mill,
            pumping_rate=instructions.pumping_rate,
        )

    ## Move the electrode to the well
    toolkit.global_logger.info("2. Moving electrode to well: %s", instructions.well_id)

    ## Move the electrode to the well
    # Move the electrode to above the well
    toolkit.mill.safe_move(
        x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
        y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
        z_coord=toolkit.wellplate.z_top,
        instrument=Instruments.ELECTRODE,
    )
    # Set the feed rate to 1000 to avoid splashing
    toolkit.mill.set_feed_rate(100)
    toolkit.mill.safe_move(
        x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
        y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
        z_coord=toolkit.wellplate.echem_height,
        instrument=Instruments.ELECTRODE,
    )
    # Set the feed rate back to 2000
    toolkit.mill.set_feed_rate(2000)

    toolkit.global_logger.info("3. Performing CA deposition")
    try:
        chrono_amp(instructions, file_tag="CA_deposition")

    except (OCPFailure, CAFailure, CVFailure, DepositionFailure) as e:
        toolkit.global_logger.error("Error occurred during chrono_amp: %s", str(e))
        raise e
    except Exception as e:
        toolkit.global_logger.error("Unknown error occurred during chrono_amp: %s", str(e))
        raise e

    # Rinse electrode
    toolkit.global_logger.info("4. Rinsing electrode")
    instructions.set_status_and_save(new_status=ExperimentStatus.ERINSING)
    toolkit.mill.rinse_electrode(3)

    # Clear the well
    toolkit.global_logger.info("5. Clearing well contents into waste")
    instructions.set_status_and_save(ExperimentStatus.CLEARING)
    forward_pipette_v2(
        volume=toolkit.wellplate.wells[instructions.well_id].volume,
        from_vessel=toolkit.wellplate.wells[instructions.well_id],
        to_vessel=waste_selector(
            waste_vials,
            "waste",
            toolkit.wellplate.wells[instructions.well_id].volume,
        ),
        pump=toolkit.pump,
        mill=toolkit.mill,
    )

    toolkit.global_logger.info("6. Flushing the pipette tip")
    instructions.set_status_and_save(ExperimentStatus.FLUSHING)
    flush_v2(
        waste_vials=waste_vials,
        stock_vials=stock_vials,
        flush_solution_name="rinse",
        mill=toolkit.mill,
        pump=toolkit.pump,
        flush_count=1,
    )

    toolkit.global_logger.info("7. Rinsing the well 4x with rinse")
    instructions.set_status_and_save(ExperimentStatus.RINSING)
    for i in range(4):
        # Pipette the rinse solution into the well
        toolkit.global_logger.info("Rinse %d of 4", i + 1)
        forward_pipette_v2(
            volume=correction_factor(120),
            from_vessel=solution_selector(
                stock_vials,
                "rinse",
                correction_factor(120),
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
            volume=correction_factor(120),
            from_vessel=toolkit.wellplate.wells[instructions.well_id],
            to_vessel=waste_selector(
                waste_vials,
                "waste",
                correction_factor(120),
            ),
            pump=toolkit.pump,
            mill=toolkit.mill,
        )

    toolkit.global_logger.info("8. Take after image")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(
        toolkit=toolkit,
        instructions=instructions,
        step_description="AfterDeposition",
    )
    instructions.process_type = 2
    instructions.priority = 1
    toolkit.global_logger.info("PEDOT deposition complete\n\n")


def pedotbleaching(
    instructions: EdotExperiment,
    toolkit: Toolkit,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """
    0. Imaging the well
    1. Depositing liclo4 into well
    2. Moving electrode to well
    3. Performing CA
    4. Rinsing electrode
    5. Clearing well contents into waste
    6. Flushing the pipette tip
    7. Take after image

    Args:
        instructions (EchemExperimentBase): _description_
        toolkit (Toolkit): _description_
        stock_vials (Sequence[StockVial]): _description_
        waste_vials (Sequence[WasteVial]): _description_
    """
    toolkit.global_logger.info("Running experiment %s part 2", instructions.experiment_id)
    toolkit.global_logger.info("0. Imaging the well")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(toolkit, instructions, "BeforeBleaching")

    instructions.set_status_and_save(new_status=ExperimentStatus.DEPOSITING)
    ## Deposit the experiment solution into the well
    toolkit.global_logger.info("1. Depositing liclo4 into well: %s", instructions.well_id)
    forward_pipette_v2(
        volume=correction_factor(120),
        from_vessel=solution_selector(
            stock_vials,
            "liclo4",
            correction_factor(120), #hard code this
        ),
        to_vessel=toolkit.wellplate.wells[instructions.well_id],
        pump=toolkit.pump,
        mill=toolkit.mill,
        pumping_rate=instructions.pumping_rate,
    )

    ## Move the electrode to the well
    toolkit.global_logger.info("2. Moving electrode to well: %s", instructions.well_id)

    ## Move the electrode to the well
    # Move the electrode to above the well
    toolkit.mill.safe_move(
        x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
        y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
        z_coord=toolkit.wellplate.z_top,
        instrument=Instruments.ELECTRODE,
    )
    # Set the feed rate to 1000 to avoid splashing
    toolkit.mill.set_feed_rate(100)
    toolkit.mill.safe_move(
        x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
        y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
        z_coord=toolkit.wellplate.echem_height,
        instrument=Instruments.ELECTRODE,
    )
    # Set the feed rate back to 2000
    toolkit.mill.set_feed_rate(2000)

    toolkit.global_logger.info("3. Performing CA")
    try:
        chrono_amp_edot_bleaching(instructions)
    except Exception as e:
        toolkit.global_logger.error(
            "Error occurred during chrono_amp bleaching: %s", str(e)
        )
        raise e

    # Rinse electrode
    toolkit.global_logger.info("4. Rinsing electrode")
    instructions.set_status_and_save(new_status=ExperimentStatus.ERINSING)
    toolkit.mill.rinse_electrode(3)

    # Clear the well
    toolkit.global_logger.info("5. Clearing well contents into waste")
    instructions.set_status_and_save(ExperimentStatus.CLEARING)
    forward_pipette_v2(
        volume=toolkit.wellplate.wells[instructions.well_id].volume,
        from_vessel=toolkit.wellplate.wells[instructions.well_id],
        to_vessel=waste_selector(
            waste_vials,
            "waste",
            toolkit.wellplate.wells[instructions.well_id].volume,
        ),
        pump=toolkit.pump,
        mill=toolkit.mill,
    )

    toolkit.global_logger.info("6. Flushing the pipette tip")
    instructions.set_status_and_save(ExperimentStatus.FLUSHING)
    flush_v2(
        waste_vials=waste_vials,
        stock_vials=stock_vials,
        flush_solution_name="rinse",
        mill=toolkit.mill,
        pump=toolkit.pump,
        flush_count=1,
    )

    toolkit.global_logger.info("7. Take after image")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(
        toolkit=toolkit,
        instructions=instructions,
        step_description="AfterBleaching",
    )

    instructions.process_type = 3
    instructions.priority = 0
    toolkit.global_logger.info("PEDOT bleaching complete\n\n")


def pedotcoloring(
    instructions: EdotExperiment,
    toolkit: Toolkit,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """
    0. Imaging the well
    1. Depositing liclo4 into well
    2. Moving electrode to well
    3. Performing CA
    4. Rinsing electrode
    5. Clearing well contents into waste
    6. Flushing the pipette tip
    7. Take image of well

    Args:
        instructions (EchemExperimentBase): _description_
        toolkit (Toolkit): _description_
        stock_vials (Sequence[StockVial]): _description_
        waste_vials (Sequence[WasteVial]): _description_
    """
    toolkit.global_logger.info("Running experiment %s part 3", instructions.experiment_id)
    toolkit.global_logger.info("0. Imaging the well")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(toolkit, instructions, "BeforeColoring")

    instructions.set_status_and_save(new_status=ExperimentStatus.DEPOSITING)
    ## Deposit the experiment solution into the well
    toolkit.global_logger.info(
        "1. Depositing liclo4 into well: %s", instructions.well_id
    )
    forward_pipette_v2(
        volume=correction_factor(120),
        from_vessel=solution_selector(
            stock_vials,
            "liclo4",
            correction_factor(120),
        ),
        to_vessel=toolkit.wellplate.wells[instructions.well_id],
        pump=toolkit.pump,
        mill=toolkit.mill,
        pumping_rate=instructions.pumping_rate,
    )

    ## Move the electrode to the well
    toolkit.global_logger.info("2. Moving electrode to well: %s", instructions.well_id)
    try:
        ## Move the electrode to the well
        # Move the electrode to above the well
        toolkit.mill.safe_move(
            x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
            y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
            z_coord=toolkit.wellplate.z_top,
            instrument=Instruments.ELECTRODE,
        )
        # Set the feed rate to 1000 to avoid splashing
        toolkit.mill.set_feed_rate(100)
        toolkit.mill.safe_move(
            x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
            y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
            z_coord=toolkit.wellplate.echem_height,
            instrument=Instruments.ELECTRODE,
        )
        # Set the feed rate back to 2000
        toolkit.mill.set_feed_rate(2000)

        toolkit.global_logger.info("3. Performing CA")
        try:
            chrono_amp_edot_coloring(instructions)
        except Exception as e:
            toolkit.global_logger.error(
                "Error occurred during chrono_amp coloring: %s", str(e)
            )
            raise e
    finally:
        pass

    # Rinse electrode
    toolkit.global_logger.info("4. Rinsing electrode")
    instructions.set_status_and_save(new_status=ExperimentStatus.ERINSING)
    toolkit.mill.rinse_electrode(3)

    # Clear the well
    toolkit.global_logger.info("5. Clearing well contents into waste")
    instructions.set_status_and_save(ExperimentStatus.CLEARING)
    forward_pipette_v2(
        volume=toolkit.wellplate.wells[instructions.well_id].volume,
        from_vessel=toolkit.wellplate.wells[instructions.well_id],
        to_vessel=waste_selector(
            waste_vials,
            "waste",
            toolkit.wellplate.wells[instructions.well_id].volume,
        ),
        pump=toolkit.pump,
        mill=toolkit.mill,
    )

    toolkit.global_logger.info("6. Flushing the pipette tip")
    instructions.set_status_and_save(ExperimentStatus.FLUSHING)
    flush_v2(
        waste_vials=waste_vials,
        stock_vials=stock_vials,
        flush_solution_name="rinse",
        mill=toolkit.mill,
        pump=toolkit.pump,
        flush_count=3,
    )

    toolkit.global_logger.info("7. Take image of well")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(
        toolkit=toolkit,
        instructions=instructions,
        step_description="AfterColoring",
    )
    instructions.process_type = 4
    instructions.priority = 0
    toolkit.global_logger.info("PEDOT coloring complete\n\n")


def pedotcv(
    instructions: EdotExperiment,
    toolkit: Toolkit,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """
    0. Imaging the well
    1. Depositing liclo4 into well
    2. Moving electrode to well
    3. Performing CV
    4. Rinsing electrode
    5. Clearing well contents into waste
    6. Flushing the pipette tip
    7. Take image of well
    8. Rinsing the well 4x with rinse
    9. Take end image

    Args:
        instructions (EchemExperimentBase): _description_
        toolkit (Toolkit): _description_
        stock_vials (Sequence[StockVial]): _description_
        waste_vials (Sequence[WasteVial]): _description_
    """
    toolkit.global_logger.info("Running experiment %s part 4", instructions.experiment_id)
    toolkit.global_logger.info("0. Imaging the well")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(toolkit, instructions, "BeforeCharacterizing")

    instructions.set_status_and_save(new_status=ExperimentStatus.DEPOSITING)
    ## Deposit the experiment solution into the well
    toolkit.global_logger.info(
        "1. Depositing liclo4 into well: %s", instructions.well_id
    )
    forward_pipette_v2(
        volume=instructions.solutions_corrected["liclo4"],
        from_vessel=solution_selector(
            stock_vials,
            "liclo4",
            instructions.solutions_corrected["liclo4"],
        ),
        to_vessel=toolkit.wellplate.wells[instructions.well_id],
        pump=toolkit.pump,
        mill=toolkit.mill,
        pumping_rate=instructions.pumping_rate,
    )

    ## Move the electrode to the well
    toolkit.global_logger.info("2. Moving electrode to well: %s", instructions.well_id)
    try:
        ## Move the electrode to the well
        # Move the electrode to above the well
        toolkit.mill.safe_move(
            x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
            y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
            z_coord=toolkit.wellplate.z_top,
            instrument=Instruments.ELECTRODE,
        )
        # Set the feed rate to 1000 to avoid splashing
        toolkit.mill.set_feed_rate(100)
        toolkit.mill.safe_move(
            x_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "x"),
            y_coord=toolkit.wellplate.get_coordinates(instructions.well_id, "y"),
            z_coord=toolkit.wellplate.echem_height,
            instrument=Instruments.ELECTRODE,
        )
        # Set the feed rate back to 2000
        toolkit.mill.set_feed_rate(2000)

        toolkit.global_logger.info("3. Performing CV")
        try:
            cyclic_volt_edot_characterizing(instructions)
        except Exception as e:
            toolkit.global_logger.error("Error occurred during chrono_amp: %s", str(e))
            raise e
    finally:
        toolkit.global_logger.info("4. Rinsing electrode")
        instructions.set_status_and_save(new_status=ExperimentStatus.ERINSING)
        toolkit.mill.rinse_electrode(3)

    # Clear the well
    toolkit.global_logger.info("5. Clearing well contents into waste")
    instructions.set_status_and_save(ExperimentStatus.CLEARING)
    forward_pipette_v2(
        volume=toolkit.wellplate.wells[instructions.well_id].volume,
        from_vessel=toolkit.wellplate.wells[instructions.well_id],
        to_vessel=waste_selector(
            waste_vials,
            "waste",
            toolkit.wellplate.wells[instructions.well_id].volume,
        ),
        pump=toolkit.pump,
        mill=toolkit.mill,
    )

    toolkit.global_logger.info("6. Flushing the pipette tip")
    instructions.set_status_and_save(ExperimentStatus.FLUSHING)
    flush_v2(
        waste_vials=waste_vials,
        stock_vials=stock_vials,
        flush_solution_name="rinse",
        mill=toolkit.mill,
        pump=toolkit.pump,
        flush_count=3,
    )

    toolkit.global_logger.info("7. Take image of well")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(
        toolkit=toolkit,
        instructions=instructions,
        step_description="AfterCharacterizing",
    )
    toolkit.global_logger.info("8. Rinsing the well 4x with rinse")
    instructions.set_status_and_save(ExperimentStatus.RINSING)
    for i in range(4):
        # Pipette the rinse solution into the well
        toolkit.global_logger.info("Rinse %d of 4", i + 1)
        forward_pipette_v2(
            volume=correction_factor(120),
            from_vessel=solution_selector(
                stock_vials,
                "rinse",
                correction_factor(120),
            ),
            to_vessel=toolkit.wellplate.wells[instructions.well_id],
            pump=toolkit.pump,
            mill=toolkit.mill,
            pumping_rate=toolkit.pump.max_pump_rate,
        )
        # Clear the well
        forward_pipette_v2(
            volume=correction_factor(120),
            from_vessel=toolkit.wellplate.wells[instructions.well_id],
            to_vessel=waste_selector(
                waste_vials,
                "waste",
                correction_factor(120),
            ),
            pump=toolkit.pump,
            mill=toolkit.mill,
        )

    toolkit.global_logger.info("9. Take end image")
    instructions.set_status_and_save(ExperimentStatus.IMAGING)
    image_well(
        toolkit=toolkit,
        instructions=instructions,
        step_description="EndImage",
    )
    instructions.process_type = 99
    instructions.priority = 99
    toolkit.global_logger.info("PEDOT characterizing complete\n\n")
