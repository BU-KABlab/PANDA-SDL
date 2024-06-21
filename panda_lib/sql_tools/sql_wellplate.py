"""SQL Functions for the wellplates and well_hx tables."""

import json
from datetime import datetime
from typing import List, Tuple
from panda_lib.sql_tools import sql_utilities
from panda_lib import wellplate


logger = sql_utilities.logger


# region Wellplate Functions
def check_if_wellplate_exists(plate_id: int) -> bool:
    """Check if a wellplate exists in the wellplates table"""
    result = sql_utilities.execute_sql_command(
        """
        SELECT * FROM wellplates
        WHERE id = ?
        """,
        (plate_id,),
    )
    return result != []


def update_current_wellplate(new_plate_id: int) -> None:
    """Changes the current wellplate's current value to 0 and sets the new
    wellplate's current value to 1"""
    sql_utilities.execute_sql_command_no_return(
        """
        UPDATE wellplates SET current = 0
        WHERE current = 1
        """
    )
    sql_utilities.execute_sql_command_no_return(
        """
        UPDATE wellplates SET current = 1
        WHERE id = ?
        """,
        (new_plate_id,),
    )


def add_wellplate_to_table(plate_id: int, type_id: int) -> None:
    """Add a new wellplate to the wellplates table"""
    sql_utilities.execute_sql_command_no_return(
        """
        INSERT INTO wellplates (id, type_id, current)
        VALUES (?, ?, 0)
        """,
        (plate_id, type_id),
    )


def check_if_current_wellplate_is_new() -> bool:
    """Check if the current wellplate is new"""
    result = sql_utilities.execute_sql_command(
        """
        SELECT status FROM well_hx
        WHERE plate_id = (SELECT id FROM wellplates WHERE current = 1)
        """
    )
    if result == []:
        logger.info("No current wellplate found")
        return False

    # If all the results are 'new' then the wellplate is new
    for row in result:
        if row[0] != "new":
            return False
    return True


def get_number_of_wells(plate_id: int = None) -> int:
    """
    Get the number of wells in the well_hx table for the given or current wellplate.

    Args:
        plate_id (int): The plate ID.

    Returns:
        int: The number of wells.
    """
    if plate_id is None:
        result = sql_utilities.execute_sql_command(
            """
            SELECT COUNT(*) FROM well_hx
            WHERE plate_id = (SELECT id FROM wellplates WHERE current = 1)
            """
        )
    else:
        result = sql_utilities.execute_sql_command(
            """
            SELECT COUNT(*) FROM well_hx
            WHERE plate_id = ?
            """,
            (plate_id,),
        )
    return int(result[0][0])


def get_number_of_clear_wells(plate_id: int = None) -> int:
    """
    Query the well_hx table and count the number of wells with status in
    'new', 'clear','queued' for the current wellplate.

    If plate_id is provided, count the wells of the specified wellplate in
    well_hx instead of the current wellplate.

    Args:
        plate_id (int): The plate ID.

    Returns:
        int: The number of wells with status in 'new', 'clear','queued'.
    """
    if plate_id is None:
        result = sql_utilities.execute_sql_command(
            """
            SELECT COUNT(*) FROM well_hx
            WHERE status IN ('new', 'clear','queued')
            AND plate_id = (SELECT id FROM wellplates WHERE current = 1)
            """
        )
    else:
        result = sql_utilities.execute_sql_command(
            """
            SELECT COUNT(*) FROM well_hx
            WHERE status IN ('new', 'clear','queued')
            AND plate_id = ?
            """,
            (plate_id,),
        )
    return int(result[0][0])


def select_current_wellplate_info() -> tuple[int, int, bool]:
    """
    Get the current wellplate information from the wellplates table.

    Returns:
        tuple[int, int, bool]: The wellplate ID, the wellplate type ID, and
        whether the wellplate is new.
    """
    result = sql_utilities.execute_sql_command(
        """
        SELECT id, type_id FROM wellplates
        WHERE current = 1
        """
    )
    if result == []:
        return 0, 0, False
    is_new = check_if_current_wellplate_is_new()
    return result[0][0], result[0][1], is_new


