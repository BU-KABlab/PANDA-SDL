"""
The controller is responsible for the following:
    - Running the scheduler and retriving the next experiment to run
    - checking the state of the system (vials, wells, etc.) 
    - Running the experiment (passing the experiment, system state, and instruments)
    - Recieve data from the experiment, and store it in the database
    - Update system state (vials, wells, etc.)
    - Running the analyzer

Additionally controller should be able to:
    - Reset the well statuses
    - Update the vial statuses
"""

# pylint: disable=line-too-long, broad-exception-caught
import importlib
import os
import sys
import time
from pathlib import Path
from typing import Sequence

from slack_sdk.errors import (BotUserAccessError, SlackApiError,
                              SlackClientConfigurationError, SlackClientError,
                              SlackClientNotConnectedError,
                              SlackObjectFormationError, SlackRequestError,
                              SlackTokenRotationError)

from . import actions
from .analyzer.pedot import pedot_analyzer
from .analyzer.pedot import run_ml_model as pedot_ml_model
from .config.config import RANDOM_FLAG, read_testing_config
from .actions import CAFailure, CVFailure, DepositionFailure, OCPFailure
from .errors import (NoExperimentFromModel, ProtocolNotFoundError,
                     ShutDownCommand, WellImportError)
from .experiment_class import (ExperimentBase, ExperimentResult,
                               ExperimentStatus, select_specific_result)
from .instrument_toolkit import Toolkit
from .log_tools import e_panda_logger as logger
from .mill_control import Mill, MockMill
from .obs_controls import MockOBSController, OBSController
from .syringepump import MockPump, SyringePump
from .sartorius_local import Scale
from .sartorius_local.mock import Scale as MockScale
from .scheduler import Scheduler
from .slack_tools.SlackBot import SlackBot
from .sql_tools import sql_protocol_utilities, sql_system_state, sql_wellplate
from .utilities import SystemState
from .vials import (StockVial, Vial2, WasteVial,
                    update_vial_state_files, read_vials)
from .wellplate import Wellplate

# set up slack globally so that it can be used in the main function and others

TESTING = read_testing_config()


