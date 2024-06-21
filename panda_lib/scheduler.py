"""
The scheduler module will be responsible for:
    - Injesting new experiments
    - Designating experiments to wells
    - Scheduling experiments by priority
    - Inserting control tests
    - Returning the next experiment to run
"""

# pylint: disable = line-too-long
import logging
import sqlite3
from pathlib import Path
from typing import Tuple, Union

import pandas as pd

from .config.config import EPANDA_LOG
from .experiment_class import (
    ExperimentBase,
    ExperimentStatus,
    select_experiment_information,
    select_experiment_paramaters,
    insert_experiment,
    insert_experiment_parameters,
    select_next_experiment_id,
    update_experiment_status,
    insert_experiment_result,
    insert_experiments_parameters,
)
from .sql_tools.sql_utilities import execute_sql_command
from .sql_tools.sql_wellplate import (
    select_well_status,
    select_next_available_well,
    get_well,
    select_current_wellplate_info,
    update_well,
    count_wells_with_new_status,
)
from .sql_tools.sql_queue import (
    get_next_experiment_from_queue,
    count_queue_length,
    select_queue,
)
from .wellplate import Well

# set up logging to log to both the pump_control.log file and the ePANDA.log file
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)  # change to INFO to reduce verbosity
formatter = logging.Formatter(
    "%(asctime)s&%(name)s&%(levelname)s&%(module)s&%(funcName)s&%(lineno)d&&&&%(message)s&"
)
system_handler = logging.FileHandler(EPANDA_LOG)
system_handler.setFormatter(formatter)
logger.addHandler(system_handler)


