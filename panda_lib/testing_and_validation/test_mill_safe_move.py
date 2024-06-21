import unittest


def should_move_to_zero_first(
    current_x,
    current_y,
    current_z,
    offset_x_coord,
    offset_y_coord,
    offset_z_coord,
    safe_floor_height,
):
    if offset_z_coord not in (0, current_z):
        if current_z == 0:
            # Expecting False because Z is already at 0
            return False
        elif current_x != offset_x_coord and current_y != offset_y_coord:
            # Expecting True because Z is changing, X and Y are changing
            return current_z < safe_floor_height
        elif current_x == offset_x_coord and current_y == offset_y_coord:
            # Expecting False because Z is changing, but X and Y are not changing
            return False
    else:  # offset_z_coord is 0 or current_z
        # If Z is already at 0, expect False
        if current_z == 0:
            return False
        # If Z is at or above the safe floor height, expect False
        elif current_z >= safe_floor_height:
            return False
        # If Z is below the safe floor height, expect True if X and Y are changing
        elif current_z < safe_floor_height:
            return current_x != offset_x_coord and current_y != offset_y_coord


class TestMillControllerLogic(unittest.TestCase):

    def test_should_move_to_zero_first(self):
        # Test case 1
        self.assertTrue(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=4,
                offset_x_coord=3,
                offset_y_coord=4,
                offset_z_coord=6,
                safe_floor_height=10,
            )
        )
        # Z is changing, X and Y are changing, and current Z is below safe floor height, expect True

        # Test case 2
        self.assertFalse(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=5,
                offset_x_coord=1,
                offset_y_coord=2,
                offset_z_coord=6,
                safe_floor_height=10,
            )
        )
        # Z is changing, but X and Y are not changing, expect False

        # Test case 3
        self.assertFalse(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=0,
                offset_x_coord=3,
                offset_y_coord=4,
                offset_z_coord=0,
                safe_floor_height=10,
            )
        )
        # Z is already at 0, expect False

        # Test case 4
        self.assertFalse(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=5,
                offset_x_coord=3,
                offset_y_coord=4,
                offset_z_coord=6,
                safe_floor_height=5,
            )
        )
        # Z is changing, X and Y are changing, and current Z is exactly at the safe floor height, expect False

        # Test case 5
        self.assertFalse(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=4,
                offset_x_coord=1,
                offset_y_coord=2,
                offset_z_coord=6,
                safe_floor_height=5,
            )
        )
        # Z is changing, but X and Y are not changing, and current Z is below the safe floor height, expect False

        # Test case 6
        self.assertFalse(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=0,
                offset_x_coord=3,
                offset_y_coord=4,
                offset_z_coord=6,
                safe_floor_height=5,
            )
        )
        # Target Z is not at 0, X and Y are changing, but current Z is already at 0, expect False

        # Test case 7
        self.assertTrue(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=5,
                offset_x_coord=3,
                offset_y_coord=4,
                offset_z_coord=0,
                safe_floor_height=10,
            )
        )
        # Current Z is not at 0, X and Y are changing, and target Z is 0, expect True

        # Test case 8
        self.assertFalse(
            should_move_to_zero_first(
                current_x=1,
                current_y=2,
                current_z=0,
                offset_x_coord=3,
                offset_y_coord=4,
                offset_z_coord=0,
                safe_floor_height=10,
            )
        )
        # Z is already at 0, but X and Y are changing, expect false


if __name__ == "__main__":
    unittest.main()