def main(
    use_mock_instruments: bool = TESTING,
    one_off: bool = False,
    al_campaign_length: int = None,
):
    """
    Main function

    Args:
    ----
        use_mock_instruments (bool, optional): Whether to use mock instruments. Defaults to False.
        one_off (bool, optional): Whether to run one experiment and then exit. Defaults to False.
    """
    # import exp_b_pipette_contamination_assessment_protocol as exp_b
    # import protocols
    slack = SlackBot()
    if os.environ.get("PANDA_SDL_TESTING") == "1" or os.environ["PANDA_SDL_USE_OBS"] == '0':
        obs = MockOBSController()
    else:
        obs = OBSController()
    ## Reset the logger to log to the ePANDA.log file and format
    actions.apply_log_filter()
    # print(printpanda())
    print("Starting ePANDA...")
    slack.test = use_mock_instruments
    slack.send_slack_message("alert", "ePANDA is starting up")
    toolkit = None
    al_campaign_iteration = 0
    # Everything runs in a try block so that we can close out of the serial connections if something goes wrong
    try:
        obs.place_text_on_screen("ePANDA is starting up")
        obs.start_recording()
        new_experiment = None
        # Connect to equipment
        toolkit = connect_to_instruments(use_mock_instruments)
        logger.info("Connected to instruments")
        slack.send_slack_message("alert", "ePANDA has connected to equipment")
        obs.place_text_on_screen("ePANDA has connected to equipment")
        ## Initialize scheduler
        scheduler = Scheduler()

        ## Establish state of system - we do this each time because each experiment changes the system state
        stock_vials, waste_vials, toolkit.wellplate = establish_system_state()

        ## Check that the pipette is empty, if not dispose of full volume into waste
        if toolkit.pump.pipette.volume > 0:
            obs.place_text_on_screen("Pipette is not empty, purging into waste")
            actions.purge_pipette(
                waste_vials=waste_vials,
                mill=toolkit.mill,
                pump=toolkit.pump,
            )
        # Flush the pipette tip with water before we start
        obs.place_text_on_screen("Initial flushing of pipette tip")
        logger.info("Flushing pipette tip")
        actions.flush_v2(
            stock_vials=stock_vials,
            waste_vials=waste_vials,
            flush_solution_name="rinse",
            flush_volume=140,
            pump=toolkit.pump,
            mill=toolkit.mill,
        )
        ## Update the system state with new vial and wellplate information
        update_vial_state_files(stock_vials, waste_vials, 'STOCK_STATUS', 'WASTE_STATUS')

        # experiemnt loop
        while True:
            ## Reset the logger to log to the ePANDA.log file and format
            obs.place_text_on_screen("")
            actions.apply_log_filter()
            sql_system_state.set_system_status(SystemState.BUSY)
            ## Establish state of system - we do this each time because each experiment changes the system state
            stock_vials, waste_vials, toolkit.wellplate = establish_system_state()

            ## Ask the scheduler for the next experiment
            new_experiment, _ = scheduler.read_next_experiment_from_queue(
                random_pick=RANDOM_FLAG
            )

            while new_experiment is None:
                sql_system_state.set_system_status(
                    SystemState.PAUSE, "Waiting for new experiments"
                )
                # scheduler.check_inbox()
                new_experiment, _ = scheduler.read_next_experiment_from_queue()
                if new_experiment is not None:
                    slack.send_slack_message(
                        "alert", f"New experiment {new_experiment.experiment_id} found"
                    )
                    break  # break out of the while new experiment is None loop

                # If the AL campaign length is set, and we have not reached the end of the campaign, generate another experiment
                if (
                    al_campaign_length is not None
                    and al_campaign_iteration < al_campaign_length
                ):
                    # We run the model on with experiments that have already been run
                    sql_system_state.set_system_status(
                        SystemState.BUSY, "Running ML model"
                    )
                    next_exp_id = pedot_ml_model()
                    new_experiment, _ = scheduler.read_next_experiment_from_queue()
                    if new_experiment is not None:
                        slack.send_slack_message(
                            "alert",
                            f"New experiment generated from existing data {new_experiment.experiment_id}",
                        )
                        al_campaign_iteration += 1
                        break  # break out of the while new experiment is None loop
                    else:
                        slack.send_slack_message(
                            "alert", "No new experiment generated from existing data"
                        )
                        raise NoExperimentFromModel()
                logger.info(
                    "No new experiments to run...waiting a minute for new experiments"
                )
                slack.send_slack_message(
                    "alert",
                    "No new experiments to run...waiting a minute for new experiments",
                )
                sql_system_state.set_system_status(
                    SystemState.PAUSE, "Waiting for new experiments"
                )
                system_status_loop(slack)

            ## confirm that the new experiment is a valid experiment object
            if not isinstance(new_experiment, ExperimentBase):
                logger.error("The experiment object is not valid")
                slack.send_slack_message(
                    "alert",
                    "An invalid experiment object was passed to the controller",
                )
                break  # break out of the while True loop

            sql_system_state.set_system_status(SystemState.BUSY)
            ## Initialize a results object
            new_experiment.results = ExperimentResult(
                experiment_id=new_experiment.experiment_id,
                well_id=new_experiment.well_id,
            )
            ## Check that there is enough volume in the stock vials to run the experiment
            if not check_stock_vials(new_experiment, stock_vials):
                error_message = f"Experiment {new_experiment.experiment_id} cannot be run because there is not enough volume in the stock vials"
                slack.send_slack_message(
                    "alert",
                    error_message,
                )
                logger.error(error_message)

                new_experiment.priority = 999
                scheduler.update_experiment_info(
                    new_experiment, "priority"
                )  # update the experiment file with the new status and priority
                scheduler.update_experiment_queue_priority(
                    new_experiment.experiment_id, new_experiment.priority
                )
                new_experiment.set_status_and_save(ExperimentStatus.ERROR)
                break  # break out of the while True loop

            # Announce the experiment
            pre_experiment_status_msg = (
                f"Running experiment {new_experiment.experiment_id}"
            )
            logger.info(pre_experiment_status_msg)
            slack.send_slack_message("alert", pre_experiment_status_msg)

            ## Update the experiment status to running
            new_experiment.plate_id = toolkit.wellplate.plate_id
            new_experiment.well = toolkit.wellplate.wells[new_experiment.well_id]
            new_experiment.well.plate_id = toolkit.wellplate.plate_id
            new_experiment.well.experiment_id = new_experiment.experiment_id
            new_experiment.well.project_id = new_experiment.project_id
            new_experiment.set_status_and_save(ExperimentStatus.RUNNING)
            # scheduler.change_well_status(
            #     wellplate.wells[new_experiment.well_id], new_experiment
            # )
            # With the experiment now running, remove it from the queue
            # Any errors that occur after this point will be caught and the experiment will be marked as errored
            # scheduler.remove_from_queue(new_experiment)

            ## Run the experiment
            actions.apply_log_filter(
                new_experiment.experiment_id,
                new_experiment.well_id,
                str(new_experiment.project_id)
                + "."
                + str(new_experiment.project_campaign_id),
                test=use_mock_instruments,
            )

            logger.info("Beginning experiment %d", new_experiment.experiment_id)

            # Get the protocol entry
            protocol_entry: sql_protocol_utilities.ProtocolEntry = (
                sql_protocol_utilities.select_protocol_by_id(new_experiment.protocol_id)
            )

            # Convert the file path to a module name
            module_name = (
                ("protocols." + protocol_entry.filepath).replace("/", ".").rstrip(".py")
            )

            # Import the module
            protocol_module = importlib.import_module(module_name)

            # Get the main function from the module
            protocol_function = getattr(protocol_module, "main")
            protocol_function(
                instructions=new_experiment,
                toolkit=toolkit,
                stock_vials=stock_vials,
                waste_vials=waste_vials,
            )

            ## Update the experiment status to complete
            # new_experiment.set_status_and_save(ExperimentStatus.COMPLETE)

            # Share any results images with the slack data channel
            share_to_slack(new_experiment)

            ## Reset the logger to log to the ePANDA.log file and format after the experiment is complete
            actions.apply_log_filter()

            ## With returned experiment and results, update the experiment status and post the final status
            post_experiment_status_msg = f"Experiment {new_experiment.experiment_id} ended with status {new_experiment.status.value}"
            logger.info(post_experiment_status_msg)
            # slack.send_slack_message("alert", post_experiment_status_msg)

            new_experiment.set_status_and_save(ExperimentStatus.SAVING)
            scheduler.save_results(new_experiment)
            experiment_id = new_experiment.experiment_id

            if not TESTING:
                # Analyze the experiment (will handle if in testing)
                new_experiment.set_status_and_save(ExperimentStatus.ANALYZING)
                pedot_analyzer(experiment_id)

                next_exp_id = None
                # If the AL campaign length is set, and we have not reached the end of the campaign, generate another experiment
                if (
                    al_campaign_length is not None
                    and al_campaign_iteration < al_campaign_length
                ):
                    next_exp_id = pedot_ml_model()
                    al_campaign_iteration += 1

                # Share the analysis results with slack
                share_analysis_to_slack(experiment_id, next_exp_id, slack)

            new_experiment.set_status_and_save(ExperimentStatus.COMPLETE)
            ## Clean up
            new_experiment = None  # reset new_experiment to None so that we can check the queue again
            ## Update the system state with new vial and wellplate information
            toolkit.pump.pipette.reset_contents()
            update_vial_state_files(
                stock_vials, waste_vials, 'STOCK_STATUS', 'WASTE_STATUS'
            )
            if toolkit.pump.pipette.volume > 0 and toolkit.pump.pipette.volume_ml < 1:
                # assume unreal volume, not actually solution, set to 0
                toolkit.pump.update_pipette_volume(toolkit.pump.pipette.volume_ml)
            if one_off:
                break  # break out of the while True loop

            if SystemState.SHUTDOWN in sql_system_state.select_system_status(2):
                slack.send_slack_message("alert", "ePANDA is shutting down")
                raise ShutDownCommand

            # check for paused status and hold until status changes to resume
            system_status_loop(slack)
    except (
        OCPFailure,
        DepositionFailure,
        CVFailure,
        CAFailure,
    ) as error:
        if new_experiment is not None:
            new_experiment.set_status_and_save(ExperimentStatus.ERROR)
            share_to_slack(new_experiment)
        sql_system_state.set_system_status(SystemState.ERROR)
        # scheduler.change_well_status(
        #     toolkit.wellplate.wells[new_experiment.well_id], new_experiment
        # )
        logger.error(error)
        slack.send_slack_message("alert", f"ePANDA encountered an error: {error}")

        slack.take_screenshot('alert', 'webcam')
        slack.take_screenshot('alert', 'vials')
        slack.send_slack_message("alert", "Please check the terminal to move the mill to the rest position")
        input("Press enter to continue")

        raise error  # raise error to go to finally. We do not want the program to continue if there is an electochemistry error as it usually indicates a hardware or solutions issue

    except ProtocolNotFoundError as error:
        if new_experiment is not None:
            new_experiment.set_status_and_save(ExperimentStatus.ERROR)
        sql_system_state.set_system_status(SystemState.ERROR)
        logger.error(error)
        slack.send_slack_message("alert", f"ePANDA encountered an error: {error}")
        raise error
    except ShutDownCommand as error:
        if new_experiment is not None:
            new_experiment.set_status_and_save(ExperimentStatus.ERROR)
        sql_system_state.set_system_status(SystemState.OFF)
        # scheduler.change_well_status(
        #     toolkit.wellplate.wells[new_experiment.well_id], new_experiment
        # )
        logger.info("User commanded shutting down of ePANDA")
        raise ShutDownCommand from error  # raise error to go to finally.
        # This was triggered by the user to indicate they want to stop the program
    
    except KeyboardInterrupt as exc:
        if new_experiment is not None:
            new_experiment.set_status_and_save(ExperimentStatus.ERROR)
        sql_system_state.set_system_status(SystemState.ERROR)
        # scheduler.change_well_status(
        #     toolkit.wellplate.wells[new_experiment.well_id], new_experiment
        # )
        logger.info("Keyboard interrupt detected")
        slack.send_slack_message("alert", "ePANDA was interrupted by the user")
        raise KeyboardInterrupt from exc  # raise error to go to finally. This was triggered by the user to indicate they want to stop the program

    except Exception as error:
        if new_experiment is not None:
            new_experiment.set_status_and_save(ExperimentStatus.ERROR)
        sql_system_state.set_system_status(SystemState.ERROR)
        # scheduler.change_well_status(
        #     toolkit.wellplate.wells[new_experiment.well_id], new_experiment
        # )

        logger.error(error)
        logger.exception(error)
        slack.send_slack_message("alert", f"ePANDA encountered an error: {error}")
        raise error  # raise error to go to finally. If we don't know what caused an error we don't want to continue

    finally:
        if new_experiment is not None:
            ## Update location of experiment instructions and save results
            # scheduler.update_experiment_file(new_experiment)
            # scheduler.update_experiment_location(new_experiment)
            scheduler.save_results(new_experiment)
            share_to_slack(new_experiment)

        # Save the current wellplate
        # if toolkit.wellplate:
        #     toolkit.wellplate.save_wells_to_db()  # load a "new" wellplate to save and update wells
        # close out of serial connections
        toolkit.mill.rest_electrode()
        if toolkit is not None:
            disconnect_from_instruments(toolkit)
        obs.place_text_on_screen("")
        obs.stop_recording()
        sql_system_state.set_system_status(SystemState.IDLE)
        slack.send_slack_message("alert", "ePANDA is shutting down...goodbye")
        print("ePANDA is shutting down...returning to main menu...goodbye")


