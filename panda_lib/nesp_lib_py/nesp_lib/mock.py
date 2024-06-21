"""
mock.py
Contains mocks for driver objects for offline testing.

MIT License:
Copyright (c) 2021 Florian Lapp

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""
import binascii
import enum
import re
import threading
import time
import typing
from numbers import Real
from unittest.mock import MagicMock

from .alarm_status import AlarmStatus
from .exceptions import *
from .port import Port
from .pump import Pump as RealPump
from .pumping_direction import PumpingDirection
from .status import Status


class Pump(RealPump):
    """Pump."""

    MODEL_NUMBER_IGNORE = 0
    """Model number to ignore the model."""

    ADDRESS_DEFAULT = 0
    """Default address."""
    ADDRESS_LIMIT = 99
    """Address limit."""

    SAFE_MODE_TIMEOUT_DISABLED = 0
    """Safe mode timeout of a pump with disabled safe mode."""
    SAFE_MODE_TIMEOUT_LIMIT = 255
    """Safe mode timeout limit in units of seconds."""

    SYRINGE_DIAMETER_MINIMUM = 0.1
    """Minimum syringe diameter in units of millimeters."""
    SYRINGE_DIAMETER_MAXIMUM = 80.0
    """Maximum syringe diameter in units of millimeters."""

    PUMPING_POLL_DELAY = 0.05
    """Delay between pulling polls while waiting in units of seconds."""

    def __init__(
        self,
        port : str = 'COM1',
        address : int = ADDRESS_DEFAULT,
        model_number : int = MODEL_NUMBER_IGNORE,
        safe_mode_timeout : int = SAFE_MODE_TIMEOUT_DISABLED
    ) -> None :
        """
        Constructs a pump.

        :param port:
            Port the pump is connected to.
        :param address:
            Address of the pump.
        :param model_number:
            Model number of the pump.
            If not `MODEL_NUMBER_IGNORE` and not equal to the model number of the pump
            `ModelException` is raised.
        :param safe_mode_timeout:
            Safe mode timeout of the pump in units of seconds.

        :raises ValueError:
            Address invalid.
        :raises ValueError:
            Safe mode timeout invalid.
        :raises ModelException:
            Model wrong.
        """
        if address < 0 or address > Pump.ADDRESS_LIMIT :
            raise ValueError('Address invalid: Value negative or exceeds limit.')
        self.__address = address
        model_number_port, firmware_version_port, firmware_upgrade_port = (
            self.__firmware_version_get()
        )
        if model_number != Pump.MODEL_NUMBER_IGNORE and model_number_port != model_number :
            raise ModelException()
        self.__model_number = model_number_port
        self.__firmware_version = firmware_version_port
        self.__firmware_upgrade = firmware_upgrade_port

        # Default values
        self.__safe_mode_timeout = Pump.SAFE_MODE_TIMEOUT_DISABLED
        self.__syringe_diameter = Pump.SYRINGE_DIAMETER_MINIMUM
        self.__pumping_direction = Pump.__PumpingDirectionInfuse
        self.__pumping_volume = (0.0, 'ML')
        self.__pump_rate = [0.0, 'MM']
        self.__volume_infused = 0.0
        self.__volume_withdrawn = 0.0


    @property
    def address(self) -> int :
        """
        Gets the address of the pump.

        Values: [`0`, `ADDRESS_LIMIT`]
        """
        return self.__address

    @property
    def model_number(self) -> int :
        """
        Gets the model number of the pump.

        Example: `1000` for NE-1000.
        """
        return self.__model_number

    @property
    def firmware_version(self) -> typing.Tuple[int, int] :
        """Gets the firmware version of the pump as major version and minor version."""
        return self.__firmware_version

    @property
    def firmware_upgrade(self) -> int :
        """
        Gets the firmware upgrade of the pump.

        Zero if the pump has no firmware upgrade.
        """
        return self.__firmware_upgrade

    @property
    def safe_mode_timeout(self) -> int :
        """
        Gets the safe mode timeout of the pump in units of seconds.

        Values: [`0`, `SAFE_MODE_TIMEOUT_LIMIT`]
        """
        return 0

    @safe_mode_timeout.setter
    def safe_mode_timeout(self, safe_mode_timeout : int) -> None :
        """
        Sets the safe mode timeout of the pump in units of seconds.

        Values: [`0`, `SAFE_MODE_TIMEOUT_LIMIT`]

        A value of zero will set the communication to basic mode.
        A non-zero value will set the communication to safe mode.

        :raises ValueError:
            Safe mode timeout invalid.
        """
        self.__safe_mode_timeout_set(safe_mode_timeout)

    @property
    def status(self) -> Status :
        """Gets the status of the pump."""
        status = Status.STOPPED
        return status

    @property
    def running(self) -> bool :
        """Gets if the pump is running."""
        return self.status in [Status.INFUSING, Status.WITHDRAWING, Status.PURGING]

    @property
    def syringe_diameter(self) -> float :
        """
        Gets the syringe diameter of the pump in units of millimeters.

        Values: [`SYRINGE_DIAMETER_MINIMUM`, `SYRINGE_DIAMETER_MAXIMUM`]
        """
        match = self.__syringe_diameter
        return float(match)

    @syringe_diameter.setter
    def syringe_diameter(self, syringe_diameter : float) -> None :
        """
        Sets the syringe diameter of the pump in units of millimeters.

        Values: [`SYRINGE_DIAMETER_MINIMUM`, `SYRINGE_DIAMETER_MAXIMUM`]

        This value dictates the minimum and maximum pumping rate of the pump.

        Note: The value is truncated to the 4 most significant digits.

        :raises ValueError:
            Syringe diameter invalid.
        """
        if (
            syringe_diameter < Pump.SYRINGE_DIAMETER_MINIMUM or
            syringe_diameter > Pump.SYRINGE_DIAMETER_MAXIMUM
        ) :
            raise ValueError('Syringe diameter invalid: Value exceeds limit.')
        self.__syringe_diameter = syringe_diameter

    @property
    def pumping_direction(self) -> PumpingDirection :
        """Gets the pumping direction of the pump."""
        pumping_direction_string = self.__pumping_direction

        pumping_direction = Pump.__PUMPING_DIRECTION_EXTERNAL.get(pumping_direction_string)
        if pumping_direction is None :
            raise InternalException()
        return pumping_direction

    @pumping_direction.setter
    def pumping_direction(self, pumping_direction : PumpingDirection) -> None :
        """Sets the pumping direction of the pump."""
        pumping_direction_string = Pump.__PUMPING_DIRECTION_INTERNAL.get(pumping_direction)
        if pumping_direction_string is None :
            raise ValueError('Pumping direction invalid: Value unknown.')
        self.__pumping_direction = pumping_direction_string

    @property
    def pumping_volume(self) -> float :
        """Gets the pumping volume of the pump in units of milliliters."""
        match = self.__pumping_volume
        value = float(match[0])
        units = match[1]
        value_milliliters = Pump.__VOLUME_MILLILITERS.get(units)
        if value_milliliters is None :
            raise InternalException()
        return value_milliliters(value)

    @pumping_volume.setter
    def pumping_volume(self, pumping_volume : float) -> None :
        """
        Sets the pumping volume of the pump in units of milliliters.

        Note: The value is truncated to the 4 most significant digits.

        :raises ValueError:
            Pumping volume invalid.
        """
        if pumping_volume < 0.001 / 1_000.0 or pumping_volume >= 10_000.0 :
            raise ValueError('Pumping volume invalid: Value exceeds limit.')
        if pumping_volume >= 10_000.0 / 1_000.0 :
            units = 'ML'
        else :
            pumping_volume *= 1_000.0
            units = 'UL'
        self.__pumping_volume = (pumping_volume, units)
        try :
            self.__pumping_volume = (pumping_volume, units)
        except ValueError :
            raise ValueError('Pumping volume invalid: Value exceeds limit.')

    @property
    def pumping_rate(self) -> float :
        """Gets the pumping rate of the pump in units of milliliters per minute."""
        match = self.__pump_rate
        value = float(match[0])
        units = match[1]
        value_milliliters_per_minute = Pump.__PUMPING_RATE_MILLILITERS_PER_MINUTE.get(units)
        if value_milliliters_per_minute is None :
            raise InternalException()
        return value_milliliters_per_minute(value)

    @pumping_rate.setter
    def pumping_rate(self, pumping_rate : float) -> None :
        """
        Sets the pumping rate of the pump in units of milliliters per minute.

        The limits are dictated by the syringe diameter of the pump.

        Note: The value is truncated to the 4 most significant digits.

        :raises ValueError:
            Pumping rate invalid.
        """
        if pumping_rate < 0.001 / 60_000.0 or pumping_rate >= 10_000.0 :
            raise ValueError('Pumping rate invalid: Value exceeds limit.')
        if pumping_rate >= 10_000.0 / 60.0 :
            units = 'MM'
        elif pumping_rate >= 10_000.0 / 1_000.0 :
            pumping_rate *= 60.0
            units = 'MH'
        elif pumping_rate >= 10_000.0 / 60_000.0 :
            pumping_rate *= 1_000.0
            units = 'UM'
        else :
            pumping_rate *= 60_000.0
            units = 'UH'
        try :
            self.__pump_rate = (pumping_rate, units)
        except ValueError :
            raise ValueError('Pumping rate invalid: Value exceeds limit.')

    @property
    def volume_infused(self) -> float :
        """Gets the volume infused of the pump in units of milliliters."""
        # convert to mililiters
        if self.__pumping_volume[1] == 'UL' :
            return self.__volume_infused / 1_000.0
        return self.__volume_infused

    def volume_infused_clear(self) -> None :
        """Sets the volume infused of the pump to zero."""
        self.__volume_infused = 0.0

    @property
    def volume_withdrawn(self) -> float :
        """Gets the volume withdrawn of the pump in units of milliliters."""
        # convert to mililiters
        if self.__pumping_volume[1] == 'UL' :
            return self.__volume_withdrawn / 1_000.0
        return self.__volume_withdrawn

    def volume_withdrawn_clear(self) -> None :
        """Sets the volume withdrawn of the pump to zero."""
        self.__volume_withdrawn = 0.0

    def run(self, wait_while_running : bool = True) -> None :
        """
        Runs the pump considering the direction, volume, and rate set.

        :param wait_while_running:
            If the function waits while the pump is running.
        """
        if self.__pumping_volume[0] == 0.0 :
            return
        if self.__pump_rate[0] == 0.0 :
            return
        # get units
        units = self.__pumping_volume[1]
        # get volume
        volume = self.__pumping_volume[0]
        # convert to mililiters
        if units == 'UL' :
            volume = volume / 1_000.0
        # set volume 
        if self.__pumping_direction == Pump.__PumpingDirectionInfuse :
            self.__volume_infused += self.__pumping_volume[0]
        else :
            self.__volume_withdrawn += self.__pumping_volume[0]
            
    def run_purge(self) -> None :
        """
        Runs the pump considering the direction set at maximum rate.

        Running will continue until stopped.
        """
        pass

    def stop(self, wait_while_running : bool = True) -> None :
        """
        Stops the pump.

        :param wait_while_running:
            If the function waits while the pump is running.
        """
        pass

    def wait_while_running(self) -> None :
        """Waits while the pump is running."""
        pass

    # Start transmission
    __STX = 0x02
    # End transmission
    __ETX = 0x03

    class __CommandName(str, enum.Enum) :
        STATUS             = ''
        SAFE_MODE_TIMEOUT  = 'SAF'
        FIRMWARE_VERSION   = 'VER'
        SYRINGE_DIAMETER   = 'DIA'
        PUMPING_DIRECTION  = 'DIR'
        PUMPING_VOLUME     = 'VOL'
        PUMPING_RATE       = 'RAT'
        DISPENSATION       = 'DIS'
        DISPENSATION_CLEAR = 'CLD'
        RUN                = 'RUN'
        RUN_PURGE          = 'PUR'
        STOP               = 'STP'

    __STATUS = {
        'I' : Status.INFUSING,
        'W' : Status.WITHDRAWING,
        'X' : Status.PURGING,
        'S' : Status.STOPPED,
        'P' : Status.PAUSED,
        'T' : Status.SLEEPING,
        'U' : Status.WAITING
    }

    __STATUS_ALARM = 'A'

    __ALARM_STATUS = {
        'R' : AlarmStatus.RESET,
        'S' : AlarmStatus.STALLED,
        'T' : AlarmStatus.TIMEOUT,
        'E' : AlarmStatus.ERROR,
        'O' : AlarmStatus.RANGE
    }

    # Regular expressions.
    __RE_INTEGER = r'(\d+)'
    __RE_FLOAT   = r'(\d+\.\d*)'
    __RE_SYMBOL  = '([A-Z]+)'

    # Format: "NE" <Model number> ("X" (<Firmware upgrade>)?)? "V"
    # <Firmware major version> "." <Firmware minor version>
    __RE_PATTERN_FIRMWARE_VERSION = re.compile(
        'NE' + __RE_INTEGER + '(X' + __RE_INTEGER + '?)?' + 'V' +
        __RE_INTEGER + r'\.' + __RE_INTEGER,
        re.ASCII
    )
    __RE_PATTERN_SAFE_MODE_TIMEOUT = re.compile(__RE_INTEGER, re.ASCII)
    __RE_PATTERN_SYRINGE_DIAMETER = re.compile(__RE_FLOAT, re.ASCII)
    # Format: <Pumping volume> <Units>
    __RE_PATTERN_PUMPING_VOLUME = re.compile(__RE_FLOAT + __RE_SYMBOL, re.ASCII)
    # Format: <Pumping rate> <Units>
    __RE_PATTERN_PUMPING_RATE = re.compile(__RE_FLOAT + __RE_SYMBOL, re.ASCII)
    # Format: "I" <Volume infused> "W" <Volume withdrawn> <Units>
    __RE_PATTERN_DISPENSATION = re.compile('I' + __RE_FLOAT + 'W' + __RE_FLOAT + __RE_SYMBOL)

    __PumpingDirectionInfuse   = 'INF'
    __PumpingDirectionWithdraw = 'WDR'

    __PUMPING_DIRECTION_EXTERNAL = {
        __PumpingDirectionInfuse : PumpingDirection.INFUSE,
        __PumpingDirectionWithdraw : PumpingDirection.WITHDRAW
    }

    __PUMPING_DIRECTION_INTERNAL = {
        pumping_direction_external : pumping_direction_internal
        for pumping_direction_internal, pumping_direction_external in
        __PUMPING_DIRECTION_EXTERNAL.items()
    }

    __PUMPING_RATE_MILLILITERS_PER_MINUTE = {
        # Milliliters per minute.
        'MM' : lambda value : value,
        # Milliliters per hour.
        'MH' : lambda value : value / 60.0,
        # Microliters per minute.
        'UM' : lambda value : value / 1_000.0,
        # Microliters per hour.
        'UH' : lambda value : value / 60_000.0,
    }

    __VOLUME_MILLILITERS = {
        # Milliliters.
        'ML' : lambda value : value,
        # Microliters.
        'UL' : lambda value : value / 1_000.0,
    }

    __VOLUME_MILLILITERS_SET = {
        # Milliliters.
        'ML' : lambda value : value,
        # Microliters.
        'UL' : lambda value : value * 1_000.0,
    }

    def __error_handle_not_applicable(self) -> None :
        raise StateException()

    def __error_handle_out_of_range(self) -> None :
        raise ValueError()

    def __error_handle_communication(self) -> None :
        raise ChecksumRequestException()

    def __error_handle_ignored(self) -> None :
        pass

    __ERROR = {
        # Not applicable.
        'NA'  : __error_handle_not_applicable,
        # Out of range.
        'OOR' : __error_handle_out_of_range,
        # Communication.
        'COM' : __error_handle_communication,
        # Ignored.
        'IGN' : __error_handle_ignored
    }

    def __argument_str(self, value : str) -> str :
        return value

    def __argument_int(self, value : int) -> str :
        return str(value)

    def __argument_float(self, value : float) -> str :
        # From the docs: Maximum of 4 digits plus 1 decimal point. Maximum of 3 digits to the right
        # of the decimal point.
        if value.is_integer() :
            return str(int(value))
        value_string = str(value)
        if len(value_string) > 5 :
            value_string = value_string[0 : 5]
        return value_string

    __ARGUMENT = {
        str   : __argument_str,
        int   : __argument_int,
        float : __argument_float
    }

    def __safe_mode_timeout_set(self, safe_mode_timeout : int, initial : bool = False) -> None :
        pass

    def __firmware_version_get(self) -> typing.Tuple[int, typing.Tuple[int, int], int] :
        return 9999, (9999, 9999), 9999

    def __dispensation_get(self, withdrawn : bool) -> float :
        if withdrawn :
            # convert to mililiters
            if self.pumping_volume[1] == 'UL' :
                return self.__volume_withdrawn / 1_000.0
            return self.__volume_withdrawn
        # convert to mililiters
        if self.pumping_volume[1] == 'UL' :
            return self.__volume_infused / 1_000.0
        return self.__volume_infused