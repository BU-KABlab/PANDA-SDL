import importlib
import os
import sqlite3

from panda_lib.config.config import SQL_DB_PATH

# region Generators


class GeneratorEntry:
    """A class to represent a generator entry in the database."""

    def __init__(self, generator_id, project_id, protocol_id, name, filepath):
        self.generator_id = generator_id
        self.project_id = project_id
        self.protocol_id = protocol_id
        self.name = name
        self.filepath = filepath

    def __str__(self):
        return f"{self.generator_id}: {self.name}"


def get_generators() -> list:
    """
    Get all generators from the database.

    Args:
        None

    Returns:
        list: A list of all generators in the database.
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Get all generators from the database
    cursor.execute("SELECT * FROM generators")
    generators = cursor.fetchall()

    conn.close()

    generator_entries = []
    for generator in generators:
        generator_entry = GeneratorEntry(*generator)
        generator_entries.append(generator_entry)

    return generator_entries


def get_generator_by_id(generator_id) -> GeneratorEntry:
    """
    Get a generator from the database.

    Args:
        generator_id (int): The ID of the generator to get.

    Returns:
        GeneratorEntry: The generator from the database.
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Get the generator from the database
    cursor.execute("SELECT * FROM generators WHERE id = ?", (generator_id,))
    generator = cursor.fetchone()

    conn.close()

    generator_entry = GeneratorEntry(*generator)
    return generator_entry


def insert_generator(generator_id, project_id, protocol_id, name, filepath):
    """
    Insert a generator into the database.

    Args:
        generator_id (int): The ID of the generator.
        project_id (int): The project ID of the generator.
        protocol_id (int): The protocol ID of the generator.
        name (str): The name of the generator.
        filepath (str): The filepath of the generator.

    Returns:
        None
    """

    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Insert the generator into the database
    cursor.execute(
        "INSERT INTO generators (id, project_id, protocol_id, name, filepath) VALUES (?, ?, ?, ?, ?)",
        (generator_id, project_id, protocol_id, name, filepath),
    )

    conn.commit()
    conn.close()


def update_generator(generator_id, new_name):
    """
    Update the name of a generator in the database.

    Args:
        generator_id (int): The ID of the generator to update.
        new_name (str): The new name to set for the generator.

    Returns:
        None
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Update the name of the generator in the database
    cursor.execute(
        "UPDATE generators SET name = ? WHERE id = ?", (new_name, generator_id)
    )

    conn.commit()
    conn.close()


def delete_generator(generator_id):
    """
    Delete a generator from the database.

    Args:
        generator_id (int): The ID of the generator.

    Returns:
        None
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Delete the generator from the database
    cursor.execute("DELETE FROM generators WHERE id = ?", (generator_id,))

    conn.commit()
    conn.close()


def read_in_generators():
    """
    Read in all generator files from the current generators folder, assigning an id to each one.
    Ignoring this file as well as any files that are already in the database.
    Args:
        None

    Returns:
        None
    """

    # Get the generators folder from the environment variables
    try:
        generators = os.environ["PANDA_SDL_GENERATORS_DIR"]
    except KeyError as e:
        raise ValueError(
            "PANDA_SDL_GENERATORS_DIR environment variable not set in .env file."
        ) from e

    # Get all files in the generators folder
    generators = os.listdir(generators)

    # Remove any __ files from the list
    generators = [generator for generator in generators if "__" not in generator]

    # remove any non-python files from the list
    generators = [generator for generator in generators if ".py" in generator]

    # Get the current generators from the database
    current_generators = get_generators()

    # Get the current generator ids
    current_generator_ids = [generator.generator_id for generator in current_generators]

    # Get the next generator id
    if current_generator_ids:
        next_generator_id = max(current_generator_ids) + 1
    else:
        next_generator_id = 1

    # Get the filepaths of the current generators
    current_generator_filepaths = [
        generator.filepath for generator in current_generators
    ]

    # Iterate through the generators
    for generator in generators:
        # If the generator is not already in the database
        if generator not in current_generator_filepaths:
            # Insert the generator into the database
            insert_generator(next_generator_id, "", "", generator[:-3], generator)
            next_generator_id += 1
        else:
            # Get the id of the generator
            generator_id = current_generators[
                current_generator_filepaths.index(generator)
            ].generator_id

            # Update the generator in the database
            update_generator(generator_id, generator)

    # Delete any generators that are no longer in the generators folder
    for generator in current_generators:
        if generator.filepath not in generators:
            delete_generator(generator.generator_id)


def get_generator_id(generator_name) -> int:
    """
    Get the id of a generator from the database.

    Args:
        generator_name (str): The name of the generator.

    Returns:
        int: The id of the generator.
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Get the id of the generator from the database
    cursor.execute("SELECT id FROM generators WHERE name = ?", (generator_name,))
    generator_id = cursor.fetchone()[0]

    conn.close()

    return generator_id


def get_generator_name(generator_id) -> str:
    """
    Get the name of a generator from the database.

    Args:
        generator_id (int): The id of the generator.

    Returns:
        str: The name of the generator.
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Get the name of the generator from the database
    cursor.execute("SELECT name FROM generators WHERE id = ?", (generator_id,))
    generator_name = cursor.fetchone()[0]

    conn.close()

    return generator_name


def run_generator(generator_id):
    """
    Run a generator.

    Args:
        generator_id (int): The id of the generator to run.

    Returns:
        None
    """
    generator = get_generator_by_id(generator_id)
    print(f"Running generator {generator.name}...")
    generator_module = importlib.import_module(
        f"experiment_generators.{generator.filepath[:-3]}"
    )
    generator_function = getattr(generator_module, "main")
    generator_function()
    print(f"Generator {generator.name} complete.")