def establish_system_state() -> (
    tuple[Sequence[StockVial], Sequence[WasteVial], Wellplate]
):
    """
    Establish state of system
    Returns:
        stock_vials (list[Vial]): list of stock vials
        waste_vials (list[Vial]): list of waste vials
        wellplate (wellplate_module.Wells): wellplate object
    """
    slack = SlackBot()
    stock_vials, waste_vials = read_vials()
    #stock_vials = get_current_vials("stock")
    #waste_vials = get_current_vials("waste")
    stock_vials_only = [vial for vial in stock_vials if isinstance(vial, StockVial)]
    waste_vials_only = [vial for vial in waste_vials if isinstance(vial, WasteVial)]
    wellplate = Wellplate()
    logger.info("System state reestablished")

    ## read through the stock vials and log their name, contents, and volume
    for vial in stock_vials_only:
        logger.debug(
            "Stock vial %s contains %s with volume %d",
            vial.name,
            vial.contents,
            vial.volume,
        )

    ## if any stock vials are empty, send a slack message prompting the user to refill them and confirm if program should continue
    empty_stock_vials = [vial for vial in stock_vials_only if vial.volume < 1000]
    if len(empty_stock_vials) > 0:
        slack.send_slack_message(
            "alert",
            "The following stock vials are low or empty: "
            + ", ".join([vial.name for vial in empty_stock_vials]),
        )
        slack.send_slack_message(
            "alert",
            "Please refill the stock vials and confirm in the terminal that the program should continue",
        )
        input(
            "Confirm that the program should continue by pressing enter or ctrl+c to exit"
        )
        slack.send_slack_message("alert", "The program is continuing")

    ## read through the waste vials and log their name, contents, and volume
    for vial in waste_vials_only:
        logger.debug(
            "Waste vial %s contains %s with volume %d",
            vial.name,
            vial.contents,
            vial.volume,
        )

    ## if any waste vials are full, send a slack message prompting the user to empty them and confirm if program should continue
    full_waste_vials = [vial for vial in waste_vials_only if vial.volume > 19000]
    if len(full_waste_vials) == len(waste_vials_only):
        slack.send_slack_message(
            "alert",
            "The following waste vials are full: "
            + ", ".join([vial.name for vial in full_waste_vials]),
        )
        slack.send_slack_message(
            "alert",
            "Please empty the waste vials and confirm in the terminal that the program should continue",
        )
        input(
            "Confirm that the program should continue by pressing enter or ctrl+c to exit"
        )
        slack.send_slack_message("alert", "The program is continuing")

    ## read the wellplate json and log the status of each well in a grid
    number_of_clear_wells = 0
    number_of_wells = 0

    # Query the number of clear wells in well_status
    number_of_clear_wells = sql_wellplate.get_number_of_clear_wells()
    number_of_wells = sql_wellplate.get_number_of_wells()
    ## check that wellplate has the appropriate number of wells
    if number_of_wells != len(wellplate.wells):
        logger.error(
            "Wellplate status file does not have the correct number of wells. File may be corrupted"
        )
        raise WellImportError
    logger.info("There are %d clear wells", number_of_clear_wells)
    if number_of_clear_wells == 0:
        slack.send_slack_message("alert", "There are no clear wells on the wellplate")
        slack.send_slack_message(
            "alert",
            "Please replace the wellplate and restart the program from the main menu",
        )
        raise ShutDownCommand

    return stock_vials_only, waste_vials_only, wellplate