def select_wellplate_wells(plate_id: int = None) -> List[object]:
    """
    Selects all wells from the well_hx table for a specific wellplate.
    Or if no plate_id is provided, all wells of the current wellplate are
    selected.

    The table has columns:
    plate_id,
    type_number,
    well_id,
    status,
    status_date,
    contents,
    experiment_id,
    project_id,
    volume,
    coordinates
    """
    if plate_id is None:
        result = sql_utilities.execute_sql_command(
            """
            SELECT 
                plate_id,
                type_number,
                well_id,
                status,
                status_date,
                contents,
                experiment_id,
                project_id,
                volume,
                coordinates,
                capacity,
                height

            FROM well_status
            ORDER BY well_id ASC
            """
        )
    else:
        result = sql_utilities.execute_sql_command(
            """
        SELECT 
            a.plate_id,
            b.type_id as type_number,
            a.well_id,
            a.status,
            a.status_date,
            a.contents,
            a.experiment_id,
            a.project_id,
            a.volume,
            a.coordinates,
            c.capacity_ul as capacity,
            c.height_mm as height
        FROM well_hx as a
        JOIN wellplates as b
        ON a.plate_id = b.id
        JOIN well_types as c
        ON b.type_id = c.id
        WHERE a.plate_id = ?
            """,
            (plate_id,),
        )
    if result == []:
        return None

    current_plate_id = select_current_wellplate_info()[0]
    wells = []
    for row in result:
        try:
            incoming_contents = json.loads(row[5])
        except json.JSONDecodeError:
            incoming_contents = {}
        except TypeError:
            incoming_contents = {}

        try:
            incoming_coordinates = json.loads(row[9])
            # incoming_coordinates = wellplate.WellCoordinates(**incoming_coordinates)
        except json.JSONDecodeError:
            incoming_coordinates = (0, 0)

        # well_height, well_capacity,
        # TODO currently the wepplate object applies the well_height and well_capacity
        # If we want the wells to be the primary source of this information, we need to
        # update this script to also pull from well_types and the stop applying
        # the infomation in the wellplate object
        if plate_id is None:
            plate_id = row[0]
            if plate_id is None:
                plate_id = current_plate_id
        wells.append(
            wellplate.Well(
                well_id=row[2],
                well_type_number=row[1],
                status=row[3],
                status_date=row[4],
                contents=incoming_contents,
                experiment_id=row[6],
                project_id=row[7],
                volume=row[8],
                coordinates=incoming_coordinates,
                capacity=row[10],
                height=row[11],
                plate_id=plate_id,
            )
        )
    return wells


def select_well_status(well_id: str, plate_id: int = None) -> str:
    """
    Get the status of a well from the well_hx table.

    Args:
        well_id (str): The well ID.

    Returns:
        str: The status of the well.
    """
    if plate_id is None:
        plate_id = sql_utilities.execute_sql_command(
            "SELECT id FROM wellplates WHERE current = 1"
        )[0][0]
    result = sql_utilities.execute_sql_command(
        "SELECT status FROM well_status WHERE well_id = ? AND plate_id = ?",
        (
            well_id,
            plate_id,
        ),
    )
    return result[0][0]


def count_wells_with_new_status(plate_id: int = None) -> int:
    """
    Count the number of wells with a status of 'new' in the well_hx table.

    Returns:
        int: The number of wells with a status of 'new'.
    """
    if plate_id is not None:
        result = sql_utilities.execute_sql_command(
            """
            SELECT COUNT(*) FROM well_hx
            WHERE status = 'new'
            AND plate_id = ?
            """,
            (plate_id,),
        )
    else:
        result = sql_utilities.execute_sql_command(
            """
            SELECT COUNT(*) FROM well_status
            WHERE status = 'new'
            """
        )

    return int(result[0][0])


def select_next_available_well(plate_id: int = None) -> str:
    """
    Choose the next available well in the well_hx table.

    Returns:
        str: The well ID of the next available well.
    """
    if plate_id is None:
        plate_id = sql_utilities.execute_sql_command(
            "SELECT id FROM wellplates WHERE current = 1"
        )[0][0]

    result = sql_utilities.execute_sql_command(
        """
        SELECT well_id FROM well_hx
        WHERE status = 'new'
        AND plate_id = ?
        ORDER BY SUBSTR(well_id, 1, 1),
              CAST(SUBSTR(well_id, 2) AS UNSIGNED) ASC
        LIMIT 1
        """,
        (plate_id,),
    )

    if result == []:
        return None
    return result[0][0]


# endregion


