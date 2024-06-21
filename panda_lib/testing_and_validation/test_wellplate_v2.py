import unittest
from panda_lib import sql_utilities
from panda_lib.wellplate import WellCoordinates, Wellplate
from panda_lib.experiment_class import ExperimentBase
import time
class TestWellplate(unittest.TestCase):

    def setUp(self):
        # Create a wellplate with 96 wells
        self.wp = Wellplate()  # Default is 96 wells from the json file and db

    def test_coordinates(self):
        # Get the coordinates of a well
        well = "A2"
        well_coord = self.wp.get_coordinates(well)
        db_well_coord = sql_utilities.get_well(well).coordinates

        # Check that the coordinates are the same
        self.assertEqual(well_coord, db_well_coord)

        # Test changing the well coordinates
        original_coordinates = self.wp.get_coordinates(well)
        new_coordinates = WellCoordinates(0, 0, 0)
        self.wp.update_well_coordinates(well, new_coordinates)
        new_memory = self.wp.get_coordinates(well)
        new_db = sql_utilities.get_well(well).coordinates

        # Check that the coordinates are the same
        self.assertEqual(new_memory, new_db, new_coordinates)

        # Change the coordinates back to the original
        self.wp.update_well_coordinates(well, original_coordinates)
        memory = self.wp.get_coordinates(well)
        db = sql_utilities.get_well(well).coordinates

        # Check that the coordinates are the same
        self.assertEqual(memory, db, original_coordinates)

    def test_update_status(self):
        """Test the update_well_status method"""

        # Get the status of a well
        well = "A2"
        well_status = self.wp.wells[well].status
        db_well_status = sql_utilities.get_well(well).status

        # Check that the status is the same
        self.assertEqual(well_status, db_well_status)

        # Test changing the well status
        original_status = db_well_status
        new_status = "test"
        time.sleep(1)
        self.wp.update_well_status(well, new_status)
        memory = self.wp.wells[well].status
        db = sql_utilities.get_well(well).status

        # Check that the status is the same
        self.assertEqual(memory, db, new_status)

        # Change the status back to the original
        self.wp.update_well_status(well, original_status)
        memory = self.wp.wells[well].status
        db = sql_utilities.get_well(well).status

        # Check that the status is the same
        self.assertEqual(memory, db, original_status)

if __name__ == "__main__":
    unittest.main()