def check_stock_vials(experiment: ExperimentBase, stock_vials: Sequence[Vial2]) -> bool:
    """
    Check that there is enough volume in the stock vials to run the experiment

    Args:
        experiment (Experiment): The experiment to be run
        stock_vials (list[Vial]): The stock vials

    Returns:
        bool: True if there is enough volume in the stock vials to run the experiment
    """
    ## Check that the experiment has solutions and those soltuions are in the stock vials
    if len(experiment.solutions) == 0:
        logger.error("The experiment has no solutions")
        return False
    for solution in experiment.solutions:
        if str(solution).lower() not in [
            str(vial.contents).lower() for vial in stock_vials
        ]:
            logger.error(
                "The experiment requires solution %s but it is not in the stock vials",
                solution,
            )
            return False

    ## Check that there is enough volume in the stock vials to run the experiment
    ## Note there may be multiple of the same stock vial so we need to sum the volumes
    for solution in experiment.solutions:
        volume_required = experiment.solutions[solution]
        volume_available = sum(
            [vial.volume for vial in stock_vials if vial.name == solution]
        )
        if volume_available < volume_required:
            logger.error(
                "There is not enough volume of solution %s to run the experiment",
                solution,
            )
            return False
    return True


def system_status_loop(slack: SlackBot):
    """
    Loop to check the system status and update the system status
    """
    while True:
        first_pause = True
        # Check the system status
        system_status = sql_system_state.select_system_status(2)
        if SystemState.SHUTDOWN in system_status:
            raise ShutDownCommand
        elif SystemState.PAUSE in system_status:
            # elif SystemState.PAUSE in system_status or SystemState.WAITING in system_status:
            # if SystemState.IDLE in system_status:
            #     break
            if first_pause:
                slack.send_slack_message("alert", "ePANDA is paused")
                first_pause = False
            for remaining in range(60, 0, -1):
                sys.stdout.write("\r")
                sys.stdout.write(
                    f"Waiting for new experiments: {remaining} seconds remaining"
                )
                sys.stdout.flush()
                time.sleep(1)
            sys.stdout.write("\r")
            sys.stdout.write("Waiting for new experiments: 0 seconds remaining")
            sys.stdout.flush()
            sys.stdout.write("\n")
            if SystemState.PAUSE in system_status:
                continue
            elif SystemState.IDLE in system_status:
                break
        elif SystemState.RESUME in system_status:
            slack.send_slack_message("alert", "ePANDA is resuming")
            sql_system_state.set_system_status(SystemState.BUSY)
            break
        else:
            break
        # if SystemState.ERROR in system_status:
        #     raise ShutDownCommand


