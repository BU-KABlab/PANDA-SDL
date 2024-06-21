"""a virtual pstat for testing main code logic"""
import logging
import pathlib
from typing import Tuple
from pydantic.dataclasses import dataclass
from pydantic import ConfigDict
import numpy as np
from .config.config import PATH_TO_DATA
logger = logging.getLogger("e_panda")

class GamryPotentiostat:
    def __init__(self):
        self.OPEN_CONNECTION = False


    def pstatconnect(self):
        self.OPEN_CONNECTION = True

    def connect(self):
        self.OPEN_CONNECTION = True

    def disconnect(self):
        self.OPEN_CONNECTION = False

    def pstatdisconnect(self):
        self.OPEN_CONNECTION = False

    def OCP(self, OCPvi, OCPti, OCPrate):
        self.OPEN_CONNECTION = True
        pass

    def activecheck(self):
        return self.OPEN_CONNECTION

    def check_vf_range(self, file) -> Tuple[bool, float]:
        self.OPEN_CONNECTION = True
        return True, 0.0

    def setfilename(self,
        experiment_id,
        experiment_type,
        project_campaign_id: int = None,
        campaign_id: int = None,
        well_id: str = None,
        ) -> pathlib.Path:
        """set the file name for the experiment"""
        global COMPLETE_FILE_NAME
        if project_campaign_id is None and campaign_id is None and well_id is None:
            file_name = f"{experiment_id}_{experiment_type}"
            file_name = file_name.replace(" ", "_")
            file_name_start = file_name + "_0"
            filepath: pathlib.Path = (PATH_TO_DATA / file_name_start).with_suffix(".txt")
            i = 1
            while filepath.exists():
                next_file_name = f"{file_name}_{i}"
                filepath = pathlib.Path(PATH_TO_DATA / str(next_file_name)).with_suffix(".txt")
                i += 1
        else:
            file_name = f"{project_campaign_id}_{campaign_id}_{experiment_id}_{well_id}_{experiment_type}"
            file_name = file_name.replace(" ", "_")
            file_name_start = file_name + "_0"
            filepath: pathlib.Path = (PATH_TO_DATA / file_name_start).with_suffix(".txt")
            # Check if the file already exists. If it does then add a number to the end of the file name
            i = 1
            while filepath.exists():
                next_file_name = f"{file_name}_{i}"
                filepath = pathlib.Path(PATH_TO_DATA / str(next_file_name)).with_suffix(".txt")
                i += 1

        COMPLETE_FILE_NAME = filepath
        COMPLETE_FILE_NAME.touch()
        return COMPLETE_FILE_NAME

    def chrono(self, CAvi, CAti, CAv1, CAt1, CAv2, CAt2, CAsamplerate):
        pass

    def cyclic(self, CVvi, CVap1, CVap2, CVvf, CVsr1, CVsr2, CVsr3, CVsamplerate, CVcycle):
        pass

    def save_data(self, complete_file_name):
        np.savetxt(complete_file_name, np.array([[1, 2], [3, 4]]), delimiter=",")
    
    def __enter__(self):
        self.connect()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.disconnect()

@dataclass(config=ConfigDict(validate_assignment=True))
class potentiostat_cv_parameters:
    """CV Setup Parameters"""

    # CV Setup Parameters
    CVvi: float = 0.0  # initial voltage
    CVap1: float = 0.5 
    CVap2: float = -0.2 
    CVvf: float = 0.0  # final voltage
    CVstep: float = 0.01
    CVsr1: float = 0.1
    CVcycle: int = 3
    CVsr2: float = CVsr1
    CVsr3: float = CVsr1
    CVsamplerate: float = CVstep / CVsr1


@dataclass(config=ConfigDict(validate_assignment=True))
class potentiostat_chrono_parameters:
    """CA Setup Parameters"""

    # CA/CP Setup Parameters
    CAvi: float = 0.0  # Pre-step voltage (V)
    CAti: float = 0.0  # Pre-step delay time (s)
    CAv1: float = -1.7  # Step 1 voltage (V)
    CAt1: float = 300.0  # run time 300 seconds
    CAv2: float = 0.0  # Step 2 voltage (V)
    CAt2: float = 0.0  # Step 2 time (s)
    CAsamplerate: float = 0.5  # sample period (s)
    # Max current (mA)
    # Limit I (mA/cm^2)
    # PF Corr. (ohm)
    # Equil. time (s)
    # Expected Max V (V)
    # Initial Delay on
    # Initial Delay (s)


@dataclass(config=ConfigDict(validate_assignment=True))
class potentiostat_ocp_parameters:
    """OCP Setup Parameters"""

    # OCP Setup Parameters
    OCPvi: float = 0.0
    OCPti: float = 15.0
    OCPrate: float = 0.5