"""
A "driver" class for controlling a new era A-1000 syringe pump using the nesp-lib library
"""

# pylint: disable=line-too-long, too-many-arguments, too-many-lines, too-many-instance-attributes, too-many-locals, import-outside-toplevel
import logging
import time
from typing import Optional, Union


from panda_lib.nesp_lib_py import nesp_lib
from panda_lib.config.config import PATH_TO_LOGS
from panda_lib.correction_factors import reverse_correction_factor
from panda_lib.experiment_class import ExperimentResult
from panda_lib.mill_control import Mill, MockMill
from panda_lib.nesp_lib_py.nesp_lib.mock import Pump as MockNespLibPump
from panda_lib.pipette import Pipette
from panda_lib.sartorious.sartorius.driver import Scale
from panda_lib.sartorious.sartorius.mock import Scale as MockScale
from panda_lib.utilities import Coordinates, Instruments
from panda_lib.vessel import VesselLogger
import panda_lib.wellplate as wp
from panda_lib.vials import StockVial, Vial2, WasteVial

pump_control_logger = logging.getLogger("e_panda")
if not pump_control_logger.hasHandlers():
    pump_control_logger = logging.getLogger("pump_control")
    pump_control_logger.setLevel(logging.DEBUG)
    formatter = logging.Formatter(
        "%(asctime)s&%(name)s&%(module)s&%(funcName)s&%(lineno)d&%(message)s"
    )
    file_handler = logging.FileHandler(PATH_TO_LOGS / "pump_control.log")
    file_handler.setFormatter(formatter)
    pump_control_logger.addHandler(file_handler)

scale_logger = logging.getLogger("e_panda")
if not scale_logger.hasHandlers():
    scale_logger = logging.getLogger("scale")
    scale_logger.setLevel(logging.DEBUG)
    formatter = logging.Formatter(
        "%(asctime)s&%(name)s&%(module)s&%(funcName)s&%(lineno)d&%(message)s"
    )
    file_handler = logging.FileHandler(PATH_TO_LOGS / "scale.log")
    file_handler.setFormatter(formatter)
    scale_logger.addHandler(file_handler)

vessel_logger = VesselLogger("pipette").logger


