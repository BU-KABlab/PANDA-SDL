"""Test the vials module"""
import unittest
from panda_lib.vials import Vial2, OverFillException, OverDraftException, Vessel

class TestVessel(unittest.TestCase):
    """Test class for Vessel"""
    def setUp(self):
        self.vessel = Vessel(name="Test Vessel", volume=50.0, 
                             capacity=100.0, density=1.0, coordinates={},
                             contents={}
                             )

    def test_update_volume_positive(self):
        """Test the update_volume method with a positive value"""
        self.vessel.update_volume(30.0)
        self.assertEqual(self.vessel.volume, 80.0)

    def test_update_volume_negative(self):
        """Test the update_volume method with a negative value"""
        with self.assertRaises(OverDraftException):
            self.vessel.update_volume(-60.0)

    def test_update_volume_over_capacity(self):
        """Test the update_volume method with a value over capacity"""
        with self.assertRaises(OverFillException):
            self.vessel.update_volume(60.0)

    def test_str_representation(self):
        """Test the __str__ method
        """
        expected_str = "Test Vessel has 50.0 ul of 1.0 g/ml liquid"
        self.assertEqual(str(self.vessel), expected_str)

class TestVial2(unittest.TestCase):
    """Test class for Vial2"""

    def setUp(self):
        """Set up a Vial2 object for testing"""
        self.vial = Vial2(
            name="Test Vial",
            position = 'S0',
            category=0,
            volume=20000.0,
            capacity=20000.0,
            density=1.5,
            coordinates={},
            radius=10.83,
            height=55.0,
            z_bottom=-75.0,
            contents={},
            contamination=0,
        )

    def test_calculate_depth(self):
        """Test the calculate_depth method"""
        depth = self.vial.calculate_depth()
        self.assertAlmostEqual(depth, self.vial.z_bottom + 53.277,2)

    def test_check_volume_positive(self):
        """Test the check_volume method with a positive value"""
        result = self.vial.check_volume(100.0)
        self.assertTrue(result)

    def test_check_volume_over_capacity(self):
        """Test the check_volume method with a value over capacity"""
        with self.assertRaises(OverFillException):
            self.vial.check_volume(2000.0)

    def test_check_volume_negative_overdraft(self):
        """Test the check_volume method with a negative value over draft"""
        with self.assertRaises(OverDraftException):
            self.vial.check_volume(-20000.0)

    def test_update_volume_positive(self):
        """Test the update_volume method with a positive value"""
        self.vial.update_volume(-50.0)
        self.assertEqual(self.vial.volume, 18950.0)
        self.assertEqual(self.vial.depth, self.vial.z_bottom -1 + 51.428)
        self.assertEqual(self.vial.contamination, 1)

    def test_update_volume_negative_overdraft(self):
        """Test the update_volume method with a negative value over draft"""
        with self.assertRaises(OverDraftException):
            self.vial.update_volume(-19001.0)

    def test_update_volume_negative_over_capacity(self):
        """Test the update_volume method with a value over capacity"""
        with self.assertRaises(OverFillException):
            self.vial.update_volume(2000.0)

    def test_write_volume_to_disk(self):
        """Test the write_volume_to_disk method"""
        # Assuming the method doesn't raise any errors
        #self.vial.write_volume_to_disk()

    def test_update_contamination(self):
        """Test the update_contamination method"""
        self.vial.update_contamination()
        self.assertEqual(self.vial.contamination, 1)

    def test_update_contamination_with_value(self):
        """Test the update_contamination method with a new value"""
        self.vial.update_contamination(new_contamination=5)
        self.assertEqual(self.vial.contamination, 5)

if __name__ == '__main__':
    unittest.main()
