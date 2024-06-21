"""How an experiment parameter record is represented in the database."""

#TODO: Should this be with experiment_tools or should it be with SQL_tools?

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