from panda_lib.sql_tools import sql_system_state
from panda_lib.experiment_class import select_specific_result, select_specific_parameter
from panda_lib.config.config_tools import read_testing_config
import pandas as pd
from .pedot_classes import RequiredData

# pylint: disable=invalid-name

data = {
    'name': ['experiment_id', 'ca_step_1_voltage', 'ca_step_1_time', 'edot_concentration', 'CA_deposition', 'CV_characterization', 'CA_bleaching', 'BeforeDeposition', 'AfterBleaching', 'AfterColoring'],
    'type': ['int', 'float', 'float', 'float', 'ca_data_file', 'cv_data_file', 'ca_data_file', 'image', 'image', 'image'],
    'source': [None, 'parameter', 'parameter', 'parameter', 'result', 'result', 'result', 'result', 'result', 'result'],
    'context': [None, None, None, None, 'CA_deposition', 'CV_characterization', 'CA_bleaching', 'BeforeDeposition', 'AfterBleaching', 'AfterColoring'],
    'value': [None, None, None, None, None, None, None, None, None, None]
}

df = pd.DataFrame(data)

def populate_required_information(experiment_id: int) -> RequiredData:
    """Populates the required information for the machine learning input."""
    sql_system_state.set_system_status(
        sql_system_state.SystemState.BUSY, "analyzing data", read_testing_config()
    )
    df.loc[df['name'] == 'experiment_id', 'value'] = experiment_id

    # Get the experiment parameters
    parameters = df.loc[df['source'] == 'parameter', 'name']
    for parameter in parameters:
        try:
            df.loc[df['name'] == parameter, 'value'] = select_specific_parameter(
                experiment_id, parameter
            )
        except Exception as e:
            print(f"Error getting parameter {parameter}: {e}")
            df.loc[df['name'] == parameter, 'value'] = None

    # Get the experiment results
    table = df.loc[df['source'] == 'result'][['name', 'type','context']].values
    for row in table:
        try:
            name, result_type, context = row
            value = select_specific_result(
                experiment_id, result_type, context
            )
            if value is not None:
                df.loc[(df['name'] == name), 'value'] = value.result_value
        except Exception as e:
            print(f"Error getting result {row}: {e}")
            df.loc[(df['name'] == name), 'value'] = None
    sql_system_state.set_system_status(
        sql_system_state.SystemState.IDLE, "ready", read_testing_config()
    )

    # Convert the df into a MLInput object
    results = RequiredData(
        experiment_id=df.loc[df['name'] == 'experiment_id', 'value'].values[0],
        ca_step_1_voltage=df.loc[df['name'] == 'ca_step_1_voltage', 'value'].values[0],
        ca_step_1_time=df.loc[df['name'] == 'ca_step_1_time', 'value'].values[0],
        edot_concentration=df.loc[df['name'] == 'edot_concentration', 'value'].values[0],
        CA_deposition=df.loc[df['name'] == 'CA_deposition', 'value'].values[0],
        CV_characterization=df.loc[df['name'] == 'CV_characterization', 'value'].values[0],
        CA_bleaching=df.loc[df['name'] == 'CA_bleaching', 'value'].values[0],
        BeforeDeposition=df.loc[df['name'] == 'BeforeDeposition', 'value'].values[0],
        AfterBleaching=df.loc[df['name'] == 'AfterBleaching', 'value'].values[0],
        AfterColoring=df.loc[df['name'] == 'AfterColoring', 'value'].values[0],
    )

    return results

if __name__ == "__main__":
    info = populate_required_information(1000876)
    # Print the required information
    print(info)
    # info.at[7, 'value'].show()
    # info.at[8, 'value'].show()
    # info.at[9, 'value'].show()