def connect_to_instruments(use_mock_instruments: bool = TESTING) -> Toolkit:
    """Connect to the instruments"""
    if use_mock_instruments:
        logger.info("Using mock instruments")
        mill = MockMill()
        mill.connect_to_mill()
        scale = MockScale()
        pump = MockPump(mill=mill, scale=scale)
        # pstat = echem_mock.GamryPotentiostat.connect()
        instruments = Toolkit(
            mill=mill,
            scale=scale,
            pump=pump,
            wellplate=None,
            global_logger=logger,
            experiment_logger=logger,
        )
        return instruments

    logger.info("Connecting to instruments:")
    mill = Mill()
    mill.connect_to_mill()
    mill.homing_sequence()
    scale = Scale(address="COM6")
    pump = SyringePump(mill=mill, scale=scale)
    # pstat_connected = echem.pstatconnect()
    instruments = Toolkit(
        mill=mill,
        scale=scale,
        pump=pump,
        wellplate=None,
        global_logger=logger,
        experiment_logger=logger,
    )
    return instruments


def disconnect_from_instruments(instruments: Toolkit):
    """Disconnect from the instruments"""
    logger.info("Disconnecting from instruments:")
    instruments.mill.disconnect()

    logger.info("Disconnected from instruments")


def share_analysis_to_slack(
    experiment_id: int, next_exp_id: int = None, slack: SlackBot = None
):
    """
    Share the analysis results with the slack data channel

    Args:
        experiment_id (int): The experiment ID to analyze
        next_exp_id (int, optional): The next experiment ID. Defaults to None.
        slack (SlackBot, optional): The slack bot. Defaults to None.
    """
    # If the AL campaign length is set, run the ML analysis
    # We do the analysis on the experiment that just finished
    if read_testing_config():
        return
    if slack is None:
        slack = SlackBot()

    # First built the analysis message about the just completed experiment
    roi_path = None
    delta_e00 = None

    try:
        roi_path = Path(
            select_specific_result(experiment_id, "coloring_roi_path").result_value
        )
    except AttributeError:
        pass
    try:
        delta_e00 = select_specific_result(experiment_id, "delta_e00").result_value
    except AttributeError:
        pass

    if roi_path is not None:
        slack.send_slack_file(
            "data",
            roi_path,
            f"ROI for Experiment {experiment_id}:",
        )
    if delta_e00 is not None:
        slack.send_slack_message(
            "data", f"Delta E for Experiment {experiment_id}: {delta_e00}"
        )

    # Then fetch the ML results and build the message
    # Our list of relevant results
    results_to_find = [
        "PEDOT_Deposition_Voltage",
        "PEDOT_Deposition_Time",
        "PEDOT_Concentration",
        "PEDOT_Predicted_Mean",
        "PEDOT_Predicted_Uncertainty",
    ]
    ml_results = []
    if (
        next_exp_id is not None
    ):  # If we have a next experiment ID, we can fetch the results
        for result_type in results_to_find:
            ml_results.append(
                select_specific_result(next_exp_id, result_type).result_value
            )
        # Compose message
        ml_results_msg = f"""
        Experiment {next_exp_id} Parameters and Predictions:\n
        Deposition Voltage: {ml_results[0]}\n
        Deposition Time: {ml_results[1]}\n
        Concentration: {ml_results[2]}\n
        Predicted Mean: {ml_results[3]}\n
        Predicted StdDev: {ml_results[4]}\n
        """

        # fetch the contour plot
        contour_plot = Path(
            select_specific_result(next_exp_id, "PEDOT_Contour_Plots").result_value
        )

        slack.send_slack_message("data", ml_results_msg)
        if contour_plot is not None:
            slack.send_slack_file(
                "data",
                contour_plot,
                f"contour_plot_{next_exp_id}",
            )

    return


