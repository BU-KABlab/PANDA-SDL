import unittest
from panda_lib.utilities import solve_vials_ilp, Coordinates

class TestUtilities(unittest.TestCase):

    def test_solve_vials_ilp(self):
        # Test case 1
        vial_concentrations = [1.0, 2.0, 3.0]
        v_total = 100.0
        c_target = 2.5
        expected_volumes = [50.0, 0.0, 50.0]
        expected_deviation = 0.0

        volumes, deviation = solve_vials_ilp(vial_concentrations, v_total, c_target)

        self.assertEqual(volumes, expected_volumes)
        self.assertEqual(deviation, expected_deviation)

        # Test case 2
        vial_concentrations = [0.5, 1.0, 1.5, 2.0]
        v_total = 200.0
        c_target = 1.25
        expected_volumes = [100.0, 0.0, 0.0, 100.0]
        expected_deviation = 0.0

        volumes, deviation = solve_vials_ilp(vial_concentrations, v_total, c_target)

        self.assertEqual(volumes, expected_volumes)
        self.assertEqual(deviation, expected_deviation)

    def test_coordinates(self):
        # Test case 1
        x = 1.23
        y = 4.56
        z = 7.89
        coordinates = Coordinates(x, y, z)

        self.assertEqual(coordinates.x, x)
        self.assertEqual(coordinates.y, y)
        self.assertEqual(coordinates.z, z)

        # Test case 2
        x = "1.23"
        y = "4.56"
        z = "7.89"
        coordinates = Coordinates(x, y, z)

        self.assertEqual(coordinates.x, 1.23)
        self.assertEqual(coordinates.y, 4.56)
        self.assertEqual(coordinates.z, 7.89)

        # Test case 3
        # Establish a set of coordinates then modify them
        x = 1.23
        y = 4.56
        z = 7.89
        coordinates = Coordinates(x, y, z)

        new_x = 9.87
        new_y = 6.54
        new_z = 3.21
        coordinates.x = new_x
        coordinates.y = new_y
        coordinates.z = new_z

        self.assertEqual(coordinates.x, new_x)
        self.assertEqual(coordinates.y, new_y)
        self.assertEqual(coordinates.z, new_z)

if __name__ == "__main__":
    unittest.main()