# region Well Functions
def save_well_to_db(well_to_save: object) -> None:
    """
    First check if the well is in the table. If so update the well where the
        values are different.
    Otherwise insert the well into the table.
    """
    statement = """
        INSERT INTO well_hx (
        plate_id,
        well_id,
        experiment_id,
        project_id,
        status,
        status_date,
        contents,
        volume,
        coordinates
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT (plate_id, well_id) DO UPDATE SET
        experiment_id = excluded.experiment_id,
        project_id = excluded.project_id,
        status = excluded.status,
        status_date = excluded.status_date,
        contents = excluded.contents,
        volume = excluded.volume,
        coordinates = excluded.coordinates

    """
    if well_to_save.plate_id in [None, 0]:
        well_to_save.plate_id = sql_utilities.execute_sql_command(
            "SELECT id FROM wellplates WHERE current = 1"
        )[0][0]

    values = (
        well_to_save.plate_id,
        well_to_save.well_id,
        well_to_save.experiment_id,
        well_to_save.project_id,
        well_to_save.status,
        well_to_save.status_date,
        json.dumps(well_to_save.contents),
        well_to_save.volume,
        json.dumps(well_to_save.coordinates.to_dict()),
    )
    sql_utilities.execute_sql_command_no_return(statement, values)


def save_wells_to_db(wells_to_save: List[object]) -> None:
    """
    First check if the well is in the table. If so update the well where the
        values are different.
    Otherwise insert the well into the table.
    """
    statement = """
        INSERT INTO well_hx (
        plate_id,
        well_id,
        experiment_id,
        project_id,
        status,
        status_date,
        contents,
        volume,
        coordinates
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT (plate_id, well_id) DO UPDATE SET
        experiment_id = excluded.experiment_id,
        project_id = excluded.project_id,
        status = excluded.status,
        status_date = excluded.status_date,
        contents = excluded.contents,
        volume = excluded.volume,
        coordinates = excluded.coordinates
    """
    values = []
    for well in wells_to_save:
        if well.plate_id in [None, 0]:
            well.plate_id = sql_utilities.execute_sql_command(
                "SELECT id FROM wellplates WHERE current = 1"
            )[0][0]

        values.append(
            (
                well.plate_id,
                well.well_id,
                well.experiment_id,
                well.project_id,
                well.status,
                datetime.now().isoformat(timespec="seconds"),
                json.dumps(well.contents),
                well.volume,
                json.dumps(well.coordinates.to_dict()),
            )
        )
    sql_utilities.execute_sql_command_no_return(statement, values)


def insert_well(well_to_insert: object) -> None:
    """
    Get the SQL statement for inserting the entry into the well_hx table.

    Returns:
        str: The SQL statement.
    """
    statement = """
    INSERT INTO well_hx (
        plate_id,
        well_id,
        experiment_id,
        project_id,
        status,
        status_date,
        contents,
        volume,
        coordinates

        ) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """
    values = (
        well_to_insert.plate_id,
        well_to_insert.well_id,
        well_to_insert.experiment_id,
        well_to_insert.project_id,
        well_to_insert.status,
        datetime.now().isoformat(timespec="seconds"),
        json.dumps(well_to_insert.contents),
        well_to_insert.volume,
        json.dumps(well_to_insert.coordinates.to_dict()),
    )
    return sql_utilities.execute_sql_command_no_return(statement, values)


def update_well(well_to_update: object) -> None:
    """
    Updating the entry in the well_hx table that matches the well and plate ids.

    Returns:
        str: The SQL statement.
    """
    statement = """
    UPDATE well_hx 
    SET 
        plate_id = ?,
        well_id = ?,
        experiment_id = ?,
        project_id = ?,
        status = ?,
        status_date = ?,
        contents = ?,
        volume = ?,
        coordinates = ?
    WHERE plate_id = ?
    AND well_id = ?
    """
    values = (
        well_to_update.plate_id,
        well_to_update.well_id,
        well_to_update.experiment_id,
        well_to_update.project_id,
        well_to_update.status,
        datetime.now().isoformat(timespec="seconds"),
        json.dumps(well_to_update.contents),
        well_to_update.volume,
        json.dumps(well_to_update.coordinates.to_dict()),
        well_to_update.plate_id,
        well_to_update.well_id,
    )
    return sql_utilities.execute_sql_command_no_return(statement, values)


