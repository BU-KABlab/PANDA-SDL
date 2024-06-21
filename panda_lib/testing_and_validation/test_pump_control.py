import unittest
import time
import nesp_lib
from panda_lib.syringepump import MockMill, MockPump, MockScale
from panda_lib.vessel import VesselCoordinates

"""_summary_
"""


from panda_lib.vials import (
    StockVial,
    Vial2,
    WasteVial,
    delete_vial_position_and_hx_from_db,
    reset_vials,
)

# pylint: disable=missing-function-docstring, protected-access


class TestSyringePump(unittest.TestCase):

    def setUp(self):
        self.mock_mill = MockMill()
        self.mock_scale = MockScale()
        self.pump = MockPump(mill=self.mock_mill, scale=self.mock_scale)
        self.vial = StockVial(
            name="test",
            position="t0",
            volume=1000,
            capacity=1000,
            density=1.0,
            vial_coordinates=VesselCoordinates(1.0, 2.0, 3.0),
            radius=5.0,
            height=10.0,
            contamination=0,
            contents="test_contents",
        )
        self.waste_vial = WasteVial(
            name="waste",
            position="w99",
            volume=0,
            capacity=1000,
            density=1.0,
            vial_coordinates=VesselCoordinates(1.0, 2.0, 3.0),
            radius=5.0,
            height=10.0,
            contamination=0,
            contents={},
        )

        self.pump.pipette.reset_contents()

        # Check the pipiette is reset
        assert self.pump.pipette.capacity_ul == float(200)
        assert self.pump.pipette.capacity_ml == float(0.2)
        assert self.pump.pipette._volume_ul == float(0)
        assert self.pump.pipette._volume_ml == float(0)
        assert self.pump.pipette.contents == {}

    def test_withdraw(self):

        self.pump.withdraw(100, solution=self.vial, rate=0.5)
        assert self.vial.volume == float(900)
        assert self.vial.contamination == 1
        assert (
            self.pump.pump.pumping_direction.value
            == nesp_lib.PumpingDirection.WITHDRAW.value
        )
        assert self.pump.pump.pumping_rate == 0.5
        assert self.pump.pipette.liquid_volume() == 100

        assert self.pump.pipette._volume_ul == 100
        assert self.pump.pipette._volume_ml == 0.1
        assert self.pump.pipette.contents == {"test_contents": 100}

    def test_withdraw_air(self):

        self.pump.withdraw_air(100)
        assert (
            self.pump.pump.pumping_direction.value
            == nesp_lib.PumpingDirection.WITHDRAW.value
        )
        assert self.pump.pump.pumping_rate == float(0.640)
        assert self.pump.pipette.liquid_volume() == 0
        assert self.pump.pipette._volume_ul == 100
        assert self.pump.pipette._volume_ml == 0.1
        assert self.pump.pipette.contents == {}

    def test_infuse_air(self):

        self.pump.pipette.volume = 100
        self.pump.infuse_air(100)
        assert (
            self.pump.pump.pumping_direction.value
            == nesp_lib.PumpingDirection.INFUSE.value
        )
        assert self.pump.pump.pumping_rate == float(0.640)
        assert self.pump.pipette.liquid_volume() == 0
        assert self.pump.pipette._volume_ul == 0
        assert self.pump.pipette._volume_ml == 0
        assert self.pump.pipette.contents == {}

    def test_infuse(self):

        self.pump.pipette.volume = 100
        self.pump.pipette.contents = {"test_contents": 100}
        self.pump.infuse(
            100,
            being_infused=self.vial,
            infused_into=self.waste_vial,
            rate=0.5,
            blowout_ul=0,
            weigh=False,
        )
        assert self.waste_vial.volume == 100
        assert self.waste_vial.contamination == 1
        assert (
            self.pump.pump.pumping_direction.value
            == nesp_lib.PumpingDirection.INFUSE.value
        )
        assert self.pump.pump.pumping_rate == 0.5
        assert self.pump.pipette.liquid_volume() == 0
        assert self.pump.pipette._volume_ul == 0
        assert self.pump.pipette._volume_ml == 0
        assert self.pump.pipette.contents == {"test_contents": 0} | {
            "test_contents": 0
        }

    def tearDown(self):

        # input("Press Enter to continue with cleanup...")
        self.pump.pipette.reset_contents()
        delete_vial_position_and_hx_from_db("t0")
        delete_vial_position_and_hx_from_db("w99")


def test_order():
    """Run the tests in the order they are defined in the file."""
    suite = unittest.TestSuite()
    suite.addTest(TestSyringePump("test_withdraw"))
    suite.addTest(TestSyringePump("test_withdraw_air"))
    suite.addTest(TestSyringePump("test_infuse_air"))
    suite.addTest(TestSyringePump("test_infuse"))
    return suite

def main():
    """Run the tests."""
    runner = unittest.TextTestRunner()
    runner.run(test_order())
if __name__ == "__main__":
    main()
