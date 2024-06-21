"""
This module contains the MillControl class, which is used to control the a GRBL CNC machine.
The MillControl class is used by the EPanda class to move the pipette and electrode to the
specified coordinates. 

The MillControl class contains methods to move the pipette and
electrode to a safe position, rinse the electrode, and update the offsets in the mill config
file. 

The MillControl class contains methods to connect to the mill, execute commands,
stop the mill, reset the mill, home the mill, get the current status of the mill, get the
gcode mode of the mill, get the gcode parameters of the mill, and get the gcode parser state
of the mill.
"""

# pylint: disable=line-too-long

# standard libraries
import json
import logging
import re
import sys
import time
from unittest.mock import MagicMock

# third-party libraries
# from pydantic.dataclasses import dataclass
import serial
from .config.config import MILL_CONFIG, PATH_TO_LOGS
from .log_tools import e_panda_logger as logger
from .utilities import Coordinates, Instruments

# add the mill_control logger
formatter = logging.Formatter(
    "%(asctime)s&%(name)s&%(levelname)s&%(module)s&%(funcName)s&%(lineno)d&%(message)s"
)
system_handler = logging.FileHandler(PATH_TO_LOGS / "mill_control.log")
system_handler.setFormatter(formatter)
logger.addHandler(system_handler)
console_handler = logging.StreamHandler()
console_formatter = logging.Formatter(
    "%(levelname)-10s &%(module)s& %(funcName)-20s & %(lineno)5d & %(message)s"
)
console_handler.setFormatter(console_formatter)
console_handler.setLevel(logging.WARNING)
logger.addHandler(console_handler)

# Mill movement logger
mill_movement_logger = logging.getLogger("mill_movement")
mill_movement_logger.setLevel(logging.DEBUG)
mill_movement_handler = logging.FileHandler(PATH_TO_LOGS / "mill_movement.log")
mill_movement_handler.setFormatter(formatter)
mill_movement_logger.addHandler(mill_movement_handler)


