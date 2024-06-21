"""Define the possible statuses of an experiment"""
from enum import Enum

class ExperimentStatus(str, Enum):
    """Define the possible statuses of an experiment"""

    NEW = "new"
    QUEUED = "queued"
    RUNNING = "running"
    OCPCHECK = "ocpcheck"
    DEPOSITING = "depositing"
    EDEPOSITING = "e_depositing"
    RINSING = "rinsing"
    ERINSING = "rinsing electrode"
    BASELINE = "baselining"
    CHARACTERIZING = "characterizing"
    CA = "cyclic-amperometry"
    CV = "cyclic-voltametry"
    FINAL_RINSE = "final_rinse"
    COMPLETE = "complete"
    ERROR = "error"
    MIXING = "mixing"
    IMAGING = "imaging"
    CLEARING = "clearing"
    FLUSHING = "flushing"
    PAUSED = "paused"
    CANCELLED = "cancelled"
    PENDING = "pending"  # pending experiments either are waiting for a well to be assigned or lack the correct well type