def get_well(
    well_id: str,
    plate_id: int = None,
) -> object:
    """
    Get a well from the well_hx table.

    Args:
        plate_id (int): The plate ID.
        well_id (str): The well ID.

    Returns:
        Well: The well.
    """

    if plate_id is None:
        plate_id = sql_utilities.execute_sql_command(
            "SELECT id FROM wellplates WHERE current = 1"
        )[0][0]

    statement = "SELECT * FROM well_hx WHERE plate_id = ? AND well_id = ?"
    values = (plate_id, well_id)
    return complete_well_information(statement, values)


def get_well_by_experiment_id(experiment_id: str) -> Tuple:
    """
    Get a well from the well_hx table by experiment ID.

    Args:
        experiment_id (str): The experiment ID.

    Returns:
        Well: The well.
    """
    statement = """
        SELECT 
            plate_id, 
            well_id,
            experiment_id,
            project_id,
            status,
            status_date,
            contents,
            volume,
            coordinates
        
        FROM well_hx WHERE experiment_id = ?"
    )
    """
    values = (experiment_id,)
    return complete_well_information(statement, values)


def complete_well_information(sql_command: str, values: tuple) -> Tuple:
    """
    Take in the formed sql command from other functions and apply the output to the Well object.
    """
    result = sql_utilities.execute_sql_command(sql_command, values)
    (
        plate_id,
        well_id,
        experiment_id,
        project_id,
        status,
        status_date,
        contents,
        volume,
        coordinates,
        _,
    ) = result[0]

    if result == []:
        logger.error("Error: No well found in the well_hx table.")
        logger.error("Statment Was: %s, Values Were: %s", sql_command, values)
        return None

    # Based on the plate ID, get the well type number, capacity, height
    well_type = sql_utilities.execute_sql_command(
        "SELECT type_id FROM wellplates WHERE id = ?", (plate_id,)
    )

    try:
        capacity, height = sql_utilities.execute_sql_command(
            "SELECT capacity_ul, height_mm FROM well_types WHERE id = ?",
            (well_type[0][0],),
        )[0]
    except IndexError:
        capacity, height = 300, 6
    return Tuple(
        plate_id,
        well_id,
        experiment_id,
        project_id,
        status,
        status_date,
        contents,
        volume,
        (json.loads(coordinates)),
        capacity,
        height,
    )


def select_well_characteristics(type_id: int) -> tuple[int, int, int, int, str]:
    """
    Select the well characteristics from the well_types table.

    Args:
        type_id (int): The well type ID.

    Returns:
        tuple[int, int, int, int, str]: The well type ID, the radius, the offset,
        the capacity, the height, and the shape.
    """
    return sql_utilities.execute_sql_command(
        "SELECT radius_mm, offset_mm, capacity_ul, height_mm, shape FROM well_types WHERE id = ?",
        (type_id,),
    )[0]


def update_well_coordinates(
    well_id: str, plate_id: int, coordinates: object
) -> None:
    """
    Update the coordinates of a well in the well_hx table.

    Args:
        well_id (str): The well ID.
        plate_id (int): The plate ID.
        coordinates (WellCoordinates): The coordinates.
    """
    if plate_id is None:
        plate_id = sql_utilities.execute_sql_command(
            "SELECT id FROM wellplates WHERE current = 1"
        )[0][0]

    sql_utilities.execute_sql_command(
        """
        UPDATE well_hx
        SET coordinates = ?
        WHERE well_id = ?
        AND plate_id = ?
        """,
        (json.dumps(coordinates.to_dict()), well_id, plate_id),
    )


def update_well_status(well_id: str, plate_id: int = None, status: str = None) -> None:
    """
    Update the status of a well in the well_hx table.

    Args:
        well_id (str): The well ID.
        plate_id (int): The plate ID.
        status (str): The status.
    """
    if plate_id is None:
        plate_id = sql_utilities.execute_sql_command(
            "SELECT id FROM wellplates WHERE current = 1"
        )[0][0]
    if status is None:
        status = select_well_status(well_id, plate_id)

    sql_utilities.execute_sql_command_no_return(
        """
        UPDATE well_hx
        SET status = ?,
            status_date = datetime('now', 'localtime')
        WHERE well_id = ?
        AND plate_id = ?
        """,
        (status, well_id, plate_id),
    )


# endregion
