"""The home of all project specific strings and values that are 
better to be set in one place than to be scattered around the code."""

from pathlib import Path
from os import environ
import sqlite3


def get_repo_path():
    """Returns the path of the repository."""
    current_file = Path(__file__).resolve()
    repo_path = current_file.parent.parent
    return repo_path


def read_testing_config():
    """Reads the testing configuration file."""
    repo_path = get_repo_path()
    config_path = repo_path / "config" / "testing.txt"
    with open(config_path, "r", encoding="utf-8") as f:
        return f.read().strip() == "True"


def write_testing_config(value: bool):
    """Writes the testing configuration file."""
    repo_path = get_repo_path()
    config_path = repo_path / "config" / "testing.txt"
    with open(config_path, "w", encoding="utf-8") as f:
        f.write(str(value))
    environ["PANDA_SDL_TESTING"] = str(int(value))


## Project default values
AIR_GAP = float(40.0)  # ul
DRIP_STOP = float(5.0)  # ul
PURGE_VOLUME = float(20)  # ul
RANDOM_FLAG = False  # True to randomize experiment order (grouped by priority)
DEFAULT_PUMPING_RATE = float(0.3)  # ul/s

## Define local repository path - will also be used during testing
LOCAL_REPO_PATH = Path(__file__).parents[2]

## Testing flag
# testing.txt is the only place to change the mode besides from the main menue
# The file is created if it does not exist

if not (LOCAL_REPO_PATH / "panda_lib" / "config" / "testing.txt").exists():
    write_testing_config(True)  # Default is testing mode

## Flag to use only local paths - can be changed while running the program
TESTING_MODE_ACTIVE = read_testing_config()
try:
    TESTING_DIRECTORY = environ["PANDA_SDL_TESTING_PATH"]

    if TESTING_DIRECTORY in [None, "",'None']:
        raise KeyError

    TESTING_DIRECTORY = Path(TESTING_DIRECTORY)

except KeyError:
    TESTING_DIRECTORY = LOCAL_REPO_PATH
## Define external path for data, logs, and system state

if not TESTING_MODE_ACTIVE:
    try:
        PRODUCTION_DIRECTORY = environ["PANDA_SDL_EXTERNAL_PATH"]

        if PRODUCTION_DIRECTORY in [None, "",'None']:
            raise KeyError

        PRODUCTION_DIRECTORY = Path(PRODUCTION_DIRECTORY)
    except KeyError:
        print("PANDA_SDL_EXTERNAL_PATH environment variable not set.")
        print("Switching to testing mode")
        write_testing_config(True)
        TESTING_MODE_ACTIVE = True


## Project File Names
__MILL_CONFIG_FILE_NAME = "mill_config.json"
__WELLPLATE_CONFIG_FILE_NAME = "wellplate_location.json"

## Project directory names
__CODE = "panda_lib"
__CONFIG = "config"
__DATA = "data"
__LOGS = "logs"
__SYS_STATE = "system state"
__IMAGES = "application_images"

## FLIR Camera related - must be a python 3.6 environment
try:
    PYTHON_360_PATH = environ["PANDA_SDL_PYTHON_360_PATH"]

    if PYTHON_360_PATH in [None, "",'None']:
        raise KeyError

    PYTHON_360_PATH = Path(PYTHON_360_PATH)
except KeyError:
    raise ValueError("PANDA_SDL_PYTHON_360_PATH environment variable not set.")

CAMERA_SCRIPT_PATH = Path(LOCAL_REPO_PATH / __CODE / "flir_camera" / "camera.py")