# endregion

# region Protocols
from panda_lib.errors import ProtocolNotFoundError


class ProtocolEntry:
    """A class to represent a protocol entry in the database."""

    def __init__(self, protocol_id, project, name, filepath):
        self.protocol_id = protocol_id
        self.project = project
        self.name = name
        self.filepath = filepath

    def __str__(self):
        return f"{self.protocol_id}: {self.name}"


def select_protocols() -> list:
    """
    Get all protocols from the database.

    Args:
        None

    Returns:
        list: A list of all protocols in the database.
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Get all protocols from the database
    cursor.execute("SELECT * FROM protocols")
    protocols = cursor.fetchall()

    conn.close()

    protocol_entries = []
    for protocol in protocols:
        protocol_entry = ProtocolEntry(*protocol)
        protocol_entries.append(protocol_entry)

    return protocol_entries


def select_protocol_by_id(protocol_id) -> ProtocolEntry:
    """
    Get a protocol from the database.

    Args:
        protocol_id (int): The ID of the protocol to get.

    Returns:
        ProtocolEntry: The protocol from the database.
    """
    try:
        conn = sqlite3.connect(SQL_DB_PATH)
        cursor = conn.cursor()

        # Get the protocol from the database
        cursor.execute(
            "SELECT id, project, name, filepath FROM protocols WHERE id = ?",
            (protocol_id,),
        )
        protocol = cursor.fetchone()

        conn.close()

        protocol_entry = ProtocolEntry(*protocol)
        return protocol_entry
    except TypeError as exc:
        raise ProtocolNotFoundError(
            f"Protocol with id {protocol_id} not found."
        ) from exc


def insert_protocol(protocol_id, project, name, filepath):
    """
    Insert a protocol into the database.

    Args:
        protocol_id (int): The ID of the protocol.
        project (str): The project of the protocol.
        name (str): The name of the protocol.
        filepath (str): The filepath of the protocol.

    Returns:
        None
    """

    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Insert the protocol into the database
    cursor.execute(
        "INSERT INTO protocols (id, project, name, filepath) VALUES (?, ?, ?, ?)",
        (protocol_id, project, name, filepath),
    )

    conn.commit()
    conn.close()


def update_protocol(protocol_id, new_name):
    """
    Update the name of a protocol in the database.

    Args:
        protocol_id (int): The ID of the protocol to update.
        new_name (str): The new name to set for the protocol.

    Returns:
        None
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Update the name of the protocol in the database
    cursor.execute(
        "UPDATE protocols SET name = ? WHERE id = ?", (new_name, protocol_id)
    )

    conn.commit()
    conn.close()


def delete_protocol(protocol_id):
    """
    Delete a protocol from the database.

    Args:
        protocol_id (int): The ID of the protocol.

    Returns:
        None
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Delete the protocol from the database
    cursor.execute("DELETE FROM protocols WHERE id = ?", (protocol_id,))

    conn.commit()
    conn.close()


def read_in_protocols():
    """
    Read in all protocol files from the current protocols folder, assigning an id to each one.
    Ignoring this file as well as any files that are already in the database.
    Args:
        None

    Returns:
        None
    """

    # Get all files in the protocols folder
    protocols = os.listdir("protocols")
    # Remove an non .py files
    protocols = [protocol for protocol in protocols if protocol.endswith(".py")]
    # Get the current protocols from the database
    current_protocols = select_protocols()

    # Get the current protocol ids
    current_protocol_ids = [protocol.protocol_id for protocol in current_protocols]

    # Get the next protocol id
    if current_protocol_ids:
        next_protocol_id = max(current_protocol_ids) + 1
    else:
        next_protocol_id = 1

    # Get the filenames of the current protocols
    current_protocol_filenames = [protocol.name for protocol in current_protocols]
    # get filepaths of current protocols
    current_protocol_filepaths = [protocol.filepath for protocol in current_protocols]
    # Iterate through the protocols
    for protocol in protocols:
        # If the protocol is not already in the database
        if protocol not in current_protocol_filepaths:
            # Insert the protocol into the database
            insert_protocol(next_protocol_id, "", protocol[:-3], protocol)
            next_protocol_id += 1
        else:
            # Get the id of the protocol
            protocol_id = current_protocols[
                current_protocol_filepaths.index(protocol)
            ].protocol_id

            # Update the protocol in the database
            update_protocol(protocol_id, protocol)

    # Delete any protocols that are no longer in the protocols folder
    for protocol in current_protocols:
        if protocol.filepath not in protocols:
            delete_protocol(protocol.protocol_id)


def select_protocol_id(protocol_name) -> int:
    """
    Get the id of a protocol from the database.

    Args:
        protocol_name (str): The name of the protocol.

    Returns:
        int: The id of the protocol.
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Get the id of the protocol from the database
    cursor.execute("SELECT id FROM protocols WHERE name = ?", (protocol_name,))
    protocol_id = cursor.fetchone()[0]

    conn.close()

    return protocol_id


def select_protocol_name(protocol_id) -> str:
    """
    Get the name of a protocol from the database.

    Args:
        protocol_id (int): The id of the protocol.

    Returns:
        str: The name of the protocol.
    """
    conn = sqlite3.connect(SQL_DB_PATH)
    cursor = conn.cursor()

    # Get the name of the protocol from the database
    cursor.execute("SELECT name FROM protocols WHERE id = ?", (protocol_id,))
    protocol_name = cursor.fetchone()[0]

    conn.close()

    return protocol_name


# end region
