"""
This module contains functions for calibrating and positioning a mill, wellplate, and vials.

The functions in this module allow the user to:
 - check and change mill settings
 - calibrate the locations of individual wells in a wellplate
 - calibrate the z_bottom of the wellplate to the mill
 
The module relies on other modules such as:
    - `mill_control`
    - `utilities`
    - `vials`
    - `wellplate`
    - `config`
"""
#pylint: disable=unused-argument
import json
import os
import platform
from typing import Sequence

from panda_lib.experiment_class import ExperimentResultsRecord, insert_experiment_result

from .actions import capture_new_image, image_filepath_generator
from .mill_control import Mill, MockMill
from .utilities import Instruments
from .vials import StockVial, WasteVial
from .wellplate import Well, WellCoordinates, Wellplate


def check_mill_settings(mill: Mill, *args, **kwargs):
    """
    Fetch the settings list from the grbl controller and compare to the settings file.
    If there are differences, ask the user if they would like to change the settings.
    If so, ask for the settings to change and the new value.
    Update the settings file and send the new setting to the mill.
    Confirm the setting has been applied and save the settings file.
    Repeat until the user is satisfied.
    """

    while True:
        response = mill.execute_command("$$")  # Get settings
        # print(response)

        ## Check settings
        # Load settings from config and compare to current settings
        settings: dict = mill.config["settings"]
        # List out settings and note any differences.
        for setting in settings:
            if settings[setting] != int(response[setting]):
                print(
                    f"Setting {setting:<4} | Current: {response[setting]:<10}, Config: {settings[setting]:<5}"
                )
            else:
                print(f"Setting {setting:<4} | Current: {response[setting]:<10}")

        # Ask if user wants to change settings
        change_settings = input("Would you like to change any settings? (y/n): ")
        if change_settings.lower() != "y":
            break

        while True:
            # Ask for settings to change
            setting_to_change = input("Enter the setting you would like to change: ")
            if setting_to_change not in settings:
                print("Setting not found")
                continue
            # Ask for the new value
            new_value = input(f"Enter the new value for {setting_to_change}: ")
            # Update loaded settings file
            settings[setting_to_change] = new_value

            change_settings = input(
                "Would you like to change any other settings? (y/n): "
            )
            if change_settings.lower() != "y":
                break

        # Send the new setting to the mill
        for setting in settings:
            mill.execute_command(f"{setting}={settings[setting]}")
        # Confirm setting has been applied
        response = mill.execute_command("$$")  # Get settings
        if response == settings:
            print("Settings have been applied")
            # Save the settings file
            with open(mill.config_file, "w", encoding="utf-8") as f:
                json.dump(mill.config, f)
            break
        else:
            print("Settings have not been applied")


def calibrate_wells(mill: Mill, wellplate: Wellplate, *args, **kwargs):
    """
    Calibrate the locations of the individual wells in the wellplate using either
    the pipette or the electrode.
    This will set the x and y coordinates of ONLY the selected wells, leaving
    the rest unchanged, unless the user chooses to recalculate all well locations.
    This is useful for when a single well is off and needs to be corrected.

    Args:
        mill (Mill)
        wellplate (Wellplate)

    """
    # Enter well choice loop
    instrument = Instruments.PIPETTE
    while True:
        coordinates_changed = False
        well_id = input(
            "Enter the well ID to test (e.g., A1) toggle to switch to electrode or done to end: "
        ).lower()
        if well_id == "done":
            break

        if well_id == "toggle":
            instrument = (
                Instruments.ELECTRODE
                if instrument == Instruments.PIPETTE
                else Instruments.PIPETTE
            )
            print(f"Instrument has been toggled to {instrument}")
            well_id = input("Enter the well ID to test (e.g., A1): ").lower()

        # Provide the current coordinates of the well
        original_coordinates = wellplate.get_coordinates(well_id)
        print(f"Current coordinates of {well_id}: {original_coordinates}")

        # Move the pipette to the top of the well
        mill.safe_move(
            original_coordinates["x"],
            original_coordinates["y"],
            wellplate.z_top,
            instrument,
        )

        # Enter confirmation loop
        while True:
            current_coorinates = WellCoordinates(
                original_coordinates["x"],
                original_coordinates["y"],
                z_top=wellplate.z_top,
            )
            instrument: Instruments
            confirm = input(
                f"Is the {(instrument.value)}  in the correct position? (yes/no): "
            )
            if confirm is None or confirm.lower().strip()[0] in ["y", ""]:
                break  # exit confirmation loop go to updating coordinates if changed
            print(
                f"Current coordinates of {well_id}: {current_coorinates}"
            )  # change to be the corrected coordinates if they have been changed
            coordinates_changed = True
            # gather new coordinates and test them for validity before trying to set them
            # enter validation loop
            while True:
                new_x = input(
                    f"Enter the new X coordinate for {well_id} or enter for no change: "
                )
                new_y = input(
                    f"Enter the new Y coordinate for {well_id} or enter for no change: "
                )

                if new_x == "":
                    new_x = original_coordinates["x"]
                if new_y == "":
                    new_y = original_coordinates["y"]
                try:
                    new_x = float(new_x)
                    new_y = float(new_y)
                except ValueError:
                    print("Invalid input, please try again")
                    continue

                working_volume = mill.config["working_volume"]
                if new_x > 0 or new_x < working_volume["x"]:
                    print(
                        f"Invalid x coordinate, must be between 0 and {working_volume['x']}"
                    )
                    continue
                if new_y > 0 or new_y < working_volume["y"]:
                    print(
                        f"Invalid y coordinate, must be between 0 and {working_volume['y']}"
                    )
                    continue
                break  # exit validation loop

            new_coordinates = WellCoordinates(
                new_x,
                new_y,
                z_top=wellplate.z_top,
            )

            # Safe move to the new coordinates
            mill.safe_move(
                new_coordinates.x,
                new_coordinates.y,
                wellplate.z_top,
                instrument,
            )

        if coordinates_changed:
            if well_id.upper() == "A1":
                recalc = input(
                    "Would you like to recalculate all well locations? (y/n): "
                )
                if recalc[0].lower() == "y":
                    wellplate.a1_x = new_coordinates.x
                    wellplate.a1_y = new_coordinates.y
                    wellplate.write_wellplate_location()  # json file for wellplate location
                    wellplate.recalculate_well_locations()  # Update wells with new coords and depth
            else:  # Update the well with new well coordinates
                wellplate.update_well_coordinates(well_id, new_coordinates)


