import logging
from datetime import datetime
from pathlib import Path
from typing import Sequence

from panda_lib.config.config import (PATH_TO_DATA, PATH_TO_LOGS)
from panda_lib.actions import capture_new_image
from panda_lib.mill_control import (CommandExecutionError, Instruments,
                           LocationNotFound, Mill, MillConfigError,
                           MillConfigNotFound, MillConnectionError, MockMill,
                           StatusReturnError, logger)
from panda_lib.vials import StockVial, WasteVial, read_vials
from panda_lib.wellplate import Well, Wellplate


def wellplate_scan(mill_arg: Mill = None, capture_images=False):
    """Scan the wellplate"""
    # Perform image scan of each well of the wellplate
    wellplate = Wellplate()
    if mill_arg is None:
        mill = Mill()
    else:
        mill = mill_arg
    with mill:
        for well in wellplate.wells.values():
            well: Well = well
            print("Currently imaging: {well.name}", end="\r")
            well_coordinates = well.coordinates
            mill.safe_move(
                well_coordinates["x"],
                well_coordinates["y"],
                wellplate.image_height,
                instrument=Instruments.LENS,
            )
            if capture_images:
                # create a folder in data folder with the wellplate id
                folder = Path(f"{PATH_TO_DATA}/{wellplate.plate_id}")
                folder.mkdir(parents=True, exist_ok=True)

                # capture each image with file name as the date and the well name
                file_name = f"{datetime.now().strftime('%Y %m %d')}-{well.name}.png"
                capture_new_image(file_name=folder / file_name)
        if mill_arg is None:
            mill.rest_electrode()


def move_pipette_to_each_corner(mill: Mill, well1, well2, well3, well4, z_top):
    """Move the pipette to each corner of the wellplate"""
    mill.safe_move(well1["x"], well1["y"], z_top, instrument=Instruments.PIPETTE)
    mill.safe_move(well2["x"], well2["y"], z_top, instrument=Instruments.PIPETTE)
    mill.safe_move(well3["x"], well3["y"], z_top, instrument=Instruments.PIPETTE)
    mill.safe_move(well4["x"], well4["y"], z_top, instrument=Instruments.PIPETTE)


def move_electrode_to_each_corner(
    mill: Mill, well1, well2, well3, well4, z_top, echem_height
):
    """Move the electrode to each corner of the wellplate"""
    mill.safe_move(well1["x"], well1["y"], z_top, instrument=Instruments.ELECTRODE)
    mill.safe_move(well2["x"], well2["y"], z_top, instrument=Instruments.ELECTRODE)
    mill.safe_move(well3["x"], well3["y"], z_top, instrument=Instruments.ELECTRODE)
    mill.safe_move(well4["x"], well4["y"], z_top, instrument=Instruments.ELECTRODE)

    repsonse = input("Move the electrode to the echem height? y/n: ")
    if repsonse.lower() == "y":
        mill.safe_move(
            well1["x"], well1["y"], echem_height, instrument=Instruments.ELECTRODE
        )
        mill.safe_move(
            well2["x"], well2["y"], echem_height, instrument=Instruments.ELECTRODE
        )
        mill.safe_move(
            well3["x"], well3["y"], echem_height, instrument=Instruments.ELECTRODE
        )
        mill.safe_move(
            well4["x"], well4["y"], echem_height, instrument=Instruments.ELECTRODE
        )


def move_lens_to_each_corner(mill: Mill, image_height, well1, well2, well3, well4):
    """Move the lens to each corner of the wellplate"""
    mill.safe_move(well1["x"], well1["y"], image_height, instrument=Instruments.LENS)
    mill.safe_move(well2["x"], well2["y"], image_height, instrument=Instruments.LENS)
    mill.safe_move(well3["x"], well3["y"], image_height, instrument=Instruments.LENS)
    mill.safe_move(well4["x"], well4["y"], image_height, instrument=Instruments.LENS)


def move_to_vials(mill: Mill, stock_vials, waste_vials):
    """Move the mill to the stock and waste vials"""
    if len(stock_vials) != 0:
        for _, stock_vial in enumerate(stock_vials):
            stock_vial: StockVial
            if stock_vial.position == "e1":
                continue
            mill.safe_move(
                stock_vial.coordinates["x"],
                stock_vial.coordinates["y"],
                stock_vial.z_top,
                instrument=Instruments.PIPETTE,
            )
        mill.move_to_safe_position()

    if len(waste_vials) != 0:
        for _, waste_vial in enumerate(waste_vials):
            waste_vial: WasteVial
            mill.safe_move(
                waste_vial.coordinates["x"],
                waste_vial.coordinates["y"],
                waste_vial.z_top,
                instrument=Instruments.PIPETTE,
            )
        mill.move_to_safe_position()


