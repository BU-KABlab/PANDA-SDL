import unittest
from decimal import Decimal
from unittest.mock import patch

from panda_lib.vials import (
    StockVial,
    VesselCoordinates,
    WasteVial,
    get_current_vials,
    read_vials,
)


class TestReadVials(unittest.TestCase):

    @patch("epanda_lib.vials.get_current_vials")
    def test_read_vials(self, mock_get_current_vials):
        # Mock the return value of get_current_vials
        mock_get_current_vials.return_value = [
            {
                "name": "Stock Vial 1",
                "position": "A1",
                "volume": 1000.0,
                "capacity": 20.0,
                "density": 1.0,
                "vial_coordinates": {"x": 0, "y": 0, "z_top": 0},
                "radius": 5.0,
                "height": 10.0,
                "contamination": 0,
                "contents": "Solution A",
                "viscosity_cp": 0.5,
                "category": 0,
                "concentration": 0.5,
            },
            {
                "name": "Waste Vial 1",
                "position": "B1",
                "volume": 500.0,
                "capacity": 10.0,
                "density": 0.5,
                "vial_coordinates": {"x": 0, "y": 0, "z_top": 0},
                "radius": 5.0,
                "height": 10.0,
                "contamination": 0,
                "contents": "Waste Solution",
                "viscosity_cp": 0.2,
                "category": 1,
                "concentration": 0.3,
            },
        ]

        # Call the read_vials function
        stock_vials, waste_vials = read_vials()

        # Check the types of the returned vials
        self.assertIsInstance(stock_vials, list)
        self.assertIsInstance(waste_vials, list)

        # Check the length of the returned vials
        self.assertEqual(len(stock_vials), 1)
        self.assertEqual(len(waste_vials), 1)

        # Check the attributes of the stock vial
        stock_vial = stock_vials[0]
        self.assertIsInstance(stock_vial, StockVial)
        self.assertEqual(stock_vial.name, "stock vial 1")
        self.assertEqual(stock_vial.position, "A1")
        self.assertEqual(stock_vial.volume, 1000.0)
        self.assertEqual(stock_vial.capacity, 20.0)
        self.assertEqual(stock_vial.density, 1.0)
        self.assertEqual(stock_vial.radius, 5.0)
        self.assertEqual(stock_vial.height, 10.0)
        self.assertEqual(stock_vial.contamination, 0)
        self.assertEqual(stock_vial.contents, "Solution A")
        self.assertEqual(stock_vial.viscosity_cp, 0.5)
        self.assertEqual(stock_vial.category, 0)
        self.assertEqual(stock_vial.depth, 10.7324)
        self.assertEqual(stock_vial.concentration, 0.5)

        # Check the attributes of the waste vial
        waste_vial = waste_vials[0]
        self.assertIsInstance(waste_vial, WasteVial)
        self.assertEqual(waste_vial.name, "waste vial 1")
        self.assertEqual(waste_vial.position, "B1")
        self.assertEqual(waste_vial.volume, 500.0)
        self.assertEqual(waste_vial.capacity, 10.0)
        self.assertEqual(waste_vial.density, 0.5)
        self.assertEqual(waste_vial.radius, 5.0)
        self.assertEqual(waste_vial.height, 10.0)
        self.assertEqual(waste_vial.contamination, 0)
        self.assertEqual(waste_vial.contents, "Waste Solution")
        self.assertEqual(waste_vial.viscosity_cp, 0.2)
        self.assertEqual(waste_vial.category, 1)
        self.assertEqual(waste_vial.depth, 4.3662)
        self.assertEqual(waste_vial.concentration, 0.3)

    def test_get_current_vials(self):
        # Test the get_current_vials function
        self.maxDiff = None
        expected_vials = [
            {
                "position": "e1",
                "contents": "electrolyte",
                "viscosity_cp": 0.9,
                "concentration": 1,
                "density": 0.99714,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -50,
                "name": "electrode_bath",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-409.0, y=-34.4, z_top=7.0, z_bottom=-50.0
                ),
            },
            {
                "position": "s0",
                "contents": "none",
                "viscosity_cp": 0.91,
                "concentration": 0,
                "density": 0.99714,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-39.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "s1",
                "contents": "liclo4",
                "viscosity_cp": 0.9,
                "concentration": 1,
                "density": 0.99714,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "liclo4",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-72.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "s2",
                "contents": "edot",
                "viscosity_cp": 0.91,
                "concentration": 0.1,
                "density": 0.99714,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "edot",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-105.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "s3",
                "contents": "edot",
                "viscosity_cp": 0.91,
                "concentration": 0.01,
                "density": 0.99714,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "edot",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-138.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "s4",
                "contents": "edot",
                "viscosity_cp": 0.91,
                "concentration": 0.03,
                "density": 0.99714,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "edot",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-171.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "s5",
                "contents": "rinse",
                "viscosity_cp": 0.91,
                "concentration": 1,
                "density": 1.1545,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "rinse",
                "volume": 19580,
                "capacity": 20000,
                "contamination": 3,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-204.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "s6",
                "contents": "rinse",
                "viscosity_cp": 0.91,
                "concentration": 1,
                "density": 1.1945,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "rinse",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-237.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "s7",
                "contents": "none",
                "viscosity_cp": 0.91,
                "concentration": 1,
                "density": 1.1545,
                "category": 0,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "",
                "volume": 20000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-4.0, y=-270.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w0",
                "contents": {
                    "rinse": 14201.7,
                    "edot": 1792.984,
                    "liclo4": 1684.8648,
                    "test_contents": 0.0,
                },
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "waste",
                "volume": 1280,
                "capacity": 20000,
                "contamination": 2,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-7.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w1",
                "contents": {},
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "waste",
                "volume": 1000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-40.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w2",
                "contents": {},
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "waste",
                "volume": 1000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-73.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w3",
                "contents": {},
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "waste",
                "volume": 1000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-106.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w4",
                "contents": {},
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "",
                "volume": 1000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-139.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w5",
                "contents": {},
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "",
                "volume": 1000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-172.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w6",
                "contents": {},
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "",
                "volume": 1000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-205.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
            {
                "position": "w7",
                "contents": {},
                "viscosity_cp": 0,
                "concentration": 0,
                "density": 0,
                "category": 1,
                "radius": 14,
                "height": 57,
                "depth": -74,
                "name": "",
                "volume": 1000,
                "capacity": 20000,
                "contamination": 0,
                "vial_coordinates": VesselCoordinates(
                    x=-50.0, y=-238.0, z_top=-17.0, z_bottom=-74.0
                ),
            },
        ]

        actual_vials = get_current_vials()
        for expected_vial in expected_vials:
            found = False
            for actual_vial in actual_vials:
                if expected_vial["position"] == actual_vial["position"]:
                    self.assertDictAlmostEqual(expected_vial, actual_vial)
                    found = True
                    break
            if not found:
                self.fail(
                    f"Expected vial with position '{expected_vial['position']}' not found in actual vials."
                )

    def assertDictAlmostEqual(self, d1, d2, msg=None):
        for k, v1 in d1.items():
            self.assertIn(k, d2, msg)
            v2 = d2[k]
            if isinstance(v1, Decimal) or isinstance(v2, Decimal):
                self.assertAlmostEqual(float(v1), float(v2), msg=msg)
            else:
                if isinstance(v1, str):
                    if v1 == "none":
                        v1 = None
                    if v1 == "":
                        v1 = None

                if isinstance(v2, str):
                    if v2 == "none":
                        v2 = None
                    if v2 == "":
                        v2 = None

                self.assertEqual(v1, v2, msg=msg)


if __name__ == "__main__":
    unittest.main()