## Build complete paths for each project directory or file
if TESTING_MODE_ACTIVE:
    # Directories
    PATH_TO_CODE = LOCAL_REPO_PATH / __CODE
    PATH_TO_CONFIG = PATH_TO_CODE / __CONFIG
    PATH_TO_DATA = TESTING_DIRECTORY / __DATA
    PATH_TO_LOGS = TESTING_DIRECTORY / __LOGS
    PATH_TO_DATA = TESTING_DIRECTORY / __DATA
    PATH_TO_LOGS = TESTING_DIRECTORY / __LOGS
    PATH_TO_IMAGES = PATH_TO_CODE / __IMAGES

    # Files
    MILL_CONFIG = PATH_TO_CONFIG / __MILL_CONFIG_FILE_NAME
    WELLPLATE_LOCATION = PATH_TO_CONFIG / __WELLPLATE_CONFIG_FILE_NAME
    EPANDA_LOG = PATH_TO_LOGS / "ePANDA.log"
    DATA_ZONE_LOGO = PATH_TO_IMAGES / "data_zone_logo.png"

    # DB
    try:
        SQL_DB_PATH = environ["PANDA_SDL_TESTING_DB_PATH"]

        if SQL_DB_PATH in [None, "",'None']:
            raise KeyError

        SQL_DB_PATH = Path(SQL_DB_PATH)
    except KeyError:
        print("PANDA_SDL_TESTING_DB_PATH environment variable not set in .env file.")
        print("Using default path")
        SQL_DB_PATH = LOCAL_REPO_PATH / "test.db"

    # Test that the db exists, and if not create it using the included test_db.sql
    if not SQL_DB_PATH.exists():
        Path(SQL_DB_PATH).with_suffix(".db").touch()
        conn = sqlite3.connect(SQL_DB_PATH)
        with open(LOCAL_REPO_PATH / "test_db.sql", "r") as f:
            conn.executescript(f.read())
        conn.close()

    ## Validate that all paths exist and create them if they don't
    for path in [
        PATH_TO_CODE,
        PATH_TO_CONFIG,
        PATH_TO_DATA,
        PATH_TO_LOGS,
        PATH_TO_DATA,
        PATH_TO_LOGS,
        PATH_TO_IMAGES,
    ]:
        path = Path(path)
        if not path.exists():
            path.mkdir()
            print(f"Created {path}")

else:  # Use external paths
    # Directories
    PATH_TO_CODE = LOCAL_REPO_PATH / __CODE
    PATH_TO_CONFIG = PATH_TO_CODE / __CONFIG
    PATH_TO_DATA = PRODUCTION_DIRECTORY / __DATA
    PATH_TO_LOGS = PRODUCTION_DIRECTORY / __LOGS
    PATH_TO_DATA = PRODUCTION_DIRECTORY / __DATA
    PATH_TO_LOGS = PRODUCTION_DIRECTORY / __LOGS
    PATH_TO_IMAGES = PATH_TO_CODE / __IMAGES

    # Files
    MILL_CONFIG = PATH_TO_CONFIG / __MILL_CONFIG_FILE_NAME
    WELLPLATE_LOCATION = PATH_TO_CONFIG / __WELLPLATE_CONFIG_FILE_NAME
    EPANDA_LOG = PATH_TO_LOGS / "ePANDA.log"
    DATA_ZONE_LOGO = PATH_TO_IMAGES / "data_zone_logo.png"

    # DB
    try:
        SQL_DB_PATH = environ["PANDA_SDL_PRODUCTION_DB_PATH"]

        if SQL_DB_PATH in [None, "",'None']:
            raise KeyError

        SQL_DB_PATH = Path(SQL_DB_PATH)
    except KeyError:
        print("PANDA_SDL_PRODUCTION_DB_PATH environment variable not set in .env file.")
        print("Using a local db")
        SQL_DB_PATH = LOCAL_REPO_PATH / "prod.db"
        if not Path(SQL_DB_PATH).with_suffix(".db").exists():
            Path(SQL_DB_PATH).with_suffix(".db").touch()
            conn = sqlite3.connect(SQL_DB_PATH)
            with open(LOCAL_REPO_PATH / "test_db.sql", "r") as f:
                conn.executescript(f.read())
            conn.close()

    # Test that a connection can be made to the db. If not raise exception
    try:
        conn = sqlite3.connect(SQL_DB_PATH)
        conn.close()
    except sqlite3.Error as e:
        raise f"Error connecting to database: {e}" from e

    ## Validate that all paths exist and create them if they don't
    for path in [
        PATH_TO_CODE,
        PATH_TO_CONFIG,
        PATH_TO_DATA,
        PATH_TO_LOGS,
        PATH_TO_DATA,
        PATH_TO_LOGS,
        PATH_TO_IMAGES,
    ]:
        path = Path(path)
        if not path.exists():
            path.mkdir()
            print(f"Created {path}")