class SyringePump:
    """
    Class for controlling a new era A-1000 syringe pump using the nesp-lib library

    Attributes:
        pump (Pump): Initialized pump object.
        capacity (float): Maximum volume of the syringe in milliliters.
        pipette_capacity_ml (float): Maximum volume of the pipette in milliliters.
        pipette_capacity_ul (float): Maximum volume of the pipette in microliters.
        pipette_volume_ul (float): Current volume of the pipette in microliters.
        pipette_volume_ml (float): Current volume of the pipette in milliliters.

    Methods:
        withdraw(volume, rate): Withdraw the given volume at the given rate.
        infuse(volume, rate): Infuse the given volume at the given rate.
        purge(purge_vial, pump, purge_volume, pumping_rate): Perform purging from the pipette.
        mix(repetitions, volume, rate): Mix the solution in the pipette by withdrawing and infusing the solution.
        update_pipette_volume(volume_ul): Set the volume of the pipette in ul.
        set_pipette_capacity(capacity_ul): Set the capacity of the pipette in ul.

    Exceptions:
        OverFillException: Raised when a syringe is over filled.
        OverDraftException: Raised when a syringe is over drawn.
    """

    def __init__(
        self, mill: Union[Mill, MockMill], scale: Union[Scale, MockScale] = None
    ):
        """
        Initialize the pump and set the capacity.
        """
        self.pump = self.set_up_pump()
        self.max_pump_rate = float(0.640)  # ml/min
        self.syringe_capacity = float(1.0)  # mL
        self.pipette = Pipette()
        self.mill = mill
        if scale is not None:
            self.scale = scale
        else:
            self.scale = MockScale()

    def set_up_pump(self):
        """
        Set up the syringe pump using hardcoded settings.
        Returns:
            Pump: Initialized pump object.
        """
        try:
            pump_control_logger.info("Setting up pump...")
            pump_port = nesp_lib.Port("COM5", 19200)
            syringe_pump = nesp_lib.Pump(pump_port)
            syringe_pump.syringe_diameter = 4.600  # millimeters #4.643 #4.685
            syringe_pump.volume_infused_clear()
            syringe_pump.volume_withdrawn_clear()
            log_msg = f"Pump found at address {syringe_pump.address}"
            pump_control_logger.info(log_msg)
            time.sleep(2)
        except Exception as e:
            pump_control_logger.error("Error setting up pump: %s", e)
            pump_control_logger.exception(e)
            raise e
        return syringe_pump

    def withdraw(
        self,
        volume_to_withdraw: float,
        solution: Optional[Union[wp.Well, StockVial, WasteVial]] = None,
        rate: float = None,
        weigh: bool = False,
        results: ExperimentResult = None,
    ):
        """
        Withdraw the given volume at the given rate and depth from the specified position.
        Update the volume of the pipette and the solution if given.
        Args:
            volume (float): Volume to be withdrawn in microliters.
            solution (Vial object or str): The vial or wellplate ID to withdraw from
            rate (float): Pumping rate in milliliters per minute.

        Returns:
            The updated solution object if given one
        """
        # Perform the withdrawl
        # TODO Consider tracking the volume of air in the pipette as blowout and dripstop?
        volume_to_withdraw = float(volume_to_withdraw)
        if volume_to_withdraw > 0:
            volume_ml = volume_to_withdraw / 1000 # convert the volume argument from ul to ml

            if solution is not None and isinstance(solution, Vial2):
                density = solution.density
            else:
                density = None
                rate = (
                    self.max_pump_rate
                )  # if no solution, assume air and use the max pump rate

            _, pumprecord = self.run_pump(
                nesp_lib.PumpingDirection.WITHDRAW, volume_ml, rate, density, weigh
            )
            self.update_pipette_volume(self.pump.volume_withdrawn)
            pump_control_logger.info(
                "Pump has withdrawn: %0.6f ml at %fmL/min  Pipette vol: %0.3f ul",
                self.pump.volume_withdrawn,
                self.pump.pumping_rate,
                self.pipette.volume,
            )
            if solution is not None and isinstance(solution, Vial2):
                pumprecord["solution"] = solution.name
            if results is not None:
                results.pumping_record.append(pumprecord)
            self.pump.volume_infused_clear()
            self.pump.volume_withdrawn_clear()
            if isinstance(solution, (Vial2, wp.Well)):
                if isinstance(solution.contents, dict):
                    # Calculate the ratio of the solution being withdrawn
                    content_ratio = {
                        key: value / sum(solution.contents.values())
                        for key, value in solution.contents.items()
                    }
                    # Update the pipette contents
                    for key, ratio in content_ratio.items():
                        self.pipette.update_contents(key, float(ratio * volume_to_withdraw))
                else:
                    self.pipette.update_contents(solution.contents, volume_to_withdraw)
                # Update the solution volume and contents
                solution.update_volume(-volume_to_withdraw)
                solution.update_contents(solution.contents, -volume_to_withdraw)

                return None
        else:
            return None

    def withdraw_air(self, volume: float):
        """Withdraw the given ul of air with the pipette"""
        volume = float(volume)
        if volume > 0:
            volume_ml = volume / 1000
            _, _ = self.run_pump(
                nesp_lib.PumpingDirection.WITHDRAW, volume_ml, self.max_pump_rate
            )
            self.update_pipette_volume(self.pump.volume_withdrawn)
            pump_control_logger.info(
                "Pump has withdrawn: %0.6f ml of air at %fmL/min  Pipette vol: %0.3f ul",
                self.pump.volume_withdrawn,
                self.pump.pumping_rate,
                self.pipette.volume,
            )
            self.pump.volume_infused_clear()
            self.pump.volume_withdrawn_clear()
            return 0 # return 0 if successful
        else:
            return 1 # return 1 if volume is 0

    def infuse(
        self,
        volume_to_infuse: float,
        being_infused: Optional[Union[wp.Well, StockVial, WasteVial]] = None,
        infused_into: Optional[Union[wp.Well, StockVial, WasteVial]] = None,
        rate: float = float(0.5),
        blowout_ul: float = float(0.0),
        weigh: bool = False,
        results: ExperimentResult = None,
    ) -> int:
        """
        Infuse the given volume at the given rate and depth from the specified position.
        Args:
            volume (float): Volume to be infused in microliters.
            solution (Vial object): The solution being infused to get the density
            destination (str or Vial): The destination of the solution (well or vial)
            rate (float): Pumping rate in milliliters per minute.
            blowout_ul (float): The volume to blowout in microliters
            weigh (bool): If true, will weigh the solution before and after infusing and log the difference

        Returns:
            int: The difference in weight if weighing, otherwise 0
        """
        # convert the volume argument from ul to ml
        # pumprecord = {}
        volume_ul = float(volume_to_infuse)
        blowout_ml = float(blowout_ul) / 1000
        if volume_ul > 0:
            volume_ml = volume_ul / 1000
            if being_infused is not None:
                density = being_infused.density
                viscosity = being_infused.viscosity_cp
            else:
                density = None
                viscosity = None
                rate = (
                    self.max_pump_rate
                )  # if no solution, assume air and use the max pump rate
            # _, pumprecord = self.run_pump(nesp_lib.PumpingDirection.INFUSE, volume_ml, rate, density, blowout_ml, weigh)
            _, pumprecord = self.run_pump(
                nesp_lib.PumpingDirection.INFUSE,
                volume_ml,
                rate,
                density,
                blowout_ml,
                weigh,
                viscosity,
            )
            self.update_pipette_volume(self.pump.volume_infused)
            pump_control_logger.info(
                "Pump has infused: %0.6f ml (%0.6f of solution) at %fmL/min Pipette volume: %0.3f ul",
                self.pump.volume_infused,
                float(float(self.pump.volume_infused) - blowout_ml),
                self.pump.pumping_rate,
                self.pipette.volume,
            )
            if being_infused is not None and isinstance(being_infused, Vial2):
                pumprecord["solution"] = being_infused.name
            if results is not None:
                results.pumping_record.append(pumprecord)

            # Clear the pump's memory so that future operations are fresh
            self.pump.volume_infused_clear()
            self.pump.volume_withdrawn_clear()

            if (
                infused_into is not None
            ):  # The we need to update the volume and contents of the vessel

                infused_into.update_volume(volume_ul)
                infused_into.update_contents(self.pipette.contents, volume_ul)

                # Update the pipette contents
                content_ratio = {
                    key: value / sum(self.pipette.contents.values())
                    for key, value in self.pipette.contents.items()
                }

                for key, ratio in content_ratio.items():
                    self.pipette.update_contents(key, -volume_ul * ratio)

                return 0
            return 0
        else:
            return 0

    def infuse_air(self, volume: float):
        """Infuse the given ul of air with the pipette"""
        volume_ul = float(volume)
        if volume_ul > 0:
            volume_ml = volume_ul / 1000
            _, _ = self.run_pump(
                nesp_lib.PumpingDirection.INFUSE, volume_ml, self.max_pump_rate
            )
            self.update_pipette_volume(self.pump.volume_infused)
            pump_control_logger.info(
                "Pump has infused: %0.6f ml of air at %fmL/min Pipette volume: %0.3f ul",
                self.pump.volume_infused,
                self.pump.pumping_rate,
                self.pipette.volume,
            )
            self.pump.volume_infused_clear()
            self.pump.volume_withdrawn_clear()
        return 0

    def run_pump(
        self,
        pump_direction: nesp_lib.PumpingDirection,
        volume_ml:float,
        rate=None,
        density=None,
        blowout_ml=float(0.0),
        weigh: bool = False,
        viscosity: float = None,
    ) -> tuple[float, dict]:
        """Combine all the common commands to run the pump into one function"""
        pumping_record = {}
        volume_ml = float(volume_ml)
        blowout_ml = float(blowout_ml)
        density = float(density) if density is not None else None
        if volume_ml <= 0:
            return 0, pumping_record
        # Set the pump parameters for the run
        if self.pump.pumping_direction != pump_direction:
            self.pump.pumping_direction = pump_direction
        self.pump.pumping_volume = float(volume_ml + blowout_ml)  # conver to float for nesp-lib
        if rate is None:
            self.pump.pumping_rate = float(self.max_pump_rate) # conver to float for nesp-lib
        else:
            self.pump.pumping_rate = float(rate)
        action = (
            "Withdrawing"
            if pump_direction == nesp_lib.PumpingDirection.WITHDRAW
            else "Infusing"
        )
        pre_weight = 0.00
        post_weight = 0.00
        ## Get scale value prior to pump action
        if density is not None and density != 0 and weigh:
            # pre_weight = float(self.scale.read_scale())
            scale_logger.debug(
                "Expected difference in scale reading: %f", volume_ml * density
            )
            scale_logger.debug("Scale reading before %s: %f", action, pre_weight)

        pump_control_logger.info(
            "%s %f ml at %f mL/min...", action, volume_ml, self.pump.pumping_rate
        )
        time.sleep(0.5)
        self.pump.run()
        while self.pump.running:
            pass
        pump_control_logger.debug("Done %s", action)

        # time.sleep(3)  # let the scale settle

        ## Get scale value after pump action
        if density is not None and density != 0 and weigh:
            # post_weight = float(self.scale.value())
            # post_weight = float(self.scale.read_scale())
            scale_logger.debug("Scale reading after %s: %f", action, post_weight)
            scale_logger.debug("Scale reading difference: %f", post_weight - pre_weight)
            scale_logger.info(
                "Data,%s,%f,%f,%f,%f,%f,%f,%f",
                action,
                volume_ml,
                reverse_correction_factor(volume_ml * 1000, viscosity) / 1000,
                density,
                pre_weight,
                post_weight,
                self.pump.pumping_rate,
                viscosity,
            )
            pumping_record = {
                "action": action,
                "solution": "",
                "volume": volume_ml,
                "density": density,
                "pre_weight": pre_weight,
                "post_weight": post_weight,
                "pumping_rate": self.pump.pumping_rate,
                "viscosity": viscosity,
            }

        action_type = (
            "infused" if pump_direction == nesp_lib.PumpingDirection.INFUSE else "withdrawn"
        )
        action_volume = (
            self.pump.volume_infused
            if pump_direction == nesp_lib.PumpingDirection.INFUSE
            else self.pump.volume_withdrawn
        )
        log_msg = f"Pump has {action_type}: {action_volume} ml"
        pump_control_logger.debug(log_msg)
        if density is not None and density != 0 and weigh:
            expected_difference = float(volume_ml * density)
            difference = float(post_weight - pre_weight)
            scale_logger.debug("Expected difference: %f", expected_difference)
            scale_logger.debug("Actual difference: %f", difference)
            percent_error = abs(
                (difference - expected_difference) / expected_difference
            )
            if percent_error > 0.50:
                scale_logger.warning("Percent error is above 50%")
                # SlackBot().send_slack_message('alert',f'WARNING: Percent Error was {percent_error*100}% for most recent experiment')
            return difference, pumping_record

        return 0, pumping_record

    def mix(
        self,
        mix_location: Optional[dict] = None,
        mix_repetitions=3,
        mix_volume=float(200.0),
        mix_rate=float(0.62),
    ):
        """Mix the solution in the pipette by withdrawing and infusing the solution
        Args:
            mix_location (dict): Dictionary containing x, y, and z coordinates of the position.
            mix_repetitions (int): Number of times to mix the solution.
            mix_volume (float): Volume to be infused in microliters.
            mix_rate (float): Pumping rate in milliliters per minute.

        Returns:
            None
        """
        pump_control_logger.info("Mixing %d times", mix_repetitions)

        if mix_location is None:
            for i in range(mix_repetitions):
                pump_control_logger.debug("Mixing %d of %d times", i, mix_repetitions)
                self.withdraw(volume_to_withdraw=mix_volume, rate=mix_rate)
                current_coords = Coordinates(*self.mill.current_coordinates())

                self.mill.set_feed_rate(500)
                self.mill.safe_move(
                    x_coord=current_coords.x,
                    y_coord=current_coords.y,
                    z_coord=current_coords.z + 5.0,
                    instrument=Instruments.PIPETTE,
                )
                self.infuse(volume_to_infuse=mix_volume, rate=mix_rate)
                self.mill.safe_move(
                    x_coord=current_coords.x,
                    y_coord=current_coords.y,
                    z_coord=current_coords.z,
                    instrument=Instruments.PIPETTE,
                )
                self.mill.set_feed_rate(2000)
        else:
            # move to mix location
            self.mill.safe_move(
                x_coord=mix_location["x"],
                y_coord=mix_location["y"],
                z_coord=mix_location["depth"],
                instrument=Instruments.PIPETTE,
            )

            for i in range(mix_repetitions):
                pump_control_logger.debug("Mixing %d of %d times", i, mix_repetitions)
                self.withdraw(volume_to_withdraw=mix_volume, rate=mix_rate)
                self.mill.set_feed_rate(500)
                self.mill.safe_move(
                    x_coord=mix_location["x"],
                    y_coord=mix_location["y"],
                    z_coord=mix_location["depth"] + 1.5,
                    instrument=Instruments.PIPETTE,
                )
                self.infuse(volume_to_infuse=mix_volume, rate=mix_rate)
                self.mill.safe_move(
                    x_coord=mix_location["x"],
                    y_coord=mix_location["y"],
                    z_coord=mix_location["depth"],
                    instrument=Instruments.PIPETTE,
                )
                self.mill.set_feed_rate(2000)
            # move back to original position
            self.mill.move_to_safe_position()
            return None

    def update_pipette_volume(self, volume_ml: float):
        """Change the volume of the pipette in ml"""
        volume_ml = float(volume_ml)
        if self.pump.pumping_direction == nesp_lib.PumpingDirection.INFUSE:
            self.pipette.volume = round(self.pipette.volume - (volume_ml * 1000.6))
        else:
            self.pipette.volume = round(self.pipette.volume + (volume_ml * 1000),6)