class Mill:
    """
    Set up the mill connection and pass commands, including special commands
    """

    def __init__(self, config_file="mill_config.json"):
        self.config_file = config_file
        self.active_connection = False
        self.config = self.read_json_config()
        self.ser_mill: serial.Serial = None

    def homing_sequence(self):
        """Home the mill, set the feed rate, and clear the buffers"""
        self.home()
        self.set_feed_rate(2000)  # Set feed rate to 2000
        self.clear_buffers()

    def connect_to_mill(self) -> serial.Serial:
        """Connect to the mill"""
        try:
            ser_mill = serial.Serial(
                # Hardcoded serial port (consider making this configurable)
                port="COM4",
                baudrate=115200,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                bytesize=serial.EIGHTBITS,
                timeout=10,
            )
            time.sleep(2)

            if not ser_mill.is_open:
                logger.info("Opening serial connection to mill...")
                ser_mill.open()
                time.sleep(2)
            if ser_mill.is_open:
                logger.info("Serial connection to mill opened successfully")
                self.active_connection = True
            else:
                logger.error("Serial connection to mill failed to open")
                raise MillConnectionError("Error opening serial connection to mill")

            logger.info("Mill connected: %s", ser_mill.is_open)
            self.ser_mill = ser_mill
        except Exception as exep:
            logger.error("Error connecting to the mill: %s", str(exep))
            raise MillConnectionError("Error connecting to the mill") from exep

        # Check if the mill is currently in alarm state
        # If it is, reset the mill
        status = self.ser_mill.readlines()[-1].decode().rstrip()
        if "alarm" in status.lower():
            logger.warning("Mill is in alarm state")
            reset_alarm = input("Reset the mill? (y/n): ")
            if reset_alarm.lower() == "y":
                self.reset()
            else:
                logger.error("Mill is in alarm state, user chose not to reset the mill")
                raise MillConnectionError("Mill is in alarm state")
        if "error" in status.lower():
            logger.error("Error in status: %s", status)
            raise MillConnectionError(f"Error in status: {status}")

        # We only check that the mill is indeed lock upon connection because we will home before any movement
        if "unlock" not in status.lower():
            logger.error("Mill is not locked")
            proceed = input("Proceed? (y/n): ")
            if proceed.lower() == "n":
                raise MillConnectionError("Mill is not locked")
            else:
                logger.warning("Proceeding despite mill not being locked")
                logger.warning("Current status: %s", status)
                logger.warning("Homing is reccomended before any movement")
                home_now = input("Home now? (y/n): ")
                if home_now.lower() == "y":
                    self.homing_sequence()
                else:
                    logger.warning("User chose not to home the mill")

        self.clear_buffers()
        return self.ser_mill

    def __enter__(self):
        """Enter the context manager"""
        self.connect_to_mill()
        self.homing_sequence()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """Exit the context manager"""
        self.disconnect()
        logger.info("Exiting the mill context manager")

    def disconnect(self):
        """Close the serial connection to the mill"""
        logger.info("Disconnecting from the mill")
        self.ser_mill.close()
        time.sleep(2)
        logger.info("Mill connected: %s", self.ser_mill.is_open)
        if self.ser_mill.is_open:
            logger.error("Failed to close the serial connection to the mill")
            raise MillConnectionError("Error closing serial connection to mill")
        else:
            logger.info("Serial connection to mill closed successfully")
            self.active_connection = False
            self.ser_mill = None

    def read_json_config(self) -> dict:
        """Read the config file"""
        try:
            config_file_path = MILL_CONFIG
            with open(config_file_path, "r", encoding="UTF-8") as file:
                configuration = json.load(file)
            logger.debug("Mill config loaded")
            return configuration
        except FileNotFoundError as err:
            logger.error("Config file not found")
            raise MillConfigNotFound("Config file not found") from err
        except Exception as err:
            logger.error("Error reading config file: %s", str(err))
            raise MillConfigError("Error reading config file") from err

    def execute_command(self, command: str):
        """Encodes and sends commands to the mill and returns the response"""
        try:
            logger.debug("Command sent: %s", command)
            mill_movement_logger.debug("%s", command)
            command_bytes = str(command).encode()
            self.ser_mill.write(command_bytes + b"\n")
            time.sleep(2)
            mill_response = self.ser_mill.readline().decode().rstrip()

            if command == "$$":
                full_mill_response = []
                full_mill_response.append(mill_response)
                while full_mill_response[-1] != "ok":
                    full_mill_response.append(
                        self.ser_mill.readline().decode().rstrip()
                    )
                full_mill_response = full_mill_response[:-1]
                logger.debug("Returned %s", full_mill_response)

                # parse the settings into a dictionary
                settings_dict = {}
                for setting in full_mill_response:
                    setting: str
                    key, value = setting.split("=")
                    settings_dict[key] = value

                return settings_dict

            elif not command.startswith("$"):
                # logger.debug("Initially %s", mill_response)
                mill_response = self.__wait_for_completion(mill_response)
                logger.debug("Returned %s", mill_response)
            else:
                logger.debug("Returned %s", mill_response)

            if re.search(r"\b(error|alarm)\b", mill_response.lower()):
                if re.search(r"\berror:22\b", mill_response.lower()):
                    # This is a GRBL error that occurs when the feed rate isn't set before moving with G01 command
                    logger.error("Error in status: %s", mill_response)
                    # Try setting the feed rate and executing the command again
                    self.set_feed_rate(2000)
                    mill_response = self.execute_command(command)
                else:
                    logger.error("current_status: Error in status: %s", mill_response)
                    raise StatusReturnError(f"Error in status: {mill_response}")

        except Exception as exep:
            logger.error("Error executing command %s: %s", command, str(exep))
            raise CommandExecutionError(
                f"Error executing command {command}: {str(exep)}"
            ) from exep

        return mill_response

    def stop(self):
        """Stop the mill"""
        self.execute_command("!")

    def reset(self):
        """Reset or unlock the mill"""
        self.execute_command("$X")

    def soft_reset(self):
        """Soft reset the mill"""
        self.execute_command("0x18")

    def home(self, timeout=90):
        """Home the mill with a timeout"""
        self.execute_command("$H")
        time.sleep(15)
        start_time = time.time()

        while True:
            if time.time() - start_time > timeout:
                logger.warning("Homing timed out")
                break

            status = self.current_status()
            if "Idle" in status:
                logger.info("Homing completed")
                break

            time.sleep(2)  # Adjust the sleep interval as needed

    def __wait_for_completion(self, incoming_status, timeout=90):
        """Wait for the mill to complete the previous command"""
        status = incoming_status
        start_time = time.time()
        while "Idle" not in status:
            if time.time() - start_time > timeout:
                logger.warning("wait_for_completion: Command execution timed out")
                return status
            status = self.current_status()
            time.sleep(1)
        return status

    def current_status(self) -> str:
        """Get the current status of the mill"""
        command = "?"
        command_bytes = command.encode()
        status = ""
        while status == "":
            self.ser_mill.write(command_bytes + b"\n")
            time.sleep(0.25)
            status = self.ser_mill.readline().decode().rstrip()
        # Check for busy
        while status == "ok":
            status = self.ser_mill.readline().decode().rstrip()
        return status

    def set_feed_rate(self, rate):
        """Set the feed rate"""
        self.execute_command(f"F{rate}")

    def clear_buffers(self):
        """Clear input and output buffers"""
        self.ser_mill.flushInput()  # Clear input buffer
        self.ser_mill.flushOutput()  # Clear output buffer

    def gcode_mode(self):
        """Ask the mill for its gcode mode"""
        return self.execute_command("$C")

    def gcode_parameters(self):
        """Ask the mill for its gcode parameters"""
        return self.execute_command("$#")

    def gcode_parser_state(self):
        """Ask the mill for its gcode parser state"""
        return self.execute_command("$G")

    def grbl_settings(self) -> dict:
        """Ask the mill for its grbl settings"""
        return self.execute_command("$$")

    def set_grbl_setting(self, setting: str, value: str):
        """Set a grbl setting"""
        command = f"${setting}={value}"
        return self.execute_command(command)

    def current_coordinates(self, instrument=Instruments.CENTER) -> list:
        """
        Get the current coordinates of the mill.
        Args:
            None
        Returns:
            list: [x,y,z]
        """

        status = self.current_status()

        # Get the current mode of the mill
        # 0=WCS position, 1=Machine position, 2= plan/buffer and WCS position, 3=plan/buffer and Machine position.
        status_mode = self.config["settings"]["$10"]

        if status_mode not in [0, 1, 2, 3]:
            logger.error("Invalid status mode")
            # default to 3
            status_mode = 3

        if status_mode in [0, 2]:
            # Regular expression to extract WPox coordinates
            wpos_pattern = re.compile(r"WPos:([\d.-]+),([\d.-]+),([\d.-]+)")
            # Look for WPos coordinates
            match = wpos_pattern.search(status)
            max_attempts = 3
            for _ in range(max_attempts):
                try:
                    if match:
                        x_coord = round(float(match.group(1)),3)
                        y_coord = round(float(match.group(2)),3)
                        z_coord = round(float(match.group(3)),3)
                        log_message = f"WPos coordinates: X = {x_coord}, Y = {y_coord}, Z = {z_coord}"
                        logger.info(log_message)
                        break
                    else:
                        logger.warning(
                            "WPos coordinates not found in the line. Trying again..."
                        )
                        raise LocationNotFound
                except LocationNotFound as e:
                    logger.error(
                        "Error occurred while getting WPos coordinates: %s", str(e)
                    )
                    if _ == max_attempts - 1:
                        raise
        elif status_mode in [1, 3]:
            # Regular expression to extract MPos coordinates
            mpos_pattern = re.compile(r"MPos:([\d.-]+),([\d.-]+),([\d.-]+)")
            match = mpos_pattern.search(status)
            max_attempts = 3
            for _ in range(max_attempts):
                try:
                    if (
                        match
                    ):  # Add 3 to the coordinates to account for the machine offset
                        homing_pull_off = self.config["settings"]["$27"]
                        x_coord = float(match.group(1)) + homing_pull_off
                        y_coord = float(match.group(2)) + homing_pull_off
                        z_coord = float(match.group(3)) + homing_pull_off
                        log_message = f"MPos coordinates: X = {x_coord - homing_pull_off}, Y = {y_coord- homing_pull_off}, Z = {z_coord- homing_pull_off}"
                        logger.debug(log_message)
                        log_message = f"WPos coordinates: X = {x_coord}, Y = {y_coord}, Z = {z_coord}"
                        logger.debug(log_message)
                        break
                    else:
                        logger.warning(
                            "MPos coordinates not found in the line. Trying again..."
                        )
                        raise LocationNotFound
                except LocationNotFound as e:
                    logger.error(
                        "Error occurred while getting MPos coordinates: %s", str(e)
                    )
                    if _ == max_attempts - 1:
                        raise
        else:
            logger.critical("Failed to obtain coordinates from the mill")
            self.stop()
            self.disconnect()
            sys.exit()

        # So far we have obtain the mill's coordinates
        # Now we need to adjust them based on the instrument to communicate where the current instrument is
        if instrument in [Instruments.CENTER, Instruments.LENS]:
            current_coordinates = [x_coord, y_coord, z_coord]
        elif instrument == Instruments.PIPETTE:
            offsets = self.config["instrument_offsets"]["pipette"]
            current_coordinates = [
                x_coord - offsets["x"],
                y_coord - offsets["y"],
                z_coord - offsets["z"],
            ]
        elif instrument == Instruments.ELECTRODE:
            offsets = self.config["instrument_offsets"]["electrode"]
            current_coordinates = [
                x_coord - offsets["x"],
                y_coord - offsets["y"],
                z_coord - offsets["z"],
            ]

        else:
            raise ValueError("Invalid instrument")
        current_coordinates = [round(coord, 3) for coord in current_coordinates]
        logger.debug("Current_coordinates: %s", current_coordinates)
        return current_coordinates

    def rinse_electrode(self, rinses: int = 3):
        """
        Rinse the electrode by moving it to the rinse position and back to the
        center position.
        Args:
            None
        Returns:
            None
        """
        coords = self.config["electrode_bath"]
        self.safe_move(coords["x"], coords["y"], 0, instrument=Instruments.ELECTRODE)
        for _ in range(rinses):
            self._move_electrode_to_position(coords["x"], coords["y"], coords["z"])
            self._move_electrode_to_position(coords["x"], coords["y"], 0)
        return 0

    def rest_electrode(self):
        """
        Rinse the electrode by moving it to the rinse position and back to the
        center position.
        Args:
            None
        Returns:
            None
        """
        coords = self.config["electrode_bath"]
        self.move_to_safe_position()
        self.safe_move(
            coords["x"], coords["y"], coords["z"], instrument=Instruments.ELECTRODE
        )
        return 0

    def move_to_safe_position(self) -> str:
        """Move the mill to its current x,y location and z = 0"""
        # [initial_x, initial_y, initial_z] = self.current_coordinates()
        # mill_response = self.move_center_to_position(
        #     initial_x, initial_y, 0
        # )

        return self.execute_command("G01 Z0")

    def _move_center_to_position(self, x_coord, y_coord, z_coord) -> int:
        """
        WARNING: Will move diagonally
        Move the mill to the specified coordinates.
        Args:
            x_coord (float): X coordinate.
            y_coord (float): Y coordinate.
            z_coord (float): Z coordinate.
        Returns:
            str: Response from the mill after executing the command.
        """
        offsets = self.config["instrument_offsets"]["center"]
        working_volume = self.config["working_volume"]

        mill_move = "G01 X{} Y{} Z{}"  # Move to specified coordinates

        command_coordinates = [
            x_coord + offsets["x"],
            y_coord + offsets["y"],
            z_coord + offsets["z"],
        ]

        # check that command coordinates are within working volume
        if command_coordinates[0] > 0 or command_coordinates[0] < working_volume["x"]:
            logger.error("x coordinate out of range")
            raise ValueError("x coordinate out of range")
        if command_coordinates[1] > 0 or command_coordinates[1] < working_volume["y"]:
            logger.error("y coordinate out of range")
            raise ValueError("y coordinate out of range")
        if command_coordinates[2] > 0 or command_coordinates[2] < working_volume["z"]:
            logger.error("z coordinate out of range")
            raise ValueError("z coordinate out of range")

        command = mill_move.format(*command_coordinates)
        self.execute_command(command)
        return 0

    def _move_pipette_to_position(
        self,
        x_coord: float = 0,
        y_coord: float = 0,
        z_coord=0.00,
    ) -> int:
        """
        WARNING: Will move diagonally
        Move the pipette to the specified coordinates.
        Args:
            x (float): X coordinate.
            y (float): Y coordinate.
            z (float): Z coordinate.
        Returns:
            str: Response from the mill after executing the command.
        """
        # offsets = {"x": -88, "y": 0, "z": 0}
        offsets = self.config["instrument_offsets"]["pipette"]
        command_coordinates = [
            x_coord + offsets["x"],
            y_coord + offsets["y"],
            z_coord + offsets["z"],
        ]
        self._move_center_to_position(*command_coordinates)
        return 0

    def _move_electrode_to_position(
        self, x_coord: float, y_coord: float, z_coord: float = 0.00
    ) -> int:
        """
        WARNING: Will move diagonally
        Move the electrode to the specified coordinates.
        Args:
            coordinates (dict): Dictionary containing x, y, and z coordinates.
        Returns:
            str: Response from the mill after executing the command.
        """
        # offsets = {"x": 36, "y": 30, "z": 0}
        offsets = self.config["instrument_offsets"]["electrode"]

        command_coordinates = [
            x_coord + offsets["x"],
            y_coord + offsets["y"],
            z_coord + offsets["z"],
        ]
        self._move_center_to_position(*command_coordinates)
        return 0

    def update_offset(self, offset_type, offset_x, offset_y, offset_z):
        """
        Update the offset in the config file
        """
        current_offset = self.config[offset_type]
        offset = {
            "x": current_offset["x"] + offset_x,
            "y": current_offset["y"] + offset_y,
            "z": current_offset["z"] + offset_z,
        }

        self.config["instrument_offsets"][offset_type] = offset
        config_file_path = MILL_CONFIG
        if not config_file_path.exists():
            logger.error("Config file not found")
            raise MillConfigNotFound

        try:
            with open(config_file_path, "w", encoding="UTF-8") as file:
                json.dump(self.config, file, indent=4)
            logger_message = f"Updated {offset_type} to {offset}"
            logger.info(logger_message)
            return 0
        except MillConfigNotFound as update_offset_exception:
            logger.error(update_offset_exception)
            return 3

    ## Special versions of the movement commands that avoid diagonal movements
    def safe_move(
        self,
        x_coord,
        y_coord,
        z_coord,
        instrument: Instruments = Instruments.CENTER,
    ) -> int:
        """
        Move the mill to the specified coordinates using only horizontal and vertical movements.
        Args:
            x_coord (float): X coordinate.
            y_coord (float): Y coordinate.
            z_coord (float): Z coordinate.
            instrument (Instruments): The instrument to move to the specified coordinates.
        Returns:
            str: Response from the mill after executing the commands.
        """
        # Get the current coordinates
        current_coordinates = Coordinates(*self.current_coordinates(instrument))

        # Fetch offsets for the specified instrument
        offsets = Coordinates(**self.config["instrument_offsets"][instrument.value])
        # updated target coordinates with offsets so the center of the mill moves to the right spot
        offset_coordinates = Coordinates(
            x=round(x_coord + offsets.x, 3),
            y=round(y_coord + offsets.y, 3),
            z=round(z_coord + offsets.z, 3),
        )
        logger.debug(
            "Target coordinates: [%s, %s, %s]",
            offset_coordinates.x,
            offset_coordinates.y,
            offset_coordinates.z,
        )

        move_to_zero_first = self.__should_move_to_zero_first(
            current_coordinates,
            offset_coordinates,
            self.config["safe_height_floor"],
        )

        if move_to_zero_first:
            logger.debug("Moving to Z=0 first")
            self.execute_command("G01 Z0")
        else:
            logger.debug("Not moving to Z=0 first")

        # Double check that the target coordinates are within the working volume
        working_volume = Coordinates(**self.config["working_volume"])
        if offset_coordinates.x > 0 or offset_coordinates.x < working_volume.x:
            logger.error("x coordinate out of range")
            raise ValueError("x coordinate out of range")
        if offset_coordinates.y > 0 or offset_coordinates.y < working_volume.y:
            logger.error("y coordinate out of range")
            raise ValueError("y coordinate out of range")
        if offset_coordinates.z > 0 or offset_coordinates.z < working_volume.z:
            logger.error("z coordinate out of range")
            raise ValueError("z coordinate out of range")

        # Calculate the differences between the current and target coordinates
        # dx = offset_coordinates.x - current_coordinates.x
        # dy = offset_coordinates.y - current_coordinates.y
        # Initialize a list to store the movement commands
        commands = []

        # Generate horizontal movements
        if offset_coordinates.x != current_coordinates.x:
            commands.append(f"G01 X{offset_coordinates.x}")

        if offset_coordinates.y != current_coordinates.y:
            commands.append(f"G01 Y{offset_coordinates.y}")

        # Generate vertical movements
        current_coordinates = Coordinates(*self.current_coordinates(instrument))
        if offset_coordinates.z != current_coordinates.z:
            commands.append(f"G01 Z{offset_coordinates.z}")

        # Execute the commands one by one
        for command in commands:
            self.execute_command(command)

        return 0

    def __should_move_to_zero_first(
        self,
        current: Coordinates,
        offset: Coordinates,
        safe_height_floor,
    ):
        """
        Determine if the mill should move to Z=0 before moving to the specified coordinates.
        Args:
            current (Coordinates): Current coordinates.
            offset (Coordinates): Target coordinates.
            safe_height_floor (float): Safe floor height.
        Returns:
            bool: True if the mill should move to Z=0 first, False otherwise.
        """
        # Extract the current coordinates

        if offset.z not in (0, current.z):
            if current.z == 0:
                # Expecting False because Z is already at 0
                move_to_zero_first = False
            elif current.x != offset.x and current.y != offset.y:
                # Expecting True because Z is changing, X and Y are changing
                # But if Z is below the safe floor height, expect False
                move_to_zero_first = current.z < safe_height_floor
            elif current.x == offset.x and current.y == offset.y:
                # Expecting False because Z is changing, but X and Y are not changing
                move_to_zero_first = False
            else:
                # Default to True
                move_to_zero_first = True
        else:  # offset_z_coord is 0 or current.z
            # If Z is already at 0, expect False
            if current.z == 0:
                move_to_zero_first = False
            # If Z is at or above the safe floor height, expect False
            elif current.z >= safe_height_floor:
                move_to_zero_first = False
            # If Z is below the safe floor height, expect True if X and Y are changing
            elif current.z < safe_height_floor:
                # If X and Y are changing, expect True
                move_to_zero_first = not (
                    current.x == offset.x and current.y == offset.y
                )

            else:
                # Default to True
                move_to_zero_first = True

        return move_to_zero_first