def calibrate_z_bottom_of_wellplate(mill: Mill, wellplate: Wellplate, *args, **kwargs):
    """Calibrate the z_bottom of the wellplate to the mill"""
    # Enter confirmation loop
    # Ask the user to enter a well id to check the z_bottom or to enter "done" to finish
    # Ask the user to confirm the pipette is in the correct position
    # If the user confirms, do nothing
    # If the user does not confirm, ask the user to input the new z_bottom
    # Safe Move to the new z_bottom
    # Repeat until the user confirms the position
    # Save the new z_bottom to the wellplate object
    # Repeat until the user enters "done"
    while True:
        well_id = (
            input("Enter a well ID to check the z_bottom or 'done' to finish: ")
            .upper()
            .strip()
        )
        if well_id == "DONE":
            break

        current_z_bottom = wellplate.z_bottom
        print(f"Current z_bottom of {well_id}: {current_z_bottom}")

        mill.safe_move(
            wellplate.get_coordinates(well_id, "x"),
            wellplate.get_coordinates(well_id, "y"),
            current_z_bottom,
            Instruments.PIPETTE,
        )

        while True:
            confirm = (
                input("Is the pipette in the correct position? (yes/no): ")
                .lower()
                .strip()[0]
            )
            if confirm.lower() in ["y", ""]:
                break

            new_z_bottom = float(
                input(
                    f"Enter the new z_bottom for {well_id} (current: {current_z_bottom}): "
                )
            )

            mill.safe_move(
                wellplate.get_coordinates(well_id, "x"),
                wellplate.get_coordinates(well_id, "y"),
                new_z_bottom,
                Instruments.PIPETTE,
            )

        wellplate.z_bottom = new_z_bottom
        for well in wellplate.wells:
            well: Well
            well.depth = new_z_bottom
            # We do this instead of recalculating every well location incase
            # they are uniquely set
        wellplate.write_wellplate_location()


