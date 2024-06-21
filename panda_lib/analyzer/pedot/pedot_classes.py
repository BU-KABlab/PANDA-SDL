from dataclasses import dataclass
from pathlib import Path
from typing import List, Union
@dataclass
class RequiredData:
    """Input data for the PEDOT analysis and ML model"""
    experiment_id: int
    ca_step_1_voltage: float
    ca_step_1_time: float
    edot_concentration: float
    CA_deposition: Path
    CV_characterization: Path
    CA_bleaching: Path
    BeforeDeposition: Path
    AfterBleaching: Path
    AfterColoring: Path = None


@dataclass
class RawMetrics:
    """Input data for the PEDOT analysis"""
    experiment_id: int
    l_c: float
    a_c: float
    b_c: float
    l_b: float
    a_b: float
    b_b: float
    delta_e00: float
    r_c_o: float
    g_c_o: float
    b_c_o: float
    r_b_o: float
    g_b_o: float
    b_b_o: float
    coloring_roi_path: Path
    bleaching_roi_path: Path
    deposition_roi_path: Path

@dataclass
class PEDOTMetrics:
    """Output of PEDOT analysis"""
    experiment_id: int
    DepositionChargePassed: float
    BleachChargePassed: float
    Capacitance: float
    DepositionEfficiency: float
    ElectrochromicEfficiency: float

@dataclass
class MLTrainingData:
    """Input data for the ML model"""
    experiment_id: int
    ca_step_1_voltage: float
    ca_step_1_time: float
    edot_concentration: float
    deltaE00: float
    BleachChargePassed: float
    DepositionEfficiency: float
    ElectrochromicEfficiency: float

@dataclass
class MLInput:
    """The filepaths for the ML model's data and supporting files"""
    training_file_path: Path
    model_base_path: Path
    counter_file_path: Path
    BestTestPointsCSV: Path
    contourplots_path: Path

@dataclass
class MLOutput:
    """Output of the ML model"""
    v_dep: float
    t_dep: float
    edot_concentration: float
    predicted_mean: float
    predicted_stddev: float
    contour_plot: Path = None
    model_id:int = None

@dataclass
class PEDOTParams:
    """Parameters for PEDOT experiments"""
    dep_v: float
    dep_t: float
    well_letter: str = None
    well_number: int = None
    concentration: float = 0.1
