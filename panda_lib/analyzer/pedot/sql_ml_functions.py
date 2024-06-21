import pandas as pd
import numpy as np
from panda_lib.sql_tools.sql_utilities import (execute_sql_command,
                                                execute_sql_command_no_return)


# region ML Functions
def select_best_test_points() -> pd.DataFrame:
    """
    Select the best test points from the ml_pedot_best_test_points table.

    Returns:
        pd.DataFrame: The best test points.
    """
    sql_command = "SELECT * FROM ml_pedot_best_test_points"
    result = execute_sql_command(sql_command)
    df = pd.DataFrame(result, columns=[
        "Model ID",
        "Experiment ID",
        "Best Test Point Scalar",
        "Best Test Point Original",
        "Best Test Point",
        "v_dep",
        "t_dep",
        "edot_concentration",
        "Predicted Response",
        "Standard Deviation",
        "Models current RMSE"
    ])
    return df

def select_best_test_points_by_model_id(model_id: int) -> pd.DataFrame:
    """
    Select the best test points from the ml_pedot_best_test_points table by model ID.

    Args:
        model_id (int): The model ID.

    Returns:
        pd.DataFrame: The best test points.
    """
    sql_command = "SELECT * FROM ml_pedot_best_test_points WHERE model_id = ?"
    result = execute_sql_command(sql_command, (model_id,))
    df = pd.DataFrame(result, columns=[
        "Model ID",
        "Experiment ID",
        "Best Test Point Scalar",
        "Best Test Point Original",
        "Best Test Point",
        "v_dep",
        "t_dep",
        "edot_concentration",
        "Predicted Response",
        "Standard Deviation",
        "Models current RMSE"
    ])
    return df

def select_best_test_points_by_experiment_id(experiment_id: int) -> pd.DataFrame:
    """
    Select the best test points from the ml_pedot_best_test_points table by experiment ID.

    Args:
        experiment_id (int): The experiment ID.

    Returns:
        pd.DataFrame: The best test points.
    """
    sql_command = "SELECT * FROM ml_pedot_best_test_points WHERE experiment_id = ?"
    result = execute_sql_command(sql_command, (experiment_id,))
    df = pd.DataFrame(result, columns=[
        "Model ID",
        "Experiment ID",
        "Best Test Point Scalar",
        "Best Test Point Original",
        "Best Test Point",
        "v_dep",
        "t_dep",
        "edot_concentration",
        "Predicted Response",
        "Standard Deviation",
        "Models current RMSE"
    ])
    return df

def insert_best_test_point(entry: pd.DataFrame) -> None:
    """
    Insert an entry into the ml_pedot_best_test_points table.

    Args:
        entry (pandas Dataframe): The entry to insert.
    """
    # The entry doesn't include the model_id but it is incremented for each row, 
    # so we can just use the current max model_id + 1

    command = """
        INSERT INTO ml_pedot_best_test_points (
            model_id,
            experiment_id,
            best_test_point_scalar,
            best_test_point_original,
            best_test_point,
            v_dep,
            t_dep,
            edot_concentration,
            predicted_response,
            standard_deviation,
            models_current_rmse
            )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """
    parameters = entry.values.tolist()[0]
    parameters = [param.tolist() if isinstance(param, np.ndarray) else param for param in parameters]
    parameters = [str(param) if isinstance(param, list) else param for param in parameters]
    execute_sql_command_no_return(command, parameters)

def select_ml_training_data() -> pd.DataFrame:
    """
    Select the training data from the ml_pedot_training_data table.

    Returns:
        pd.DataFrame: The training data.
    """
    sql_command = """
    SELECT
        delta_e,
        voltage,
        time,
        bleach_cp,
        concentration
    FROM ml_pedot_training_data
    """
    result = execute_sql_command(sql_command)
    df = pd.DataFrame(result, columns=[
        "deltaE",
        "voltage",
        "time",
        "bleachCP",
        'concentration'
    ])
    return df

def insert_ml_training_data(entry: pd.DataFrame) -> None:
    """
    Insert an entry into the ml_pedot_training_data table.

    Args:
        entry (pandas Dataframe): The entry to insert.
    """
    command = """
        INSERT INTO ml_pedot_training_data (
            delta_e,
            voltage,
            time,
            bleach_cp,
            concentration
            )
        VALUES (?, ?, ?, ?, ?)
        """
    parameters = entry.values.tolist()
    execute_sql_command_no_return(command, parameters)

def delete_training_data(experiment_id: int) -> None:
    """
    Delete training data from the ml_pedot_training_data table.

    Args:
        experiment_id (int): The experiment ID.
    """
    command = "DELETE FROM ml_pedot_training_data WHERE experiment_id = ?"
    execute_sql_command_no_return(command, (experiment_id,))

def model_iteration() -> int:
    """
    Get the current model iteration.

    Returns:
        int: The current model iteration.
    """
    sql_command = "SELECT MAX(model_id) FROM ml_pedot_best_test_points"
    result = execute_sql_command(sql_command)[0][0]
    if result is None:
        return 0
    return result

def delete_model(model_id: int) -> None:
    """
    Delete a model from the ml_pedot_best_test_points table.

    Args:
        model_id (int): The model ID.
    """
    command = "DELETE FROM ml_pedot_best_test_points WHERE model_id = ?"
    execute_sql_command_no_return(command, (model_id,))
# endregion
