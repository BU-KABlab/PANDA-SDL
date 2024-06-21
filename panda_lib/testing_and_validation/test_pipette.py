import time
import unittest
from panda_lib.pipette import Pipette

class TestPipette(unittest.TestCase):
    """
    Test the Pipette class.
    """

    def setUp(self):
        """
        Set up the test by creating a pipette with capacity of 1000 ul.
        """
        self.pipette = Pipette(200)
        self.assertEqual(self.pipette.capacity_ul, 200)
        self.assertEqual(self.pipette.capacity_ml, 0.2)
        time.sleep(1)

    def test_set_capacity(self):
        """
        Test setting the capacity of the pipette.
        """
        time.sleep(1)
        self.pipette.set_capacity(500)
        self.assertEqual(self.pipette.capacity_ul, 500)
        self.assertEqual(self.pipette.capacity_ml, 0.5)

        # Reset the capacity
        self.pipette.set_capacity(200)

        # Test setting negative capacity
        with self.assertRaises(ValueError):
            self.pipette.set_capacity(-100)

    def test_update_contents(self):
        """
        Test updating the contents of the pipette.
        """
        time.sleep(1)
        self.pipette.update_contents("Solution A", 200)
        self.assertEqual(self.pipette.contents["Solution A"], 200)

        # Test negative content change
        self.pipette.update_contents("Solution A", -50)
        self.assertEqual(self.pipette.contents["Solution A"], 150)

    def test_volume(self):
        """
        Test setting and getting the volume of the pipette.
        """
        time.sleep(1)
        self.pipette.volume = 300
        self.assertEqual(self.pipette.volume, 300)

        # Test setting negative volume
        with self.assertRaises(ValueError):
            self.pipette.volume = -100

    def test_volume_ml(self):
        """
        Test setting and getting the volume of the pipette in ml.
        """
        time.sleep(1)
        self.pipette.volume_ml = 0.5
        self.assertEqual(self.pipette.volume_ml, 0.5)

        # Test setting negative volume in ml
        with self.assertRaises(ValueError):
            self.pipette.volume_ml = -0.2

    def test_liquid_volume(self):
        """
        Test getting the volume of liquid in the pipette.
        """
        time.sleep(1)
        self.pipette.update_contents("Solution A", 200)
        self.pipette.update_contents("Solution B", 150)
        self.assertEqual(self.pipette.liquid_volume(), 350)

    def test_reset_contents(self):
        """
        Test resetting the contents of the pipette.
        """
        time.sleep(1)
        self.pipette.update_contents("Solution A", 200)
        self.pipette.reset_contents()
        self.assertEqual(self.pipette.contents, {})
        self.assertEqual(self.pipette.volume, 0)
        self.assertEqual(self.pipette.volume_ml, 0)


if __name__ == "__main__":
    unittest.main()
