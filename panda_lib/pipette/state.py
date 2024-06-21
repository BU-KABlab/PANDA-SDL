"""
This file contains the PipetteState class, which is used to store the state of a pipette.
"""

class PipetteState:
    def __init__(
        self,
        capacity_ul: float,
        capacity_ml: float,
        volume: float,
        volume_ml: float,
        contents: dict,
    ):
        self.capacity_ul = capacity_ul
        self.capacity_ml = capacity_ml
        self.volume = volume
        self.volume_ml = volume_ml
        self.contents = contents
