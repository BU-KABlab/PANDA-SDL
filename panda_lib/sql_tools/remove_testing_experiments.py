"""Clean out testing experiments"""

from panda_lib.sql_tools.sql_utilities import (
    execute_sql_command,
    execute_sql_command_no_return,
)



def main():
    """
    For this script we will do the following:
    Go to the experiments table and find experiment_ids with project_id = 999
    Using this list of experiment_ids we will delete records from the following tables:
    - experiment_parameters
    - experiment_results
    For well_hx we can use the project_id again and we will update instead of delete:
    - experiment_id to NULL
    - project_id to NULL
    - status to 'new'
    - status_date to NULL
    - contents to {}
    - volume to 0
    Finally remove the experiments from experiments table
    Get the experiment_ids
    """
    sql_command = "SELECT experiment_id FROM experiments WHERE project_id = 999"
    experiment_ids = execute_sql_command(sql_command)

    # Delete records from experiment_parameters
    sql_command = "DELETE FROM experiment_parameters WHERE experiment_id IN ({})".format(
        ", ".join([str(experiment_id[0]) for experiment_id in experiment_ids])
    )
    execute_sql_command_no_return(sql_command)

    # Delete records from experiment_results
    sql_command = "DELETE FROM experiment_results WHERE experiment_id IN ({})".format(
        ", ".join([str(experiment_id[0]) for experiment_id in experiment_ids])
    )
    execute_sql_command_no_return(sql_command)

    # Update records in well_hx
    sql_command = "UPDATE well_hx SET experiment_id = NULL, project_id = NULL, status = 'new', status_date = NULL, contents = '{}', volume = 0 WHERE project_id = 999"
    execute_sql_command_no_return(sql_command)

    # Delete records from experiments
    sql_command = "DELETE FROM experiments WHERE project_id = 999"
    execute_sql_command_no_return(sql_command)

    print("Testing experiments removed")

if __name__ == "__main__":
    main()
