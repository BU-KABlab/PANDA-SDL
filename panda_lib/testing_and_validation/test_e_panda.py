import unittest
from unittest.mock import MagicMock
from e_panda import (
    forward_pipette_v2,
    solution_selector,
    waste_selector,
    NoAvailableSolution,
    flush_v2,
    rinse_v2,
    chrono_amp
)
from vials import Vessel, StockVial, WasteVial
from mill_control import MockMill
from pump_control import MockPump
from gamry_control_WIP_mock import GamryPotentiostat
from wellplate import Well, Wellplate
from sartorius.mock import Scale as MockScale
from experiment_class import PEG_ACR_Instructions, EchemExperimentBase

# pylint: disable=line-too-long, too-many-arguments, too-many-lines


class TestEPanda(unittest.TestCase):
    """_summary_

    Args:
        unittest (_type_): _description_
    """

    def setUp(self):
        self.from_vessel = Vessel(
            name="Test Vessel 1",
            volume=50.0,
            capacity=100.0,
            density=1.0,
            coordinates={"x": 0, "y": 0, "z": 0},
        )
        self.to_vessel = Vessel(
            name="Test Vessel 2",
            volume=50.0,
            capacity=100.0,
            density=1.0,
            coordinates={"x": 0, "y": 0, "z": 0},
        )
        self.mill = MockMill()
        self.scale = MockScale()
        self.pump = MockPump(self.mill, self.scale)

    def test_pipette_v2(self):
        """_summary_"""
        # Test pipetting from a vessel to another vessel
        with self.subTest("Test pipetting from a vessel to another vessel"):
            self.from_vessel.volume = 50.0
            self.to_vessel.volume = 50.0
            volume = 20.0
            forward_pipette_v2(
                volume=volume,
                from_vessel=self.from_vessel,
                to_vessel=self.to_vessel,
                pump=self.pump,
                mill=self.mill,
                pumping_rate=None,
            )
            self.assertEqual(self.from_vessel.volume, 30.0)
            self.assertEqual(self.to_vessel.volume, 70.0)

        # Test pipetting from a well to a waste vial
        with self.subTest("Test pipetting from a well to a waste vial"):
            self.from_vessel = Well(
                well_id="T1",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                height=20,
                depth=10,
                status="new",
            )
            self.to_vessel = WasteVial(
                name="Test Waste Vial",
                position="W0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            )
            self.from_vessel.volume = 50.0
            self.to_vessel.volume = 50.0
            volume = 20.0
            forward_pipette_v2(
                volume=volume,
                from_vessel=self.from_vessel,
                to_vessel=self.to_vessel,
                pump=self.pump,
                mill=self.mill,
                pumping_rate=None,
            )
            self.assertEqual(self.from_vessel.volume, 30.0)
            self.assertEqual(self.to_vessel.volume, 70.0)

        # Test pipetting from a stock vial to a waste vial
        with self.subTest("Test pipetting from a stock vial to a waste vial"):
            self.from_vessel = StockVial(
                name="Test Stock Vial",
                position="S0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            )
            self.to_vessel = WasteVial(
                name="Test Waste Vial",
                position="W0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            )
            self.from_vessel.volume = 50.0
            self.to_vessel.volume = 50.0
            volume = 20.0
            forward_pipette_v2(
                volume=volume,
                from_vessel=self.from_vessel,
                to_vessel=self.to_vessel,
                pump=self.pump,
                mill=self.mill,
                pumping_rate=None,
            )
            self.assertEqual(self.from_vessel.volume, 30.0)
            self.assertEqual(self.to_vessel.volume, 70.0)

        # Test raising an error when pipetting from a well to a stock vial
        with self.subTest(
            "Test raising an error when pipetting from a well to a stock vial"
        ):
            self.from_vessel = Well(
                well_id="T1",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                height=20,
                depth=10,
                status="new",
            )
            self.to_vessel = StockVial(
                name="Test Stock Vial",
                position="S0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            )
            with self.assertRaises(ValueError):
                forward_pipette_v2(
                    volume=20.0,
                    from_vessel=self.from_vessel,
                    to_vessel=self.to_vessel,
                    pump=self.pump,
                    mill=self.mill,
                    pumping_rate=None,
                )

        # Test raising an error when pipetting from a waste vial to a well
        with self.subTest(
            "Test raising an error when pipetting from a waste vial to a well"
        ):
            self.from_vessel = WasteVial(
                name="Test Waste Vial",
                position="W0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            )
            self.to_vessel = Well(
                well_id="T1",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                height=20,
                depth=10,
                status="new",
            )
            with self.assertRaises(ValueError):
                forward_pipette_v2(
                    volume=20.0,
                    from_vessel=self.from_vessel,
                    to_vessel=self.to_vessel,
                    pump=self.pump,
                    mill=self.mill,
                    pumping_rate=None,
                )

        # Test raising an error when pipetting from a stock vial to a stock vial
        with self.subTest(
            "Test raising an error when pipetting from a stock vial to a stock vial"
        ):
            self.from_vessel = StockVial(
                name="Test Stock Vial 1",
                position="S0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            )
            self.to_vessel = StockVial(
                name="Test Stock Vial 2",
                position="S0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            )
            with self.assertRaises(ValueError):
                forward_pipette_v2(
                    volume=20.0,
                    from_vessel=self.from_vessel,
                    to_vessel=self.to_vessel,
                    pump=self.pump,
                    mill=self.mill,
                    pumping_rate=None,
                )

    def test_solution_selector(self):
        """_summary_"""
        # Test selecting a solution from a list of solutions
        solutions = [
            StockVial(
                name="Solution 1",
                position="S0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            ),
            StockVial(
                name="Solution 2",
                position="S1",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            ),
            StockVial(
                name="Solution 1",
                position="S2",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            ),
        ]
        solution_name = "solution 2"
        volume = 20.0

        with self.subTest("Test selecting a solution from a list of solutions"):
            selected_solution = solution_selector(solutions, solution_name, volume)
            self.assertEqual(selected_solution.name, "Solution 2")

        with self.subTest("Test raising an error when no solution is available"):
            with self.assertRaises(NoAvailableSolution):
                solution_selector(solutions, "Solution 4", volume)

        with self.subTest("Test raising an error when the selected solution is empty"):
            solutions[1].volume = 0.0
            with self.assertRaises(NoAvailableSolution):
                solution_selector(solutions, solution_name, volume)

        with self.subTest(
            "Test selecting a solution from multiple options when one is empty"
        ):
            solutions[0].volume = 0.0
            solutions[2].volume = 50.0
            solution_name = "Solution 1"
            selected_solution = solution_selector(solutions, solution_name, volume)
            self.assertEqual(selected_solution.name, "Solution 1")
            self.assertEqual(selected_solution.volume, 50.0)
            self.assertEqual(selected_solution.position, "S2")

    def test_waste_selector(self):
        """_summary_"""
        # Test selecting a waste solution from a list of solutions
        solutions = [
            WasteVial(
                name="Test Waste Vial 1",
                position="W0",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            ),
            WasteVial(
                name="Test Waste Vial 2",
                position="W1",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            ),
            WasteVial(
                name="Test Waste Vial 1",
                position="W2",
                volume=50.0,
                capacity=100.0,
                density=1.0,
                coordinates={"x": 0, "y": 0, "z": 0},
                radius=5,
                height=10,
                z_bottom=0,
            ),
        ]
        solution_name = "test waste vial 2"
        volume = 20.0

        with self.subTest("Test selecting a waste solution from a list of solutions"):
            selected_solution = waste_selector(solutions, solution_name, volume)
            self.assertEqual(selected_solution.name, "Test Waste Vial 2")

        with self.subTest("Test raising an error when no solution is available"):
            with self.assertRaises(NoAvailableSolution):
                waste_selector(solutions, "Test Waste Vial 4", volume)

        with self.subTest("Test raising an error when the selected solution is full"):
            solutions[1].volume = 100.0
            with self.assertRaises(NoAvailableSolution):
                waste_selector(solutions, solution_name, volume)

        with self.subTest(
            "Test selecting a solution from multiple options when one is full"
        ):
            solutions[0].volume = 100.0
            solutions[2].volume = 50.0
            solution_name = "Test Waste Vial 1"
            volume = 20.0
            selected_solution = waste_selector(solutions, solution_name, volume)
            self.assertEqual(selected_solution.name, "Test Waste Vial 1")
            self.assertEqual(selected_solution.volume, 50.0)
            self.assertEqual(selected_solution.position, "W2")

    def test_rinse_v2(self):
        """_summary_"""
        # Test rinsing a well with rinse0, rinse1, and rinse2
        with self.subTest("Test rinsing a well with rinse0, rinse1, and rinse2"):
            wellplate = Wellplate()
            stock_vials = [
                StockVial(
                    name="rinse0",
                    position="S0",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
                StockVial(
                    name="rinse1",
                    position="S1",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
                StockVial(
                    name="rinse2",
                    position="S2",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
            ]
            waste_vials = [
                WasteVial(
                    name="Test Waste Vial 1",
                    position="W0",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
                WasteVial(
                    name="Test Waste Vial 2",
                    position="W1",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
                WasteVial(
                    name="Test Waste Vial 3",
                    position="W2",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
                WasteVial(
                    name="rinse0",
                    position="W3",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
                WasteVial(
                    name="rinse1",
                    position="W4",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
                WasteVial(
                    name="rinse2",
                    position="W5",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
            ]

            instructions = PEG_ACR_Instructions(
                id=00,
                experiment_name="Rinse Test",
                priority=1,
                well_id="A1",
                pin=000,
                project_id=0,
                solutions={},
                rinse_count=3,
                rinse_vol=20.0,
            )
            rinse_v2(
                wellplate=wellplate,
                instructions=instructions,
                pump=self.pump,
                mill=self.mill,
                stock_vials=stock_vials,
                waste_vials=waste_vials,
            )
            self.assertEqual(wellplate.get_volume("A1"), 0.0)
            self.assertEqual(waste_vials[3].volume, 70.0)
            self.assertEqual(waste_vials[4].volume, 70.0)
            self.assertEqual(waste_vials[5].volume, 70.0)
            self.assertEqual(stock_vials[0].volume, 30.0)
            self.assertEqual(stock_vials[1].volume, 30.0)
            self.assertEqual(stock_vials[2].volume, 30.0)

    def test_flush_v2(self):
        """_summary_"""
        # Test flushing pipette tip with flush_volume > 0
        with self.subTest("Test flushing pipette tip with flush_volume > 0"):
            stock_vials = [
                StockVial(
                    name="flush",
                    position="S0",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
            ]
            waste_vials = [
                WasteVial(
                    name="waste",
                    position="W0",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
            ]
            flush_solution_name = "flush"
            flush_volume = 20.0
            flush_v2(
                waste_vials=waste_vials,
                stock_vials=stock_vials,
                flush_solution_name=flush_solution_name,
                mill=self.mill,
                pump=self.pump,
                pumping_rate=None,
                flush_volume=flush_volume,
            )
            self.assertEqual(stock_vials[0].volume, 30.0)
            self.assertEqual(waste_vials[0].volume, 70.0)

        # Test flushing pipette tip with flush_volume = 0
        with self.subTest("Test flushing pipette tip with flush_volume = 0"):
            stock_vials = [
                StockVial(
                    name="flush",
                    position="S0",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
            ]
            waste_vials = [
                WasteVial(
                    name="Test Waste Vial",
                    position="W0",
                    volume=50.0,
                    capacity=100.0,
                    density=1.0,
                    coordinates={"x": 0, "y": 0, "z": 0},
                    radius=5,
                    height=10,
                    z_bottom=0,
                ),
            ]
            flush_solution_name = "flush"
            flush_volume = 0.0
            flush_v2(
                waste_vials=waste_vials,
                stock_vials=stock_vials,
                flush_solution_name=flush_solution_name,
                mill=self.mill,
                pump=self.pump,
                pumping_rate=None,
                flush_volume=flush_volume,
            )
            self.assertEqual(stock_vials[0].volume, 50.0)
            self.assertEqual(waste_vials[0].volume, 50.0)


# class TestEPandaProtocols(unittest.TestCase):
#     """
#     Unit tests to specifically test the protocols in e_panda.py
#     This will require the use of mocks for the hardware, especially the potentiostat

#     Args:
#         unittest (_type_): _description_
#     """
#     def setUp(self):
#         self.mill = MockMill()
#         self.scale = MockScale()
#         self.pump = MockPump(self.mill, self.scale)
#         self.gamry = GamryPotentiostat()
#         self.gamry.connect()
#         self.test_experiment = EchemExperimentBase(
#             id=0,
#             experiment_name="test",
#             priority=1,
#             target_well="A1",
#             pin=0,
#             project_id=0,
#             solutions={'dmf': 60, 'water': 40},
#         )
#         self.wellplate = Wells2(-100,-100)
#     def test_deposition(self):
#         """_summary_"""
#         # Test deposition protocol
#         with self.subTest("Test deposition protocol"):
#             deposition_parameters = {
#                 "deposition_time": self.test_experiment.CAt1,
#                 "deposition_voltage": self.test_experiment.CAv1,
#                 "deposition_current": 0.1,
#                 "deposition_cycles": 3,
#                 "deposition_step": 0.01,
#                 "deposition_rate": 0.1,
#                 "deposition_file": "test_deposition",
#             }
#             deposition_parameters = deposition(
#                 dep_instructions=self.test_experiment,
#                 dep_results= self.test_experiment.results,
#                 mill=self.mill,
#                 wellplate=self.wellplate
#             )

class CustomTestResult(unittest.TextTestResult):
    """
    Custom test result class to print test results to the console

    Args:
        unittest (TextTestResult): TextTestResult class from unittest (https://docs.python.org/3/library/unittest.html#unittest.TextTestResult
    """

    def addSuccess(self, test):
        super().addSuccess(test)
        print(f"SUCCESS: {test}")

    def addError(self, test, err):
        super().addError(test, err)
        print(f"ERROR: {test} - {err}")

    def addFailure(self, test, err):
        super().addFailure(test, err)
        print(f"FAILURE: {test} - {err}")

    def addSkip(self, test, reason):
        super().addSkip(test, reason)
        print(f"SKIPPED: {test} - {reason}")

    def printErrors(self):
        super().printErrors()
        print("Test Summary:")
        print("Ran: ", self.testsRun)
        print("Errors: ", len(self.errors))
        print("Failures: ", len(self.failures))
        print("Skipped: ", len(self.skipped))


class CustomTestRunner(unittest.TextTestRunner):
    """
    Custom test runner class to print test results to the console
    """

    resultclass = CustomTestResult


if __name__ == "__main__":
    unittest.main(testRunner=CustomTestRunner())
