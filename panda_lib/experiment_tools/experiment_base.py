from dataclasses import field
from datetime import datetime
from decimal import Decimal
from typing import Optional, Union, get_type_hints
import json

from pydantic import ConfigDict
from pydantic.dataclasses import dataclass

from .experiment_paramters import ExperimentParameterRecord
from .experiment_result import ExperimentResult
from .experiment_status import ExperimentStatus


@dataclass(config=ConfigDict(validate_assignment=True, arbitrary_types_allowed=True))
class ExperimentBase:
    """Define the common data used to run and define an experiment"""

    experiment_id: int = None
    experiment_name: str = None
    protocol_id: int = None
    priority: Optional[int] = 0
    well_id: Optional[str] = None
    pin: Union[str, int] = None
    project_id: int = None
    solutions: dict = None
    solutions_corrected: dict = solutions
    well_type_number: int = (
        None  # is used to indicate the type of well the experiment should run in
    )
    pumping_rate: Decimal = Decimal("0.3")
    status: ExperimentStatus = ExperimentStatus.NEW
    status_date: datetime = field(default_factory=datetime.now)
    filename: str = None  # Optional[FilePath] = None
    well_id: Optional[str] = None
    pin: str = None
    project_id: int = None
    solutions: dict = None
    solutions_corrected: dict = solutions
    well_type_number: int = (
        None  # is used to indicate the type of well the experiment should run in
    )
    pumping_rate: Decimal = Decimal(0.3)
    status: ExperimentStatus = ExperimentStatus.NEW
    status_date: datetime = field(default_factory=datetime.now)
    filename: str = None  # Optional[FilePath] = None
    results: Optional[ExperimentResult] = None
    project_campaign_id: int = None
    protocol_type: int = 1  # depreciated
    plate_id: Optional[int] = None
    override_well_selection: int = 0  # 0 is normal, 1 is override
    process_type: Optional[int] = 1
    jira_issue_key: Optional[str] = None
    experiment_type: int = 0
    well: object= None
    # FIXME: Seperate the set status, and set status and save methods from the experimentbase. The experiment base should just be a dataclass
    # What could be an alternative is that there is a wrapper class that has the set status and set status and save methods using what
    # Method that the project chooses to use to save the data to the database
    def set_status(self, new_status: ExperimentStatus) -> None:
        """Set the status of the experiment"""
        self.status = new_status
        self.status_date = datetime.now().isoformat(timespec="seconds")
        # try:
        #     from .obs_controls import OBSController

        #     OBSController().place_experiment_on_screen(self)
        # except Exception as e:
        #     print(f"Error sending status to OBS: {e}")
        #     # don't raise the error, just print it

    # def set_status_and_save(self, new_status: ExperimentStatus) -> None:
    #     """Set the status and status date of the experiment"""
    #     from .sql_tools import sql_wellplate

    #     self.status = new_status
    #     self.status_date = datetime.now().isoformat(timespec="seconds")
    #     self.well.status = new_status
    #     self.well.status_date = datetime.now().isoformat(timespec="seconds")
    #     # Save the well to the database
    #     if self.well:
    #         sql_wellplate.save_well_to_db(self.well)

    #     else:
    #         print("Well object not set. Saving to db via alternative method")
    #         update_experiment_status(self)

        # # Save the experiment to the database
        # update_experiment(self)
        # try:
        #     from .obs_controls import OBSController

        #     OBSController().place_experiment_on_screen(self)
        # except Exception as e:
        #     print(f"Error sending status to OBS: {e}")
        #     # don't raise the error, just print it

    def is_same_id(self, other) -> bool:
        """Check if two experiments have the same id"""

        return self.experiment_id == other.id

    def is_same_well_id(self, other) -> bool:
        """Check if two experiments have the same well id"""

        return self.well_id == other.well_id

    ## other check if same methods

    def generate_parameter_list(self) -> list[ExperimentParameterRecord]:
        """Turn the experiment object into a list of individual experiment parameter table records"""
        all_parameters = [
            ExperimentParameterRecord(
                self.experiment_id, parameter_type, parameter_value
            )
            for parameter_type, parameter_value in self.__dict__.items()
        ]

        # Remove project_id, project_campaign_id, well_type,protocol_id, pin, experiment_type, jira_issue_key, priority, process_type, filename, status, status_date, results, well
        all_parameters = [
            parameter
            for parameter in all_parameters
            if parameter.parameter_type
            not in [
                "project_id",
                "project_campaign_id",
                "well_type",
                "protocol_id",
                "protocol_type",  # depreciated
                "pin",
                "experiment_type",
                "jira_issue_key",
                "priority",
                "process_type",
                "filename",
                "status",
                "status_date",
                "results",
                "well",
                "well_id",
                "experiment_id",
            ]
        ]

        return all_parameters

    # def generate_result_list(self) -> list[ExperimentResultsRecord]:

    def map_parameter_list_to_experiment(
        self, parameter_list: list[ExperimentParameterRecord]
    ):
        """Map the parameter list to the experiment object"""

        def find_attribute_in_hierarchy(cls, attr):
            """Recursively search for an attribute in a class and its subclasses"""
            if hasattr(cls, attr):
                return cls
            for subclass in cls.__subclasses__():
                result = find_attribute_in_hierarchy(subclass, attr)
                if result is not None:
                    return result
            return None

        for parameter in parameter_list:
            parameter = ExperimentParameterRecord(*parameter)
            try:
                attribute_type = get_all_type_hints(type(self))[
                    parameter.parameter_type
                ]
            except KeyError as exc:
                # The attribute is not in ExperimentBase, check in the class hierarchy
                cls = find_attribute_in_hierarchy(
                    self.__class__, parameter.parameter_type
                )
                if cls is not None:
                    attribute_type = get_all_type_hints(cls)[parameter.parameter_type]
                else:
                    print(
                        f"Attribute {parameter.parameter_type} not found in class hierarchy"
                    )
                    raise AttributeError(
                        f"Attribute {parameter.parameter_type} not found in class hierarchy"
                    ) from exc

            if isinstance(
                attribute_type, type(Union)
            ):  # Check if the type hint is a Union
                # The attribute can be one of several types
                possible_types = attribute_type.__args__
                for possible_type in possible_types:
                    # Try to convert the parameter value to each possible type
                    try:
                        parameter.parameter_value = possible_type(
                            parameter.parameter_value
                        )
                        break  # If the conversion succeeds, stop trying other types
                    except ValueError:
                        pass  # If the conversion fails, try the next type
            elif (
                hasattr(attribute_type, "_name") and attribute_type._name == "Optional"
            ):  # Check if the type hint is Optional
                # The attribute can be None or the specified type
                possible_type = attribute_type.__args__[0]
                if parameter.parameter_value is None:
                    parameter.parameter_value = None
                else:
                    # Try to convert the parameter value to the specified type
                    parameter.parameter_value = possible_type(parameter.parameter_value)

            elif attribute_type == int:
                parameter.parameter_value = int(parameter.parameter_value)
            elif attribute_type in [Decimal, float]:
                parameter.parameter_value = Decimal(parameter.parameter_value)
            elif attribute_type == bool:
                parameter.parameter_value = bool(parameter.parameter_value)
            elif attribute_type == str:
                parameter.parameter_value = str(parameter.parameter_value)
            elif attribute_type == dict and json.loads(parameter.parameter_value):
                parameter.parameter_value = json.loads(parameter.parameter_value)
            elif attribute_type == ExperimentStatus:
                parameter.parameter_value = ExperimentStatus(parameter.parameter_value)
            elif attribute_type == datetime:
                parameter.parameter_value = datetime.fromisoformat(
                    parameter.parameter_value
                )
            else:
                print(f"Unknown attribute type {attribute_type}")

            if hasattr(self, parameter.parameter_type):  # Check if the attribute exists
                setattr(self, parameter.parameter_type, parameter.parameter_value)
            else:
                # If the attribute does not exist, add it to the object, this is
                # to avoid every experiment needing to have attributes of other experiments
                # Example: Edot experiments have edot_concentration, but not all experiments have this
                setattr(
                    self.__class__, parameter.parameter_type, parameter.parameter_value
                )


def get_all_type_hints(cls):
    """Get all type hints for a class"""
    hints = {}
    for base in reversed(cls.__mro__):
        hints.update(get_type_hints(base))
    return hints



