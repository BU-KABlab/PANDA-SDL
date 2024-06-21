"""Module for the pipette class"""

import json

from panda_lib.pipette.sql_pipette import (
    insert_pipette_status,
    select_pipette_status,
)
from panda_lib.vessel import logger as vessel_logger

from .state import PipetteState


class Pipette:
    """Class for storing pipette information"""

    def __init__(self, capacity_ul: float = None):
        """Initialize the pipette"""
        self.capacity_ul: float = 0.0
        self.capacity_ml: float = 0.0
        self._volume_ul: float = 0.0
        self._volume_ml: float = 0.0
        self.contents = {}

        if capacity_ul is not None and capacity_ul > 0:
            self.capacity_ul: float = round(float(capacity_ul), 6)
            self.capacity_ml: float = round(float(capacity_ul) / 1000, 6)
            self._volume_ul: float = 0.0
            self._volume_ml: float = 0.0
            self.contents = {}
        else:
            self.read_state_file()
        self.log_contents()

    def set_capacity(self, capacity_ul: float) -> None:
        """Set the capacity of the pipette in ul"""
        if capacity_ul < 0:
            raise ValueError("Capacity must be non-negative.")
        self.capacity_ul = round(float(capacity_ul), 6)
        self.capacity_ml = round(float(capacity_ul) / 1000, 6)
        self.update_state_file()

    def update_contents(self, solution: str, volume_change: float) -> None:
        """Update the contents of the pipette"""
        self.contents[solution] = round(
            float(self.contents.get(solution, 0)) + volume_change, 6
        )
        self.log_contents()

    @property
    def volume(self) -> float:
        """Get the volume of the pipette in ul"""
        return self._volume_ul

    @volume.setter
    def volume(self, volume: float) -> None:
        """Set the volume of the pipette in ul"""
        if volume < 0:
            raise ValueError("Volume must be non-negative.")
        self._volume_ul = round(float(volume), 6)
        self._volume_ml = round(float(volume) / 1000, 6)
        self.update_state_file()
        self.log_contents()

    @property
    def volume_ml(self) -> float:
        """Get the volume of the pipette in ml"""
        return self._volume_ml

    @volume_ml.setter
    def volume_ml(self, volume: float) -> None:
        """Set the volume of the pipette in ml"""
        if volume < 0:
            raise ValueError("Volume must be non-negative.")
        self._volume_ml = round(float(volume), 6)
        self._volume_ul = round(float(volume) * 1000, 6)
        self.log_contents()

    def liquid_volume(self) -> float:
        """Get the volume of liquid in the pipette in ul

        Sum the volume of the pipette contents

        Returns:
            float: The volume of liquid in the pipette in ul
        """
        return round(sum(self.contents.values()), 6)

    def reset_contents(self) -> None:
        """Reset the contents of the pipette"""
        self.contents = {}
        self._volume_ul = 0.0
        self._volume_ml = 0.0
        self.update_state_file()
        self.log_contents()

    def log_contents(self) -> None:
        """Log the contents of the pipette"""
        vessel_logger.info(
            "%s&%s&%s",
            "pipette",
            self._volume_ul,
            self.contents,
        )
        self.update_state_file()

    def update_state_file(self) -> None:
        """Update the state file for the pipette"""
        insert_pipette_status(
            self.capacity_ul,
            self.capacity_ml,
            self._volume_ul,
            self._volume_ml,
            json.dumps(self.contents),
        )

    def read_state_file(self) -> None:
        """
        Select the current state of the pipette from the db
        """
        pipette_status = self.get_pipette_status()
        if pipette_status is not None:
            self.capacity_ul = round(float(pipette_status.capacity_ul), 6)
            self.capacity_ml = round(float(pipette_status.capacity_ml), 6)
            self._volume_ul = round(float(pipette_status.volume), 6)
            self._volume_ml = round(float(pipette_status.volume_ml), 6)
            self.contents = {
                k: round(float(v), 6) for k, v in pipette_status.contents.items()
            }
        else:
            self.reset_contents()
            self.capacity_ul = 200.0
            self.capacity_ml = 0.2
            self.update_state_file()

    def __str__(self):
        return f"Pipette has {self._volume_ul} ul of liquid"

    def get_pipette_status(self) -> "PipetteState":
        """Get the status of the pipette"""
        result = select_pipette_status()
        if result is None:
            return None
        pipette_status = PipetteState(0.0, 0.0, 0.0, 0.0, {})
        pipette_status.capacity_ul = round(float(result[0]), 6)
        pipette_status.capacity_ml = round(float(result[1]), 6)
        pipette_status.volume = round(float(result[2]), 6)
        pipette_status.volume_ml = round(float(result[3]), 6)
        pipette_status.contents = json.loads(result[4]) if result[4] is not None else {}
        return pipette_status