def share_to_slack(experiment: ExperimentBase):
    """Share the results of the experiment to the slack data channel"""
    slack = SlackBot(test=TESTING)

    if experiment.results is None:
        logger.error("The experiment has no results")
        return
    if experiment.results.image is None:
        logger.error("The experiment has no image files")
        return
    try:
        images_with_dz = [
            image
            for image in experiment.results.image
            if image[0].name.endswith("dz.tiff")
        ]
        if len(images_with_dz) == 0:
            logger.error("The experiment has no dz.tiff image files")
            msg = f"Experiment {experiment.experiment_id} has completed with status {experiment.status.value} but has no datazoned image files to share"
            slack.send_slack_message("data", msg)
            return
        slack.send_slack_message(
            "data",
            f"Experiment {experiment.experiment_id} has completed with status {experiment.status.value}. Photos taken:",
        )
        for image in experiment.results.image:
            image: Path = image[0]
            images_with_dz = []
            if image.name.endswith("dz.tiff"):
                images_with_dz.append(image)

            slack.upload_images("data", images_with_dz, "")
    except (
        SlackApiError,
        SlackClientError,
        SlackRequestError,
        BotUserAccessError,
        SlackTokenRotationError,
        SlackObjectFormationError,
        SlackClientNotConnectedError,
        SlackClientConfigurationError,
    ) as error:
        logger.error(
            "A Slack specific error occured while sharing images from experiment %d with slack: %s",
            experiment.experiment_id,
            error,
        )
        # continue with the rest of the program

    except Exception as error:
        logger.error(
            "An unanticipated error occured while sharing images from experiment %d with slack: %s",
            experiment.experiment_id,
            error,
        )
        # continue with the rest of the program


if __name__ == "__main__":
    print("TEST MODE: ", TESTING)
    input("Press enter to continue or ctrl+c to exit")
    main(use_mock_instruments=TESTING, one_off=False)
