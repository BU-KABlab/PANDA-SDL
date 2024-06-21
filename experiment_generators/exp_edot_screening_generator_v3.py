"""Experiment parameters for the edot screening experiments"""

import pandas as pd

from panda_lib import experiment_class
from panda_lib.config.config import read_testing_config, DEFAULT_PUMPING_RATE
from panda_lib.scheduler import Scheduler, determine_next_experiment_id
from panda_lib.sql_tools.sql_system_state import get_current_pin

CURRENT_PIN =  get_current_pin()
PROJECT_ID = 16
EXPERIMENT_NAME = "pedotLHSv1_screening_0,01"
CAMPAIGN_ID = 2

params_df = pd.read_csv(
    r".\experiment_generators\exp_edot_screening_generator_v1_LHS_0,01.csv"
)  # Update path with location on PANDA computer

def main():
    """Runs the edot voltage sweep experiment generator."""
    print("TEST MODE: ", read_testing_config())
    input("Press enter to continue")

    # controller.load_new_wellplate(new_wellplate_type_number=6)
    starting_experiment_id = determine_next_experiment_id()
    experiment_id = starting_experiment_id
    experiments: list[experiment_class.EdotExperiment] = []

    for _, row in params_df.iterrows():
        dep_v = row["dep_V"]  # dep_V is used for deposition voltage
        dep_t = row["dep_T"]  # dep_T is used for deposition time

        experiments.append(
            experiment_class.EdotExperiment(
                experiment_id=experiment_id,
                protocol_id=13,
                well_id='A1',
                well_type_number=4,
                experiment_name=EXPERIMENT_NAME,
                pin=CURRENT_PIN,
                project_id=PROJECT_ID,
                project_campaign_id=CAMPAIGN_ID,
                solutions={"edot": 120, "liclo4": 0, "rinse": 120},
                solutions_corrected={"edot": 0, "liclo4": 0, "rinse": 0},
                pumping_rate=DEFAULT_PUMPING_RATE,
                status=experiment_class.ExperimentStatus.NEW,
                filename=EXPERIMENT_NAME + " " + str(experiment_id),
                # Echem specific
                ocp=1,
                baseline=0,
                cv=0,
                ca=1,
                ca_sample_period=0.1,
                ca_prestep_voltage=0.0,
                ca_prestep_time_delay=0.0,
                ca_step_1_voltage=dep_v,
                ca_step_1_time=dep_t,
                ca_step_2_voltage=0.0,
                ca_step_2_time=0.0,
                ca_sample_rate=0.5,
                edot_concentration=0.01,
            )
        )
        experiment_id += 1

    # for experiment in experiments:
        ## Print a recipt of the wellplate and its experiments noting the solution and volume
        # print(f"Experiment name: {experiment.experiment_name}")
        # print(f"Experiment id: {experiment.experiment_id}")
        # print(f"Well id: {experiment.well_id}")
        # print(f"Solutions: {json.dumps(experiment.solutions)}")
        # print(f"Pumping rate: {DEFAULT_PUMPING_RATE}")
        # print(
        #     f"Project campaign id: {experiment.project_id}.{experiment.project_campaign_id}\n"
        # )
        # print(f"CA Paramaters: {experiment.print_ca_parameters()}\n")
        # print(f"CV Paramaters: {experiment.print_cv_parameters()}\n")

    # Add experiments to the queue
    # input("Press enter to add the experiments")
    scheduler = Scheduler()
    scheduler.add_nonfile_experiments(experiments)