class MockMill(Mill):
    """A class that simulates a mill for testing purposes.

    Attributes:
    config_file (str): The path to the configuration file.
    config (dict): The configuration dictionary.
    ser_mill (None): The serial connection to the mill.
    current_x (float): The current x-coordinate.
    current_y (float): The current y-coordinate.
    current_z (float): The current z-coordinate.

    Methods:
    homing_sequence(): Simulate homing, setting feed rate, and clearing buffers.
    disconnect(): Simulate disconnecting from the mill.
    execute_command(command): Simulate executing a command.
    stop(): Simulate stopping the mill.
    reset(): Simulate resetting the mill.
    home(timeout): Simulate homing the mill.
    wait_for_completion(incoming_status, timeout): Simulate waiting for completion.
    current_status(): Simulate getting the current status.
    set_feed_rate(rate): Simulate setting the feed rate.
    clear_buffers(): Simulate clearing buffers.
    gcode_mode(): Simulate getting the G-code mode.
    gcode_parameters(): Simulate getting G-code parameters.
    gcode_parser_state(): Simulate getting G-code parser state.
    rinse_electrode(): Simulate rinsing the electrode.
    move_to_safe_position(): Simulate moving to a safe position.
    move_center_to_position(x_coord, y_coord, z_coord): Simulate moving to a specified position.
    current_coordinates(instrument): Return the tracked current coordinates.
    move_pipette_to_position(x_coord, y_coord, z_coord): Simulate moving the pipette to a specified position.
    move_electrode_to_position(x_coord, y_coord, z_coord): Simulate moving the electrode to a specified position.
    update_offset(offset_type, offset_x, offset_y, offset_z): Simulate updating offsets in the config.
    safe_move(x_coord, y_coord, z_coord, instrument): Simulate a safe move with horizontal and vertical movements.
    """

    def __init__(self, config_file="mill_config.json"):
        super().__init__(config_file)
        self.ser_mill: serial.Serial = None
        self.current_x = 0.0
        self.current_y = 0.0
        self.current_z = 0.0
        self.feed_rate = 2000
        self.status_mode = self.config["settings"]["$10"]

    def connect_to_mill(self):
        """Connect to the mill"""
        logger.info("Connecting to the mill")
        self.ser_mill = MagicMock(spec=serial.Serial)
        self.active_connection = True
        return self.ser_mill

    def disconnect(self):
        """Disconnect from the mill"""
        logger.info("Disconnecting from the mill")
        self.ser_mill.close()
        self.active_connection = False

    def execute_command(self, command) -> str:
        """Simulate executing a command"""
        try:
            logger.debug("Command sent: %s", command)

            # command_bytes = str(command).encode()
            self.mock_write(command)
            time.sleep(2)
            if command == "$$":
                return self.mock_readline(settings=True)
            else:
                mill_response = self.mock_readline()

            if command == "F2000":
                logger.debug("Returned %s", mill_response)

            elif command == "?":
                logger.debug("Returned %s", mill_response)

            elif command not in ["$H", "$X", "(ctrl-x)", "$C", "$#", "$G"]:
                # logger.debug("Initially %s", mill_response)
                self.__wait_for_completion(mill_response)
                mill_response = self.current_status()
                logger.debug("Returned %s", mill_response)
            else:
                logger.debug("Returned %s", mill_response)

            if mill_response.lower() in ["error", "alarm"]:
                if "error:22" in mill_response.lower():
                    # This is a GRBL error that occurs when the feed rate isn't set before moving with G01 command
                    logger.error("Error in status: %s", mill_response)
                    # Try setting the feed rate and executing the command again
                    self.set_feed_rate(2000)
                    mill_response = self.execute_command(command)
                else:
                    logger.error("current_status: Error in status: %s", mill_response)
                    raise StatusReturnError(f"Error in status: {mill_response}")

        except Exception as exep:
            logger.error("Error executing command %s: %s", command, str(exep))
            raise CommandExecutionError(
                f"Error executing command {command}: {str(exep)}"
            ) from exep

        return self.current_status()

    def set_feed_rate(self, rate):
        """Simulate setting the feed rate"""
        self.feed_rate = rate
        logger.info("Setting feed rate to %s", rate)

    def clear_buffers(self):
        """Simulate clearing buffers"""
        logger.info("Clearing buffers")

    def current_status(self) -> str:
        """Simulate getting the current status of the mill"""
        homing_pull_off = self.config["settings"]["$27"]
        if self.status_mode == 0:
            return f"<Idle|WPos:{self.current_x},{self.current_y},{self.current_z}>"
        elif self.status_mode == 1:
            return f"<Idle|MPos:{self.current_x-homing_pull_off},{self.current_y-homing_pull_off},{self.current_z-homing_pull_off}>"

        elif self.status_mode == 2:
            return f"<Idle|WPos:{self.current_x},{self.current_y},{self.current_z}|Bf:15,127|FS:0,0>"

        elif self.status_mode == 3:
            return f"<Idle|MPos:{self.current_x-homing_pull_off},{self.current_y-homing_pull_off},{self.current_z-homing_pull_off}|Bf:15,127|FS:0,0>"

    def __wait_for_completion(self, incoming_status, timeout=90):
        """Wait for the mill to complete the previous command"""
        status = incoming_status
        start_time = time.time()
        while "Idle" not in status:
            if time.time() - start_time > timeout:
                logger.warning("wait_for_completion: Command execution timed out")
                break
            status = self.current_status()
            time.sleep(1)

    def mock_write(self, command: str):
        """Simulate writing to the mill"""
        logger.debug("Writing to the mill: %s", command)
        ## For mock mill
        if command == "G01 Z0":
            self.current_z = 0.0
        elif command.startswith("G01"):
            # Extract the coordinates from the command when it could be any of the following:
            # G01 X{} Y{} Z{}
            # G01 X{} Y{}
            # G01 Y{} Z{}
            # G01 X{} Z{}
            # G01 X{}
            # G01 Y{}
            # G01 Z{}

            pattern = re.compile(r"G01(?: X([\d.-]+))?(?: Y([\d.-]+))?(?: Z([\d.-]+))?")

            match = pattern.search(command)
            if match:
                self.current_x = float(match.group(1) or self.current_x)
                self.current_y = float(match.group(2) or self.current_y)
                self.current_z = float(match.group(3) or self.current_z)
            else:
                logger.warning("Could not extract coordinates from the command")

    def mock_readline(self, settings: bool = False):
        """Simulate reading from the mill"""
        if settings:
            return self.config["settings"]
        else:
            return self.current_status()
        ## End of mock mill specific code


class StatusReturnError(Exception):
    """Raised when the mill returns an error in the status"""


class MillConfigNotFound(Exception):
    """Raised when the mill config file is not found"""


class MillConfigError(Exception):
    """Raised when there is an error reading the mill config file"""


class MillConnectionError(Exception):
    """Raised when there is an error connecting to the mill"""


class CommandExecutionError(Exception):
    """Raised when there is an error executing a command"""


class LocationNotFound(Exception):
    """Raised when the mill cannot find its location"""