def calibrate_vials(
    mill: Mill,
    wellplate: Wellplate,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """Calibrate the vials to the mill"""
    # Enter vial choice loop
    # ask the user for the vial position they would like to test, must be in the form of [vV][1-16]
    # Provide the current coordinates of the vial
    # Move the pipette to the top of the vial
    # Enter confirmation loop
    # Ask the user to confirm the pipette is in the correct position
    # If the user confirms, do nothing
    # Else ask the user to input the new coordinates (display current coordinates)
    # Safe Move to the new coordinates
    # Repeat until the user confirms the position
    # Save the new coordinates to the stock vial object
    # Repeat until the user enters "done"
    # Enter vial z_bottom loop
    # Enter confirmation loop
    # Ask the user to enter a vial position to check the z_bottom or to enter "done" to finish
    # Ask the user to confirm the pipette is in the correct position
    # If the user confirms, do nothing
    # If the user does not confirm, ask the user to input the new z_bottom
    # Safe Move to the new z_bottom
    # Repeat until the user confirms the position
    # Save the new z_bottom to the stock vial object

    ## Calibrate the waste vial
    # Same process as the stock vials


def calibrate_camera_focus(mill: Mill, wellplate: Wellplate, *args, **kwargs):
    """Calibrate the camera focus"""
    # Move the camera to the top of the wellplate
    response = input(
        "Camera will move to image_height above A1. Press enter to proceed or 'q' to quit: "
    )
    if response.lower() == "q":
        return
    mill.safe_move(
        wellplate.get_coordinates("A1", "x"),
        wellplate.get_coordinates("A1", "y"),
        0,
        Instruments.LENS,
    )

    # lower to the wellplate's image height
    mill.safe_move(
        wellplate.get_coordinates("A1", "x"),
        wellplate.get_coordinates("A1", "y"),
        wellplate.image_height,
        Instruments.LENS,
    )
    # pause for the user to focus the camera
    input("Focus the camera using FlyCapture2 and press enter to continue")


def capture_well_photo_manually(mill: Mill, wellplate: Wellplate, *args, **kwargs):
    """
    Capture a photo of a well manually

    Asks the user to input the well ID to capture a photo of.
    Also asks for relevant experiment id, project id, campaign id, and context.
    Experiment id is an integer: 1000000 <= experiment_id <= 9999999
    Project id and campaign id are integers.
    Context is one of these strings: 'BeforeDeposition', 'AfterBleaching', 'AfterColoring'

    Future versions will use the experiment id, to look up the project, campaign ids.

    """

    while True:
        well_id = (
            input("Enter the well ID to capture a photo of (e.g., A1): ")
            .upper()
            .strip()
        )
        experiment_id = int(input("Enter the experiment ID: "))
        project_id = int(input("Enter the project ID: "))
        campaign_id = int(input("Enter the campaign ID: "))
        context = input(
            "Enter the context (BeforeDeposition, AfterBleaching, AfterColoring): "
        ).strip()

        # Move the camera to the top of the well
        mill.safe_move(
            wellplate.get_coordinates(well_id, "x"),
            wellplate.get_coordinates(well_id, "y"),
            0,
            Instruments.LENS,
        )

        # lower to the wellplate's image height
        mill.safe_move(
            wellplate.get_coordinates(well_id, "x"),
            wellplate.get_coordinates(well_id, "y"),
            wellplate.image_height,
            Instruments.LENS,
        )
        # pause for the user to focus the camera
        input(
            "Focus the camera using FlyCapture2 if necessary and press enter to continue"
        )

        # Capture the image
        image_path = image_filepath_generator(
            exp_id=experiment_id,
            project_id=project_id,
            project_campaign_id=campaign_id,
            well_id=well_id,
            step_description=context,
        )

        capture_new_image(save=True, num_images=1, file_name=image_path)

        view_image = input("Would you like to view the image? (y/n): ")
        if view_image.lower() == "y":
            if platform.system() == "Windows":
                os.system(f"start {image_path}")
            elif platform.system() == "Darwin":
                os.system(f"open {image_path}")
            elif platform.system() == "Linux":
                os.system(f"xdg-open {image_path}")
            else:
                print("Unsupported OS")

        save_to_db = input("Would you like to save the image to the database? (y/n): ")
        if save_to_db.lower() != "y":
            pass
        else:
            # Save the image path to the database
            insert_experiment_result(
                ExperimentResultsRecord(
                    experiment_id=experiment_id,
                    result_type="image",
                    result_value=str(image_path),
                    context=context,
                )
            )

        to_continue = input("Would you like to capture another image? (y/n): ")
        if to_continue.lower() == "n":
            return  # exit the loop



def home_mill(mill: Mill, *args, **kwargs):
    """Homes the mill"""
    mill.home()
    print("Mill has been homed")


def quit_calibration():
    """Quit the calibration menu"""
    print("Quitting calibration menu")
    return

menu_options = {
    "0": check_mill_settings,
    "1": home_mill,
    "3": calibrate_wells,
    "4": calibrate_z_bottom_of_wellplate,
    # "5": calibrate_vials,
    "6": calibrate_camera_focus,
    "7": capture_well_photo_manually,
    "q": quit_calibration,
}


def calibrate_mill(
    mill: Mill,
    wellplate: Wellplate,
    stock_vials: Sequence[StockVial],
    waste_vials: Sequence[WasteVial],
):
    """Calibrate the mill to the wellplate and stock vials"""
    # Connect to the mill
    with mill() as mill:
        while True:
            # os.system("cls" if os.name == "nt" else "clear")  # Clear the terminal
            print("\n\n")
            print("""\nWelcome to the mill calibration and positioning menu:""")
            for key, value in menu_options.items():
                print(f"{key}. {value.__name__.replace('_', ' ').title()}")
            option = input("Which operation would you like: ")
            if option == "q":
                mill.rest_electrode()
                break
            menu_options[option](mill, wellplate, stock_vials, waste_vials)


def main():
    """Main function for testing the calibration functions"""
    # Load the configuration file
    testing = input("Enter 'y' to use testing configuration: ").lower() == "y"
    if testing == "y":
        testing = True
    else:
        testing = False
    from panda_lib.vials import read_vials
    print("Testing mode:", testing)
    input("Press enter to continue")
    # Create the mill object
    mill_to_use = MockMill()

    # Create the wellplate object
    wellplate_to_use = Wellplate()

    # Create the stock vial objects
    stock_vials_to_use: Sequence[StockVial] = read_vials()[0]
    waste_vials_to_use: Sequence[WasteVial] = read_vials()[1]

    calibrate_mill(
        mill_to_use, wellplate_to_use, stock_vials_to_use, waste_vials_to_use
    )


if __name__ == "__main__":
    main()