def movement_test(mill: Mill):
    """Test the mill movement with a wellplate"""
    wellplate = Wellplate()

    # Configure the logger for testing
    test_logger = logging.getLogger(__name__)
    test_logger.setLevel(logging.DEBUG)  # Change to INFO to reduce verbosity
    testing_formatter = logging.Formatter(
        "%(asctime)s:%(name)s:%(levelname)s:%(message)s"
    )
    testing_handler = logging.FileHandler(PATH_TO_LOGS / "mill_control_testing.log")
    testing_handler.setFormatter(testing_formatter)
    test_logger.addHandler(testing_handler)

    try:
        with mill:
            well1 = wellplate.get_coordinates("g2")
            well2 = wellplate.get_coordinates("g3")
            well3 = wellplate.get_coordinates("g4")
            well4 = wellplate.get_coordinates("g5")
            well5 = wellplate.get_coordinates("g6")
            well6 = wellplate.get_coordinates("g10")
            well7 = wellplate.get_coordinates("f2")
            well8 = wellplate.get_coordinates("f3")
            well9 = wellplate.get_coordinates("f4")
            well10 = wellplate.get_coordinates("f5")
            well11 = wellplate.get_coordinates("f6")
            well12 = wellplate.get_coordinates("d3")
            well13 = wellplate.get_coordinates("d4")
            well14 = wellplate.get_coordinates("d5")
            well15 = wellplate.get_coordinates("b9")

            ## Load the vials
            stock_vials: Sequence[StockVial] = read_vials()[0]
            waste_vials: Sequence[WasteVial] = read_vials()[1]

            # mill.safe_move(well1["x"], well1["y"], wellplate.z_top, instrument=Instruments.PIPETTE)
            input(
                "Begin the movement test to each corner of the wellplate. Press enter to continue..."
            )

            if (
                input("Do you want to move the pipette to each corner? (y/n): ").lower()
                == "y"
            ):
                move_pipette_to_each_corner(
                    mill, well1, well2, well3, well4, wellplate.z_top
                )

            if (
                input(
                    "Do you want to move the electrode to each corner? (y/n): "
                ).lower()
                == "y"
            ):
                move_electrode_to_each_corner(
                    mill,
                    well1,
                    well2,
                    well3,
                    well4,
                    wellplate.z_top,
                    wellplate.echem_height,
                )

            if (
                input("Do you want to move the lens to each corner? (y/n): ").lower()
                == "y"
            ):
                move_lens_to_each_corner(
                    mill, wellplate.image_height, well1, well2, well3, well4
                )

            if input("Do you want to move to the vials? (y/n): ").lower() == "y":
                move_to_vials(mill, stock_vials, waste_vials)

            mill.move_to_safe_position()
            mill.rest_electrode()

    except (
        MillConnectionError,
        MillConfigNotFound,
        MillConfigError,
        CommandExecutionError,
        StatusReturnError,
        LocationNotFound,
    ) as error:
        logger.error("Error occurred: %s", error)
        # Handle the error gracefully, e.g., print a message or perform cleanup

    finally:
        logger.info("Exiting program.")


def only_z_move_test(mill: Mill):
    """Test the mill movement concerning the z axis with a wellplate"""
    wellplate = Wellplate()

    # Configure the logger for testing
    test_logger = logging.getLogger(__name__)
    test_logger.setLevel(logging.DEBUG)  # Change to INFO to reduce verbosity
    test_formatter = logging.Formatter("%(asctime)s:%(name)s:%(levelname)s:%(message)s")
    testing_handler = logging.FileHandler(PATH_TO_LOGS / "mill_control_testing.log")
    testing_handler.setFormatter(test_formatter)
    test_logger.addHandler(testing_handler)

    try:
        with mill:
            a1 = wellplate.get_coordinates("A1")
            a12 = wellplate.get_coordinates("A12")
            ## Load the vials

            stock_vials: Sequence[StockVial] = read_vials()[0]
            waste_vials: Sequence[WasteVial] = read_vials()[1]

            mill.safe_move(a1["x"], a1["y"], -40, instrument=Instruments.PIPETTE)
            mill.safe_move(
                a1["x"], a1["y"], wellplate.z_top, instrument=Instruments.PIPETTE
            )

            mill.safe_move(a12["x"], a12["y"], -40, instrument=Instruments.PIPETTE)
            mill.safe_move(
                stock_vials[0].coordinates["x"],
                stock_vials[0].coordinates["y"],
                stock_vials[0].z_top,
                instrument=Instruments.PIPETTE,
            )

            mill.safe_move(
                waste_vials[0].coordinates["x"],
                waste_vials[0].coordinates["y"],
                waste_vials[0].z_top,
                instrument=Instruments.PIPETTE,
            )

    except (
        MillConnectionError,
        MillConfigNotFound,
        MillConfigError,
        CommandExecutionError,
        StatusReturnError,
        LocationNotFound,
    ) as error:
        logger.error("Error occurred: %s", error)
        # Handle the error gracefully, e.g., print a message or perform cleanup

    finally:
        logger.info("Exiting program.")


if __name__ == "__main__":
    TESTING = False
    if TESTING:
        mill_to_use = MockMill()
    else:
        mill_to_use = Mill()

    def menu():
        """A menu for the mill testing functions."""
        print("Welcome to the Mill Control Menu!")
        print("1. Run movement test")
        print("2. Run wellplate scan")
        print(
            "3. Start mill and use debugger via breakpoint. Move to safe position and rest electrode after testing."
        )
        print("4. Only Z move test")
        print("0. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            movement_test(mill_to_use)
        elif choice == "2":
            take_picture = input("Do you want to take pictures? (y/n): ")
            if take_picture.lower() == "y":
                wellplate_scan(mill_to_use, capture_images=True)
            else:
                wellplate_scan(mill_to_use, capture_images=False)
        elif choice == "3":
            with mill_to_use:
                mill_to_use.move_to_safe_position()
                mill_to_use.rest_electrode()
        elif choice == "4":
            only_z_move_test(mill_to_use)
        elif choice == "0":
            print("Exiting...")
            return
        else:
            print("Invalid choice. Please try again.")

        # Recursive call to keep the menu running
        menu()

    if __name__ == "__main__":
        menu()
