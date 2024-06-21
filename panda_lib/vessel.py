"""
Vessel module.
"""

import logging
from typing import Union, Optional
from .config.config import PATH_TO_LOGS
from .errors import OverFillException, OverDraftException


class VesselLogger:
    """
    A class to create a logger for vessel-like objects.
    """

    def __init__(self, name):
        self.logger = logging.getLogger(name)
        self.logger.setLevel(logging.DEBUG)
        formatter = logging.Formatter(
            "%(asctime)s&%(name)s&%(module)s&%(funcName)s&%(lineno)d&%(message)s"
        )
        file_handler = logging.FileHandler(PATH_TO_LOGS / f"{name}.log")
        file_handler.setFormatter(formatter)
        self.logger.addHandler(file_handler)


# Create an instance of the logger for the vessel module
logger = VesselLogger("vessel").logger

class VesselCoordinates:
    """
    Represents the coordinates of a vessel.

    Args:
    -----
        x (Union[int, float, float]): The x-coordinate of the vessel.
        y (Union[int, float, float]): The y-coordinate of the vessel.
        z_top (Union[int, float, float], optional): The z-coordinate of top the vessel.
        z_bottom (Union[int, float, float], optional): The z-coordinate of the bottom of the vessel.
    """

    def __init__(
        self,
        x: Union[int, float],
        y: Union[int, float],
        z_top: Union[int, float] = 0,
        z_bottom: Optional[Union[int, float]] = None,
    ) -> None:
        """Initializes a new instance of the Coordinates class."""
        self.x = float(x)
        self.y = float(y)
        self.z_top = float(z_top)
        self.z_bottom = float(z_bottom) if z_bottom is not None else 0

    def __str__(self) -> str:
        """Returns a string representation of the coordinates."""
        return f'"x"={self.x}, "y"={self.y}, "z_top"={self.z_top}, "z_bottom"={self.z_bottom}'

    def __repr__(self) -> str:
        """Returns a string representation of the coordinates."""
        return f'"x"={self.x}, "y"={self.y}, "z_top"={self.z_top}, "z_bottom"={self.z_bottom}'

    def __dict__(self) -> dict:
        """Returns a dictionary representation of the coordinates."""
        return {
            "x": self.x,
            "y": self.y,
            "z_top": self.z_top,
            "z_bottom": self.z_bottom,
        }

    def standard_dict(self) -> dict:
        """Returns a dictionary representation of the coordinates with only integers and floats."""
        return {
            "x": round(self.x, 6),
            "y": round(self.y, 6),
            "z_top": round(self.z_top, 6),
            "z_bottom": round(self.z_bottom, 6),
        }

    def to_dict(self) -> dict:
        return self.standard_dict()

    def __getitem__(self, key: str) -> Union[int, float]:
        """Returns the value of the specified key."""
        return getattr(self, key)

    def __setitem__(self, key: str, value: Union[int, float]) -> None:
        """Sets the value of the specified key."""
        setattr(self, key, value)

    def __iter__(self):
        return iter([self.x, self.y, self.z_top, self.z_bottom])

    def __len__(self):
        return 4

    def __eq__(self, other: "VesselCoordinates") -> bool:
        """Returns True if the coordinates are equal, False otherwise."""
        return all(
            [
                self.x == other.x,
                self.y == other.y,
                self.z_top == other.z_top,
                self.z_bottom == other.z_bottom,
            ]
        )

    def __ne__(self, other: "VesselCoordinates") -> bool:
        """Returns True if the coordinates are not equal, False otherwise."""
        return not self.__eq__(other)


