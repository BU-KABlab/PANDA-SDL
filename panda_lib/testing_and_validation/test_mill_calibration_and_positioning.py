import unittest
from unittest.mock import patch
from mill_calibration_and_positioning import calibrate_wells

class TestCalibrateWells(unittest.TestCase):
    @patch('builtins.input', side_effect=['', 'done'])
    def test_user_hits_enter(self, mock_input):
        # Create test objects
        mill = Mill()
        wellplate = Wellplate()
        stock_vials = []
        waste_vials = []

        # Call the function to be tested
        calibrate_wells(mill, wellplate, stock_vials, waste_vials)

        # Assert that the function breaks out of the loop when user hits enter
        self.assertEqual(mock_input.call_count, 2)

if __name__ == "__main__":
    unittest.main()from unittest import TestCase
from unittest.mock import patch

class TestCalibrateWells(TestCase):
    @patch('builtins.input', return_value='')
    def test_user_hits_enter(self, mock_input):
        # Call the calibrate_wells function
        # and assert that it breaks out of the loop
        with self.assertRaises(StopIteration):
            calibrate_wells(mill, wellplate, stock_vials, waste_vials)