class Scheduler:
    """
    Class for scheduling experiments and control tests
    """

    def __init__(self):
        """
        Initialize the scheduler
        """
        self.experiment_queue = []

    def check_well_status(self, well_to_check: str, plate_id: int = None) -> str:
        """Checks the status of the well in the well_status view in the SQLite database"""
        try:
            well_status = select_well_status(well_to_check, plate_id)
            return well_status
        except sqlite3.Error as e:
            logger.error("Error occured while checking well status: %s", e)
            raise e

    def choose_next_new_well(self, plate_id: int = None) -> str:
        """Choose the next available well for an experiment"""
        try:
            next_well = select_next_available_well(plate_id)
            return next_well
        except sqlite3.Error as e:
            logger.error("Error occured while choosing next well: %s", e)
            raise e

    def change_well_status(
        self, well: Union[Well, str], experiment: ExperimentBase
    ) -> None:
        """Change the status of the well in the well_status view in the SQLite database"""
        logger.debug(
            "Changing %s status to %s",
            well,
            well.status if isinstance(well, Well) else experiment.status.value,
        )
        # If the well is a string, get a well object
        if isinstance(well, str):
            well_id = well
            well: Well = get_well(well_id=well_id)
            if well is None:
                logger.error("Well %s not found", well_id)
                raise ValueError(f"Well {well_id} not found")

        # Update the well status
        well.status = experiment.status.value
        well.status_date = experiment.status_date

        # Verify that the well has a plate id
        if well.plate_id is None:
            logger.error("Well %s does not have a plate id", well)
            raise ValueError(f"Well {well} does not have a plate id")

        try:
            update_well(well)
        except sqlite3.Error as e:
            logger.error("Error occured while changing well status: %s", e)
            raise e

    def read_next_experiment_from_queue(
        self, random_pick: bool = True
    ) -> Tuple[ExperimentBase, Path]:
        """
        Reads the next experiment from the queue table, the experiment with the highest priority (lowest number).
        If random_pick is True, then a random experiment with the highest priority is selected.
        Otherwise, the lowest experiment id in the queue with the highest priority is selected.

        Args:
            random_pick (bool): Whether to randomly select an experiment from the queue.

        Returns:
            Tuple[ExperimentBase]: The next experiment.
        """
        # Get the next experiment from the queue

        try:
            queue_info = get_next_experiment_from_queue(random_pick)
        except sqlite3.Error as e:
            logger.error(
                "Error occured while reading next experiment from queue: %s", e
            )
            raise e

        if queue_info is None:
            logger.info("No experiments in queue")
            return None, None

        else:
            experiment_id, _, filename, _, well_id = queue_info
        # Get the experiment information from the experiment table
        experiment_base = select_experiment_information(experiment_id)
        echem_experiment_base = select_experiment_paramaters(experiment_base)

        # Finally get the well id and plate id for the experiment based on the well_status view
        echem_experiment_base.well_id = well_id

        return echem_experiment_base, filename

    def update_experiment_queue_priority(self, experiment_id: int, priority: int):
        """Update the priority of experiments in the queue"""
        try:
            execute_sql_command(
                "UPDATE experiments SET priority = ? WHERE experiment_id = ?",
                (priority, experiment_id),
            )
        except sqlite3.Error as e:
            logger.error(
                "Error occured while updating experiment queue priority: %s", e
            )
            raise e

    def update_experiment_info(self, experiment: ExperimentBase, column: str) -> None:
        """Update the experiment information in the experiments table"""
        try:
            execute_sql_command(
                f"UPDATE experiments SET {column} = ? WHERE experiment_id = ?",
                (getattr(experiment, column), experiment.experiment_id),
            )
        except sqlite3.Error as e:
            logger.error("Error occured while updating experiment information: %s", e)
            raise e

    def update_experiment_parameters(
        self, experiment: ExperimentBase, parameter: str
    ) -> None:
        """Update the experiment parameters in the experiment_parameters table"""
        try:
            execute_sql_command(
                "UPDATE experiment_parameters SET ? = ? WHERE experiment_id = ?",
                (parameter, experiment[parameter], experiment.experiment_id),
            )
        except sqlite3.Error as e:
            logger.error("Error occured while updating experiment parameters: %s", e)
            raise e

    def add_nonfile_experiment(
        self, experiment: ExperimentBase, override_well_available=False
    ) -> str:
        """
        Adds an experiment which is not a file to the experiment queue directly.

        Args:
            experiment (ExperimentBase): The experiment to add.

        Returns:
            str: A message indicating whether the experiment was successfully added to the queue.
        """
        if not override_well_available:
            ## First check the existing status, if not new or queued, then do not add to queue
            if experiment.status not in [ExperimentStatus.NEW, ExperimentStatus.QUEUED]:
                message = f"Experiment {experiment.experiment_id} is not new or queued, not adding to queue"
                logger.info(message)
                return message

            ## Check if the well is available
            if self.check_well_status(experiment.well_id) != "new":
                # Find the next available well
                target_well = self.choose_next_new_well()
                if target_well is None:
                    logger.info(
                        "No wells available for experiment originally for well %s.",
                        experiment.well_id,
                    )
                    return "No wells available"
                logger.info(
                    "Experiment originally for well %s is now for well %s.",
                    experiment.well_id,
                    target_well,
                )
                experiment.well_id = target_well

        # Save the experiment as a separate file in the experiment_queue subfolder
        experiment.set_status_and_save(ExperimentStatus.QUEUED)

        ## Add the experiment to experiments table
        try:
            insert_experiment(experiment)
        except sqlite3.Error as e:
            logger.error(
                "Error occured while adding the experiment to experiments table: %s", e
            )
            experiment.status = ExperimentStatus.ERROR
            raise e  # raise the error to be caught by the calling function

        ## Add the experiment parameters to the experiment_parameters table
        try:
            insert_experiment_parameters(experiment)
        except sqlite3.Error as e:
            logger.error(
                "Error occured while adding the experiment parameters to experiment_parameters table: %s",
                e,
            )
            experiment.status = ExperimentStatus.ERROR
            raise e

        ## Add the experiment to the queue
        experiment = self.add_to_queue(experiment)

        ## Change the status of the well
        self.change_well_status(experiment.well_id, experiment)

        logger.info("Experiment %s added to queue", experiment.experiment_id)
        return "success"

    def add_to_queue(self, experiment: ExperimentBase) -> ExperimentBase:
        """Add the given experiment to the queue table"""
        # Add the experiment to the queue
        try:
            # output = execute_sql_command(
            #     "INSERT INTO queue (experiment_id, process_type, priority, filename) VALUES (?, ?, ?, ?)",
            #     (experiment.id, experiment.process_type, experiment.priority, str(experiment.filename)),
            # )
            # print("Adding experiment to queue result:",output)
            logger.warning("No queue to add to when using database, will be in a view")
            experiment.status = ExperimentStatus.QUEUED

        except sqlite3.Error as e:
            logger.error(
                "Error occured while adding the experiment to queue table: %s", e
            )
            experiment.status = ExperimentStatus.ERROR
            raise e  # raise the error to be caught by the calling function
        return experiment

    def add_nonfile_experiments(self, experiments: list[ExperimentBase]) -> int:
        """
        Adds an experiment which is not a file to the experiment queue directly.

        Args:
            experiment (ExperimentBase): The experiment to add.

        Returns:
            str: A message indicating whether the experiment was successfully added to the queue.
        """
        for experiment in experiments:
            if not experiment.override_well_selection:
                ## First check the existing status, if not new or queued, then do not add to queue
                if experiment.status not in [
                    ExperimentStatus.NEW,
                    ExperimentStatus.QUEUED,
                ]:
                    message = f"Experiment {experiment.experiment_id} is not new or queued, not adding to queue"
                    logger.info(message)
                    print(message)
                    experiments.remove(experiment)

                ## Check if the experiment is for a specific plate, if not choose the current plate
                if experiment.plate_id is None:
                    experiment.plate_id, _, _ = select_current_wellplate_info()
                ## Check if the well is available
                if (
                    self.check_well_status(experiment.well_id, experiment.plate_id)
                    != "new"
                ):
                    # Find the next available well
                    target_well = self.choose_next_new_well(experiment.plate_id)
                    if target_well is None:
                        logger.info(
                            "No wells available for experiment originally for well %s.",
                            experiment.well_id,
                        )
                        print(
                            "No wells available for experiment originally for well %s.",
                            experiment.well_id,
                        )
                        experiments.remove(experiment)
                        # TODO Add a pending label to the experiment to be added to the queue when the right well is available
                    logger.info(
                        "Experiment originally for well %s is now for well %s.",
                        experiment.well_id,
                        target_well,
                    )
                    experiment.well_id = target_well

            # Individually insert the experiment and update the status
            # We do this so that the wellchecker is checking as the wells are allocated
            # The parameters are quite lengthly, so we will save those for a bulk entry
            try:
                insert_experiment(experiment)
                update_experiment_status(experiment, ExperimentStatus.QUEUED)
            except sqlite3.Error as e:
                logger.error(
                    "Error occured while adding the experiment to experiments table: %s",
                    e,
                )
                logger.error(
                    "The statements have been rolled back and nothing has been added to the tables."
                )
                print(
                    "The statements have been rolled back and nothing has been added to the tables."
                )
                raise e

        ## Add the experiment to experiments table
        try:
            # Bulk insert the experiments that had wells available
            # sql_utilities.insert_experiments(experiments)
            # Bulk set the status of the experiments that had wells available
            # sql_utilities.update_experiments_statuses(
            #     experiments, ExperimentStatus.QUEUED
            # )

            ## Bulk add the experiment parameters to the experiment_parameters table
            insert_experiments_parameters(experiments)

        except sqlite3.Error as e:
            logger.error(
                "Error occured while adding the experiment parameters to experiment_parameters table: %s",
                e,
            )
            logger.error(
                "The statements have been rolled back and nothing has been added to the tables."
            )
            print(
                "The statements have been rolled back and nothing has been added to the tables."
            )
            raise e

        logger.info("Experiments loaded and added to queue")
        return 1

    def save_results(self, experiment: ExperimentBase) -> None:
        """Save the results of the experiment to the experiment_results table in the SQLite database.

            The results are saved in a one to many relationship with the experiment id as the foreign key.
            Each result value is saved as a separate row in the table.
            This function accepts an Experiment object and turns it into a dictionary to be saved in the database.

            The results table has columns:
                - id (primary key) - autoincrement
                - experiment_id (foreign key)
                - result_type
                - result_value
                - created (timestamp)
                - modified (timestamp)
        Args:
            experiment (ExperimentBase): The experiment that was just run
            results (ExperimentResult): The results of the experiment

            Returns:
                None
        """
        # Turn the results into a list of values
        results_lists = experiment.results.one_to_many()

        for result in results_lists:
            # Save the results to the database
            insert_experiment_result(result)

    def count_available_wells(self) -> int:
        """Return the number of wells available for experiments"""
        try:
            available_wells = count_wells_with_new_status()
            return available_wells
        except sqlite3.Error as e:
            logger.error("Error occured while counting available wells: %s", e)
            raise e

    def get_queue(self) -> pd.DataFrame:
        """Return the queue as a DataFrame"""
        try:
            queue = select_queue()
            queue = pd.DataFrame(
                queue, columns=["id", "priority", "process_type", "filename"]
            )
            return queue
        except sqlite3.Error as e:
            logger.error("Error occured while getting queue: %s", e)
            raise e


def get_queue_length() -> int:
    """Get queue length"""
    return count_queue_length()


def determine_next_experiment_id() -> int:
    """Load well history to get last experiment id and increment by 1"""
    return select_next_experiment_id()


####################################################################################################
def test_well_status_update():
    """
    Tests the change_well_status function.
    """
    test_scheduler = Scheduler()
    current_status = test_scheduler.check_well_status("A1")
    test_scheduler.change_well_status("A1", "running")
    assert test_scheduler.check_well_status("A1") == "running"
    test_scheduler.change_well_status("A1", "complete")
    assert test_scheduler.check_well_status("A1") == "complete"
    test_scheduler.change_well_status("A1", "new")
    assert test_scheduler.check_well_status("A1") == "new"
    test_scheduler.change_well_status("A1", current_status)


if __name__ == "__main__":
    test_well_status_update()
    # scheduler.read_next_experiment_from_queue()
