import logging
import sqlite3
from decimal import Decimal
from panda_lib.config.config import PATH_TO_LOGS, SQL_DB_PATH, LOCAL_REPO_PATH
import time

# Set up logging
# set up logging to log to both the pump_control.log file and the ePANDA.log file
logger = logging.getLogger("sql_utilities")
logger.setLevel(logging.INFO)  # change to INFO to reduce verbosity
formatter = logging.Formatter(
    "%(asctime)s&%(name)s&%(levelname)s&%(module)s&%(funcName)s&%(lineno)d&%(message)s"
)
system_handler = logging.FileHandler(PATH_TO_LOGS / "sql_utilities.log")
system_handler.setFormatter(formatter)
logger.addHandler(system_handler)


# region Utility Functions
def execute_sql_command(
    sql_command: str, parameters: tuple = None, test: bool = False
) -> list:
    """
    Execute an SQL command on the database.

    Args:
        sql_command (str): The SQL command to execute.
        parameters (tuple): The parameters for the SQL command.

    Returns:
        List: The result of the SQL command.
    """
    if test:
        conn = sqlite3.connect(LOCAL_REPO_PATH / "epanda_test.db")
    else:
        conn = sqlite3.connect(SQL_DB_PATH)
    conn.isolation_level = None  # Manually control transactions
    cursor = conn.cursor()

    cursor.execute("BEGIN TRANSACTION")  # Start a new transaction

    try:
        # Log the SQL command
        logger.debug("Executing SQL command: %s", sql_command)
        logger.debug("Parameters: %s", parameters)
        # Execute the SQL command
        if parameters:
            if isinstance(parameters[0], tuple):
                parameters = convert_decimals(parameters)
                cursor.executemany(sql_command, parameters)
            else:
                parameters = convert_decimals(parameters)
                cursor.execute(sql_command, parameters)
        else:
            cursor.execute(sql_command)
        result = cursor.fetchall()

        conn.commit()

        # Log the result
        logger.debug("SQL command executed successfully. Result: %s", result)
    except sqlite3.Error as e:
        logger.error("An error occurred: %s", e)
        logger.error("SQL command: %s", sql_command)
        logger.error("Parameters: %s", parameters)
        conn.rollback()  # Rollback the transaction if error
        raise e
    finally:
        conn.close()

    # time.sleep(1)

    return result


def execute_sql_command_no_return(
    sql_command: str, parameters: tuple = None, test: bool = False
) -> None:
    """
    Execute an SQL command on the database without returning anything.

    Args:
        sql_command (str): The SQL command to execute.
        parameters (tuple): The parameters for the SQL command.
    """
    if sql_command is None:
        return

    if test:
        conn = sqlite3.connect(LOCAL_REPO_PATH / "epanda_test.db")
    else:
        conn = sqlite3.connect(SQL_DB_PATH)

    # Manually control transactions
    conn.isolation_level = None

    cursor = conn.cursor()

    # Start a new transaction
    cursor.execute("BEGIN TRANSACTION")

    try:
        # Execute the SQL command

        # Log the SQL command
        logger.debug("Executing SQL command: %s", sql_command)
        logger.debug("Parameters: %s", parameters)

        if parameters:
            parameters = convert_decimals(parameters)

            if isinstance(parameters[0], tuple):
                cursor.executemany(sql_command, parameters)
            else:
                cursor.execute(sql_command, parameters)
        else:
            cursor.execute(sql_command)
        result = cursor.fetchall()
        # Commit the transaction
        conn.commit()

        # Log the result
        logger.debug("SQL command executed successfully.")
        logger.debug("Result: %s", result)
    except Exception as e:
        logger.error("An error occurred: %s", e)
        logger.error("SQL command: %s", sql_command)
        logger.error("Parameters: %s", parameters)
        # Rollback the transaction on error
        conn.rollback()
        raise e
    finally:
        # Close the connection
        conn.close()

    # time.sleep(1)


def convert_decimals(parameters):
    new_parameters = []
    if isinstance(parameters[0], tuple):
        for parameter in parameters:
            new_parameter = []
            for item in parameter:
                if isinstance(item, Decimal):
                    new_parameter.append(float(item))
                else:
                    new_parameter.append(item)
            new_parameters.append(tuple(new_parameter))
    else:
        for item in parameters:
            if isinstance(item, Decimal):
                new_parameters.append(float(item))
            else:
                new_parameters.append(item)
    return new_parameters
