"""Utilities for setting and reading the configuration files"""
from pathlib import Path
import importlib
from panda_lib.config import config
import os

def get_repo_path():
    """Returns the path of the repository."""
    current_file = Path(__file__).resolve()
    repo_path = current_file.parent.parent
    return repo_path

def reload_config(func):
    """Decorator to reload the configuration file."""
    def wrapper(*args, **kwargs):
        importlib.reload(config)
        return func(*args, **kwargs)
    return wrapper

@reload_config
def read_testing_config():
    """Reads the testing configuration file."""
    repo_path = get_repo_path()
    config_path = repo_path / "config" / "testing.txt"
    with open(config_path, "r", encoding="utf-8") as f:
        return f.read().strip() == "True"

@reload_config
def write_testing_config(value: bool):
    """Writes the testing configuration file."""
    repo_path = get_repo_path()
    config_path = repo_path / "config" / "testing.txt"
    with open(config_path, "w", encoding="utf-8") as f:
        f.write(str(value))
    os.environ["PANDA_SDL_TESTING"] = str(int(value))
