import unittest
from wellplate import Wellplate, OverFillException, OverDraftException, Well


class TestWells2(unittest.TestCase):
    def setUp(self):
        """
        Set up the test case by creating a new instance of Wells2.
        """
        self.wells = Wellplate(type_number=4)

    def test_getitem(self):
        """
        Test the __getitem__ method of Wells2 by checking
        that it returns a Well object.
        """
        well = self.wells["A1"]
        self.assertIsInstance(well, Well)

    def test_get_coordinates(self):
        """
        Test the get_coordinates method of Wells2 by checking
        that it returns a dictionary with the expected keys.
        """
        coordinates = self.wells.get_coordinates("A1")
        self.assertIsInstance(coordinates, dict)
        self.assertIn("x", coordinates)
        self.assertIn("y", coordinates)
        self.assertIn("z", coordinates)
        self.assertIn("depth", coordinates)
        self.assertIn("echem_height", coordinates)

    def test_contents(self):
        """
        Test the contents method of Wells2 by checking that it returns None.
        """
        contents = self.wells.get_contents("A1")
        self.assertListEqual([], contents)

    def test_volume(self):
        """
        Test the volume method of Wells2 by checking that it returns 0.0.
        """
        volume = self.wells.get_volume("A1")
        self.assertEqual(volume, 0.0)

    def test_depth(self):
        """
        Test the depth method of Wells2 by checking that it returns -76.0.
        """
        self.assertAlmostEqual(self.wells['A1'].depth, -76.0,3)

    def test_density(self):
        """
        Test the density method of Wells2 by checking
        that it returns 1.0.
        """
        density = self.wells.get_density("A1")
        self.assertEqual(density, 1.0)

    def test_check_volume_positive(self):
        """
        Test the check_volume method of Wells2 by checking
        that it returns True when given a positive volume.
        """
        result = self.wells.check_volume("A1", 50.0)
        self.assertTrue(result)

    def test_update_volume_positive(self):
        """
        Test the update_volume method of Wells2 by checking
        that it updates the volume and depth of a well correctly
        when given a positive volume.
        """
        self.wells.update_volume("A1", 50.0)
        self.assertEqual(self.wells.get_volume("A1"), 50.0)
        self.assertAlmostEqual(self.wells.get_depth("A1"), -74.54, 2)

    def test_update_volume_over_capacity(self):
        """
        Test the update_volume method of Wells2 by checking
        that it raises an OverFillException when given a volume over capacity.
        """
        with self.assertRaises(OverFillException):
            self.wells.update_volume("A1", 400.0)

    def test_check_well_status(self):
        """
        Test the check_well_status method of Wells2 by checking
        that it returns "new" for a newly created well.
        """
        status = self.wells.check_well_status("A1")
        self.assertEqual(status, "new")

    def test_set_well_status(self):
        """
        Test the set_well_status method of Wells2 by checking
        that it sets the status of a well correctly.
        """
        self.wells.set_well_status("A1", "in use")
        status = self.wells.check_well_status("A1")
        self.assertEqual(status, "in use")

    def test_well_coordinates_and_status_color(self):
        """
        Test the well_coordinates_and_status_color method of Wells2
        by checking that it returns lists of the expected length.
        """
        (
            x_coordinates,
            y_coordinates,
            color,
        ) = self.wells.get_well_coordinates_and_status_color()
        self.assertIsInstance(x_coordinates, list)
        self.assertIsInstance(y_coordinates, list)
        self.assertIsInstance(color, list)
        self.assertEqual(len(x_coordinates), 96)
        self.assertEqual(len(y_coordinates), 96)
        self.assertEqual(len(color), 96)


if __name__ == "__main__":
    unittest.main()