class Vessel:
    """
    Represents a vessel object.

    Attributes:
        name (str): The name of the vessel.
        volume (float): The current volume of the vessel.
        capacity (float): The maximum capacity of the vessel.
        density (float): The density of the solution in the vessel.
        coordinates (Union[VesselCoordinates, dict]): The coordinates of the vessel.
        contents (dict): The contents of the vessel.
        depth (float): The current depth of the solution in the vessel.

    Methods:
    --------
    update_volume(added_volume: float) -> None
        Updates the volume of the vessel by adding the specified volume.
    calculate_depth() -> float
        Calculates the current depth of the solution in the vessel.
    check_volume(volume_to_add: float) -> bool
        Checks if the volume to be added to the vessel is within the vessel's capacity.
    write_volume_to_disk() -> None
        Writes the current volume of the vessel to the appropriate file.
    update_contamination(new_contamination: int = None) -> None
        Updates the contamination count of the vessel.
    update_contents(from_vessel: str, volume: float) -> None
        Updates the contents of the vessel.
    get_contents() -> dict
        Returns the contents of the vessel.
    log_contents() -> None
        Logs the contents of the vessel.

    """

    def __init__(
        self,
        name: str,
        volume: float,
        capacity: float,
        density: float,
        coordinates: Union[VesselCoordinates, dict],
        contents={},
        depth: float = float(0),
    ) -> None:
        self.name = name.lower() if name is not None else ""
        self.position = None
        self.volume = volume
        self.capacity = capacity
        self.density = density
        self.viscosity_cp = float(0.0)
        if isinstance(coordinates, dict):
            self.coordinates = VesselCoordinates(**coordinates)
        else:
            self.coordinates = coordinates

        self.contents = contents
        self.depth = depth

        # Round all floats to 6 decimal places
        self.volume = round(self.volume, 6) if self.volume is not None else 0
        self.capacity = round(self.capacity, 6) if self.capacity is not None else 0
        self.density = round(self.density, 6) if self.density is not None else 0
        self.depth = round(self.depth, 6) if self.depth is not None else 0

    def __str__(self) -> str:
        return f"{self.name} has {self.volume} ul of {self.density} g/ml liquid"

    def update_volume(self, added_volume: float) -> None:
        """Updates the volume of the vessel by adding the specified volume."""
        added_volume = round(added_volume,6)
        if self.volume + added_volume > self.capacity:
            raise OverFillException(self.name, self.volume, added_volume, self.capacity)
        if self.volume + added_volume < float(0):
            raise OverDraftException(
                self.name, self.volume, added_volume, self.capacity
            )

        self.volume = round(self.volume + added_volume, 6)
        logger.info(
            "%s&%s",
            self.name + "_" + self.position if self.position is not None else self.name,
            self.volume,
        )

        return self

    def calculate_depth(self) -> float:
        """Calculates the current depth of the solution in the vessel."""
        # Different vessels will have different implementations of this method
        pass

    def check_volume(self, volume_to_add: float) -> bool:
        """
        Checks if the volume to be added to the vessel is within the vessel's capacity.

        Args:
        -----
        volume_to_add (float): The volume to be added to the vessel.

        Returns:
            bool: True if the volume to be added is within the vessel's capacity, False otherwise.
        """
        if self.volume + volume_to_add > self.capacity:
            raise OverFillException(
                self.name, self.volume, volume_to_add, self.capacity
            )
        if self.volume + volume_to_add < float(0):
            raise OverDraftException(
                self.name, self.volume, volume_to_add, self.capacity
            )
        return True

    def write_volume_to_disk(self) -> None:
        """
        Writes the current volume of the vessel to the appropriate file.
        """
        # Different vessels will have different implementations of this method
        pass

    def update_contamination(self, new_contamination: int = None) -> None:
        """
        Updates the contamination count of the vessel.

        Parameters:
        -----------
        new_contamination (int, optional): The new contamination count of the vessel.
        """
        # Different vessels will have different implementations of this method due to 
        # the different ways they save to the db
        pass

    def update_contents(self, from_vessel: str, volume: float) -> None:
        """
        Updates the contents of the vessel.

        Parameters:
        -----------
        from_vessel (str): The name of the vessel from which the solution is being transferred.
        volume (float): The volume of the solution to be added to the vessel.
        """
        # Different vessels will have different implementations of this method
        pass

    def get_contents(self) -> dict:
        """
        Returns the contents of the vessel.

        Returns:
        --------
        dict: The contents of the vessel.
        """
        return self.contents

    def log_contents(self) -> None:
        """Logs the contents of the vessel."""
        logger.info(
            "%s&%s&%s",
            self.name + "_" + self.position if self.position is not None else self.name,
            self.volume,
            self.contents,
        )
