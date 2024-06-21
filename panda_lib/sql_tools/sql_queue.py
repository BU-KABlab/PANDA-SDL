# region Queue Functions

# Note the queue is a view and not a table, so it cannot be updated directly.
# Instead the well_hx table is updated with the experiment_id and status.
# If the status is 'queued' then the experiment is in the queue.
# Otherwise the experiment is not in the queue.
# TODO in the future experiments in the experiments table that are not matched to a well
# in the well_hx table should be added to the queue in some manner but this is not implemented yet.

from panda_lib.sql_tools.sql_utilities import execute_sql_command, execute_sql_command_no_return
def select_queue() -> list:
    """
    Selects all the entries from the queue table.

    Returns:
        list: The entries from the queue table.
    """
    result = execute_sql_command(
        """
        SELECT
            experiment_id,
            process_type,
            priority,
            well_id,
            filename
        FROM queue 
        ORDER BY experiment_id ASC
        """
    )
    return result


def get_next_experiment_from_queue(random_pick: bool = False) -> tuple[int, int, str]:
    """
    Reads the next experiment from the queue table, the experiment with the
    highest priority (lowest value).

    If random_pick, a random experiment with highest priority (lowest value) is selected.
    Else, the lowest experiment id with the highest priority (lowest value) is selected.

    Args:
        random_pick (bool): Whether to pick a random experiment from the queue.

    Returns:
        tuple: The experiment ID, the process type, and the filename.
    """
    if random_pick:
        result = execute_sql_command(
            """
            SELECT experiment_id, process_type, filename, project_id, well_id FROM queue
            WHERE priority = (SELECT MIN(priority) FROM queue)
            AND status = 'queued'
            ORDER BY RANDOM()
            LIMIT 1
            """
        )
    else:
        result = execute_sql_command(
            """
            SELECT experiment_id, process_type, filename, project_id, well_id FROM queue
            WHERE priority = (SELECT MIN(priority) FROM queue)
            AND status = 'queued'
            ORDER BY experiment_id ASC
            LIMIT 1
            """
        )

    if result == []:
        return None
    return result[0][0], result[0][1], result[0][2], result[0][3], result[0][4]


def clear_queue() -> None:
    """Go through and change the status of any queued experiment to pending"""
    execute_sql_command_no_return(
        """
        UPDATE well_hx SET status = 'pending'
        WHERE status = 'queued'
        """
    )


def count_queue_length() -> int:
    """Count the number of experiments in the queue"""
    result = execute_sql_command(
        """
        SELECT COUNT(*) FROM queue
        WHERE status = 'queued'
        """
    )
    return int(result[0][0])


# endregion