"""PEDOT Experiments Analyzer."""

# pylint: disable=line-too-long
from pathlib import Path
import pandas as pd
from panda_lib.experiment_class import (
    ExperimentResultsRecord,
    insert_experiment_result,
)

from panda_lib.config.config import (
    read_testing_config,
)

from panda_lib.analyzer.pedot.sql_ml_functions import insert_ml_training_data


from . import PEDOT_FindLAB as lab
from . import PEDOT_MetricsCalc as met
from .experiment_generator import pedot_generator, determine_next_experiment_id
from .ml_input import populate_required_information as analysis_input
from .pedot_classes import (
    MLInput,
    MLOutput,
    PEDOTParams,
    RequiredData,
    PEDOTMetrics,
    MLTrainingData,
    RawMetrics,
)
from .ml_model import pedot_model

# Set up the ML filepaths, for this project this is hardcoded only here
ml_file_paths = MLInput(
    training_file_path=Path("ml_model/training_data/MLTrainingData_PEDOT.csv"),
    model_base_path=Path("ml_model/pedot_gp_model_v8"),
    counter_file_path=Path("ml_model/model_counter.txt"),
    BestTestPointsCSV=Path("ml_model/BestTestPoints.csv"),
    contourplots_path="ml_model/contourplots/contourplot",
)


def pedot_analyzer(experiment_id: int, dont_train:bool=False) -> MLTrainingData:
    """
    Analyzes the PEDOT experiment and returns the training data for the ML model.

    Args:
        experiment_id (int): The experiment ID to analyze.

    Returns:
        MLTrainingData: The training data to be used for the ML model.
    
    """
    if read_testing_config():
        return

    if experiment_id is None:
        experiment_id = determine_next_experiment_id() - 1 # Get the last experiment ID

    input_data: RequiredData = analysis_input(experiment_id)
    metrics:RawMetrics = lab.rgbtolab(input_data)
    results = met.process_metrics(metrics, input_data)

    # insert the metrics as experiment results
    list_of_raw_metrics = [
        ExperimentResultsRecord(
            experiment_id=results.experiment_id,
            result_type=metric_name,
            result_value=getattr(metrics, metric_name),
            context="PEDOT Raw Metrics",
        )
        for metric_name in RawMetrics.__annotations__.keys()
    ]

    for metric in list_of_raw_metrics:
        insert_experiment_result(metric)
        print("Inserted metric: ", metric.result_type)

    list_of_pedot_metrics = [
        ExperimentResultsRecord(
            experiment_id=results.experiment_id,
            result_type=metric_name,
            result_value=getattr(results, metric_name),
            context="PEDOT Metrics",
        )
        for metric_name in PEDOTMetrics.__annotations__.keys()
    ]

    for result in list_of_pedot_metrics:
        insert_experiment_result(result)

    ml_training_data = MLTrainingData(
        experiment_id=results.experiment_id,
        ca_step_1_voltage=input_data.ca_step_1_voltage,
        ca_step_1_time=input_data.ca_step_1_time,
        edot_concentration=input_data.edot_concentration,
        deltaE00=metrics.delta_e00,
        BleachChargePassed=results.BleachChargePassed,
        DepositionEfficiency=results.DepositionEfficiency,
        ElectrochromicEfficiency=results.ElectrochromicEfficiency,
    )

    # Add the new training data to the training file
    df_new_training_data = pd.DataFrame(
        {
            "deltaE": [ml_training_data.deltaE00],
            "voltage": [ml_training_data.ca_step_1_voltage],
            "time": [ml_training_data.ca_step_1_time],
            "bleachCP": [ml_training_data.BleachChargePassed],
            "concentration": [ml_training_data.edot_concentration],
        }
    )
    # Add to the training data file
    # df_new_training_data.to_csv(
    #     ml_file_paths.training_file_path, mode="a", header=False, index=False
    # )
    if not dont_train:
        insert_ml_training_data(df_new_training_data)

    return ml_training_data

def run_ml_model(generate_experiment_id=None) -> MLOutput:
    """
    Runs the ML model for the PEDOT experiment.

    Args:
        generate_experiment_id ([type], optional): The experiment ID to generate. Defaults to None.
    """
    if generate_experiment_id is None:
        generate_experiment_id = determine_next_experiment_id()

    # Run the ML model
    results = pedot_model(
        ml_file_paths.training_file_path,
        ml_file_paths.model_base_path,
        ml_file_paths.counter_file_path,
        ml_file_paths.BestTestPointsCSV,
        ml_file_paths.contourplots_path,
        experiment_id=generate_experiment_id,
    )

    ml_output = MLOutput(*results)

    params = PEDOTParams(
        dep_v=ml_output.v_dep,
        dep_t=ml_output.t_dep,
        concentration=ml_output.edot_concentration,
    )

    # Generate the next experiment
    exp_id = pedot_generator(params, experiment_name="PEDOT_Optimization", campaign_id=0)
    return exp_id

def main(experiment_id: int = None, generate_experiment: bool = True):
    """
    Main function for the PEDOT analyzer.
    
    If the system is in testing mode, the function will only generate a new experiment.
    It will not analyze the experiment.

    Args:
        experiment_id (int, optional): The experiment ID to analyze. Defaults to None.
        generate_experiment (bool, optional): Whether to generate a new experiment. Defaults to True.

    Returns:
        int: The ID of the new experiment if generate_experiment is True. Otherwise, None.

    """
    # Analyze the experiment
    pedot_analyzer(experiment_id)

    if not generate_experiment:
        return None

    # Run the ML model
    new_experiment_id = run_ml_model() # Generate a new experiment
    return new_experiment_id