class MockPump(SyringePump):
    """Mock pump class for testing"""

    def set_up_pump(self):
        """
        Set up the syringe pump using hardcoded settings.
        Returns:
            Pump: Initialized pump object.
        """
        pump_control_logger.info("Setting up pump...")
        syringe_pump = MockNespLibPump()
        syringe_pump.syringe_diameter = 4.600  # millimeters #4.643 #4.685
        syringe_pump.volume_infused_clear()
        syringe_pump.volume_withdrawn_clear()
        log_msg = f"Pump found at address {syringe_pump.address}"
        pump_control_logger.info(log_msg)
        time.sleep(2)
        return syringe_pump


def _test_mixing():
    """Test the mixing function"""
    from .wellplate import Wellplate

    wellplate = Wellplate()
    a1 = wellplate.get_coordinates("A1")
    with Mill() as mill:
        mill.homing_sequence()
        syringe_pump = SyringePump(mill=mill, scale=Scale())
        mill.safe_move(a1["x"], a1["y"], a1["depth"], Instruments.PIPETTE)
        syringe_pump.mix()


def _mock_pump_testing_routine():
    """Test the pump"""
    with MockMill() as mill:
        mock_pump = MockPump(mill=mill, scale=MockScale())
        mock_pump.withdraw(100)
        assert mock_pump.pipette.volume == 100
        assert mock_pump.pipette.volume_ml == 0.1
        mock_pump.infuse(100)
        assert mock_pump.pipette.volume == 0
        assert mock_pump.pipette.volume_ml == 0
        # mock_pump.mix()



if __name__ == "__main__":
    # test_mixing()
    # _mock_pump_testing_routine()
    # pump = Pump(mill=MockMill(), scale=MockScale())
    # pump.withdraw(160, rate=0.64)
    # pump.infuse(167.43, rate=0.64, blowout_ul=0)

    pipette = Pipette()
    pipette.update_contents("water", 100)
