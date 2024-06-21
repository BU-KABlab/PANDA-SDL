from enum import Enum

class ExperimentResultsRecord:
    """
    A class for representing a single entry in a result table.
    The table has columns:
    id,
    experiment_id,
    result_type,
    result_value
    """

    def __init__(
        self, experiment_id: int, result_type: str, result_value: str, context=None
    ):
        self.experiment_id = experiment_id
        self.result_type = result_type
        self.result_value = result_value
        self.context = context

    def __str__(self):
        return f"Experiment ID: {self.experiment_id}, Result Type: {self.result_type}, Result Value: {self.result_value}, Context: {self.context}"

    def __repr__(self):
        return f"ResultTableRecord({self.experiment_id}, {self.result_type}, {self.result_value}, {self.context})"

    def __eq__(self, other):
        return (
            self.experiment_id == other.experiment_id
            and self.result_type == other.result_type
            and self.result_value == other.result_value
            and self.context == other.context
        )

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash(
            (self.experiment_id, self.result_type, self.result_value, self.context)
        )

    def __iter__(self):
        yield self.experiment_id
        yield self.result_type
        yield self.result_value
        yield self.context

    def __list__(self):
        return [self.experiment_id, self.result_type, self.result_value, self.context]
    
class ExperimentParameterRecord:
    """
    A class for representing a single entry in an experiment parameter table.
    The table has columns:
    id,
    experiment_id,
    parameter_type,
    parameter_value
    """

    def __init__(self, experiment_id: int, parameter_type: str, parameter_value: str):
        self.experiment_id = experiment_id
        self.parameter_type = parameter_type
        self.parameter_value = parameter_value

    def __str__(self):
        return f"Experiment ID: {self.experiment_id}, Parameter Type: {self.parameter_type}, Parameter Value: {self.parameter_value}"

    def __repr__(self):
        return f"ExperimentParameterRecord({self.experiment_id}, {self.parameter_type}, {self.parameter_value})"

    def __eq__(self, other):
        return (
            self.experiment_id == other.experiment_id
            and self.parameter_type == other.parameter_type
            and self.parameter_value == other.parameter_value
        )

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash((self.experiment_id, self.parameter_type, self.parameter_value))

    def __iter__(self):
        yield self.experiment_id
        yield self.parameter_type
        yield self.parameter_value

    def __list__(self):
        return [self.experiment_id, self.parameter_type, self.parameter_value]


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
