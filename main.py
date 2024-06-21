"""
The main menue of ePANDA.

Useful for one-off tasks that don't require the full ePANDA program to run.
Or starting the ePANDA either with or without mock instruments.
"""

# pylint: disable=broad-exception-caught, protected-access
import os
import sys
import time
from pathlib import Path
import dotenv
from PIL import Image

from panda_lib.config.config_tools import read_testing_config, write_testing_config
import panda_lib.analyzer.pedot as pedot_analysis
from panda_lib import (
    flir_camera,
    controller,
    experiment_class,
    mill_calibration_and_positioning,
    mill_control,
    print_panda,
    scheduler,
    utilities,
    vials,
    wellplate,
)
from panda_lib.analyzer.pedot.pedot_classes import MLOutput, PEDOTParams
from panda_lib.sql_tools import (
    sql_generator_utilities,
    sql_protocol_utilities,
    sql_queue,
    sql_system_state,
    remove_testing_experiments
)
from panda_lib.analyzer.pedot import sql_ml_functions

dotenv.load_dotenv()

def run_epanda_with_ml():
    """Runs ePANDA."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "running ePANDA"
    )
    length = int(input("Enter the campaign length: ").strip().lower())
    controller.main(al_campaign_length=length)


def run_epanda_without_ml():
    """Runs ePANDA."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "running ePANDA"
    )
    one_off = input("Is this a one-off run? (y/n): ").strip().lower()
    if one_off[0] == "y":
        controller.main(one_off=True)
    else:
        controller.main()


def genererate_pedot_experiment():
    """Generates a PEDOT experiment."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "generating PEDOT experiment"
    )
    dep_v = float(input("Enter the deposition voltage: ").strip().lower())
    dep_t = float(input("Enter the deposition time: ").strip().lower())
    concentration = float(input("Enter the concentration: ").strip().lower())
    params = PEDOTParams(dep_v=dep_v, dep_t=dep_t, concentration=concentration)
    pedot_analysis.pedot_generator(params=params)


def change_wellplate():
    """Changes the current wellplate."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "changing wellplate"
    )
    wellplate.load_new_wellplate(ask=True)


def remove_wellplate_from_database():
    """Removes the current wellplate from the database."""
    if not read_testing_config():
        print("Cannot remove the wellplate from the database in non-testing mode.")
        return
    plate_to_remove = int(
        input("Enter the wellplate number to remove: ").strip().lower()
    )
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY,
        "removing wellplate from database",
        read_testing_config(),
    )
    wellplate._remove_wellplate_from_db(plate_to_remove)


def remove_experiment_from_database():
    """Removes a user provided experiment from the database."""
    experiment_to_remove = int(
        input("Enter the experiment number to remove: ").strip().lower()
    )
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY,
        "removing experiment from database",
        read_testing_config(),
    )
    wellplate._remove_experiment_from_db(experiment_to_remove)


def print_wellplate_info():
    """Prints a summary of the current wellplate."""


def print_queue_info():
    """Prints a summary of the current queue."""
    current_queue = sql_queue.select_queue()
    print("Current Queue:")
    for experiment in current_queue:
        print(experiment)

    input("Press Enter to continue...")


def reset_vials_stock():
    """Resets the stock vials."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "resetting stock vials"
    )
    vials.reset_vials("stock")


def reset_vials_waste():
    """Resets the waste vials."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "resetting waste vials"
    )
    vials.reset_vials("waste")


def input_new_vial_values_stock():
    """Inputs new values for the stock vials."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "inputting new vial values"
    )
    print("\nNOTE: Vial names of none indicate a vial that doesn't exist.")
    vials.input_new_vial_values("stock")


def input_new_vial_values_waste():
    """Inputs new values for the waste vials."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "inputting new vial values"
    )
    print("\nNOTE: Vial names of none indicate a vial that doesn't exist.")
    vials.input_new_vial_values("waste")


def change_wellplate_location():
    """Changes the location of the current wellplate."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "changing wellplate location"
    )
    wellplate.change_wellplate_location()


def run_experiment_generator():
    """Runs the edot voltage sweep experiment."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "generating experiment files"
    )
    sql_generator_utilities.read_in_generators()
    available_generators = sql_generator_utilities.get_generators()
    # os.system("cls" if os.name == "nt" else "clear")  # Clear the terminal
    print()
    if not available_generators:
        print("No generators available.")
        return
    print("Available generators:")
    for generator in available_generators:
        print(generator)

    generator_id = (
        input("Enter the id of the generator you would like to run or 'q' to go back: ")
        .strip()
        .lower()
    )
    if generator_id == "q":
        return
    generator_id = int(generator_id)
    sql_protocol_utilities.read_in_protocols()
    generator = sql_generator_utilities.get_generator_name(generator_id)
    sql_generator_utilities.run_generator(generator_id)


def toggle_testing_mode():
    """Sets the testing mode."""
    mode = read_testing_config()
    write_testing_config(not mode)
    print("To complete the switch, please restart the program.")
    sys.exit()


def calibrate_mill():
    """Calibrates the mill."""
    if read_testing_config():
        # print("Cannot calibrate the mill in testing mode.")
        # return
        mill = mill_control.MockMill
    else:
        mill = mill_control.Mill

    sql_system_state.set_system_status(
        utilities.SystemState.CALIBRATING, "calibrating the mill"
    )

    mill_calibration_and_positioning.calibrate_mill(
        mill,
        wellplate.Wellplate(),
        vials.read_vials()[0],
        vials.read_vials()[1],
    )


def test_camera():
    """Runs the mill control in testing mode."""
    flir_camera.capture_new_image()


def generate_experiment_from_existing_data():
    """Generates an experiment from existing data using the ML model."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "generating experiment"
    )
    next_experiment = scheduler.determine_next_experiment_id()
    output = pedot_analysis.pedot_model(
        pedot_analysis.ml_file_paths.training_file_path,
        pedot_analysis.ml_file_paths.model_base_path,
        pedot_analysis.ml_file_paths.counter_file_path,
        pedot_analysis.ml_file_paths.BestTestPointsCSV,
        pedot_analysis.ml_file_paths.contourplots_path,
        next_experiment,
    )
    output = MLOutput(*output)
    params_for_next_experiment = PEDOTParams(
        dep_v=output.v_dep,
        dep_t=output.t_dep,
        concentration=output.edot_concentration,
    )
    # The ML Model will then make a prediction for the next experiment
    # First fetch and send the contour plot
    contour_plot = Path(
        experiment_class.select_specific_result(
            next_experiment, "PEDOT_Contour_Plots"
        ).result_value  # should only return one value
    )
    # Then fetch the ML results
    results_to_find = [
        "PEDOT_Deposition_Voltage",
        "PEDOT_Deposition_Time",
        "PEDOT_Concentration",
        "PEDOT_Predicted_Mean",
        "PEDOT_Predicted_Uncertainty",
    ]
    ml_results = []
    for result_type in results_to_find:
        ml_results.append(
            experiment_class.select_specific_result(
                next_experiment, result_type
            ).result_value  # should only return one value
        )
    # Compose message
    ml_results_msg = f"""
    Model #: {output.model_id}\n
    Experiment {next_experiment} Parameters and Predictions:\n
    Deposition Voltage: {ml_results[0]}\n
    Deposition Time: {ml_results[1]}\n
    Concentration: {ml_results[2]}\n
    Predicted Mean: {ml_results[3]}\n
    Predicted StdDev: {ml_results[4]}\n
    """
    print(ml_results_msg)

    # img = mpimg.imread(contour_plot)
    # plt.imshow(img)
    img = Image.open(contour_plot)
    img.show()
    print(
        f"V_dep: {output.v_dep}, T_dep: {output.t_dep}, EDOT Concentration: {output.edot_concentration}"
    )
    keep_exp = (
        input("Would you like to add an experiment with these values? (y/n): ")
        .strip()
        .lower()
    )
    if keep_exp[0] == "y":
        pedot_analysis.pedot_generator(
            params_for_next_experiment,
            experiment_name="PEDOT_Optimization",
            campaign_id=0,
        )
    else:
        print("Experiment not added.")

        # Delete the contour plot files, and the model based on the model ID
        contour_plot.with_suffix(".png").unlink()
        contour_plot.with_suffix(".svg").unlink()
        model_name = (
            Path(pedot_analysis.ml_file_paths.model_base_path).name
            + f"_{output.model_id}"
        )
        model_path = Path(pedot_analysis.ml_file_paths.model_base_path)
        model_path = model_path.with_name(model_name).with_suffix(".pth")
        model_path.unlink()
        sql_ml_functions.delete_model(output.model_id)

        return

def analyze_pedot_experiment():
    """Analyzes a PEDOT experiment."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "analyzing PEDOT experiment"
    )
    experiment_id = int(
        input("Enter the experiment ID to analyze: ").strip().lower()
    )

    to_train = input("Train the model? (y/n): ").strip().lower()
    dont_train = True if to_train[0] == "n" else False
    results = pedot_analysis.pedot_analyzer(experiment_id, dont_train)
    print(results)

def clean_up_testing_experiments():
    """Cleans up the testing experiments."""
    sql_system_state.set_system_status(
        utilities.SystemState.BUSY, "cleaning up testing experiments"
    )
    remove_testing_experiments.main()

def exit_program():
    """Exits the program."""
    sql_system_state.set_system_status(
        utilities.SystemState.OFF, "exiting ePANDA"
    )
    print("Exiting ePANDA. Goodbye!")
    sys.exit()


def refresh():
    """
    Refreshes the main menue. Re-read the current wellplate info, and queue."""


def stop_epanda():
    """Stops the ePANDA loop."""
    sql_system_state.set_system_status(
        utilities.SystemState.SHUTDOWN, "stopping ePANDA"
    )


def pause_epanda():
    """Pauses the ePANDA loop."""
    sql_system_state.set_system_status(
        utilities.SystemState.PAUSE, "stopping ePANDA"
    )


def resume_epanda():
    """Resumes the ePANDA loop."""
    sql_system_state.set_system_status(
        utilities.SystemState.RESUME, "stopping ePANDA"
    )


def remove_training_data():
    """Removes the training data associated with a given experiment_id from the database."""
    experiment_id = int(
        input("Enter the experiment ID to remove the training data for: ")
        .strip()
        .lower()
    )
    sql_ml_functions.delete_training_data(experiment_id)


def show_warrenty():
    """Shows the warranty."""
    print(
        """
    NO WARRANTY

  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
REPAIR OR CORRECTION.

  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGES.

                     END OF TERMS AND CONDITIONS

            How to Apply These Terms to Your New Programs

  If you develop a new program, and you want it to be of the greatest
possible use to the public, the best way to achieve this is to make it
free software which everyone can redistribute and change under these terms.

  To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
convey the exclusion of warranty; and each file should have at least
the "copyright" line and a pointer to where the full notice is found.

    <one line to give the program's name and a brief idea of what it does.>
    Copyright (C) <year>  <name of author>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

Also add information on how to contact you by electronic and paper mail.

If the program is interactive, make it output a short notice like this
when it starts in an interactive mode:

    Gnomovision version 69, Copyright (C) year name of author
    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
    This is free software, and you are welcome to redistribute it
    under certain conditions; type `show c' for details.

    """)    

def show_conditions():
    """Shows the conditions."""
    print(
        """
    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. This License applies to any program or other work which contains
a notice placed by the copyright holder saying it may be distributed
under the terms of this General Public License.  The "Program", below,
refers to any such program or work, and a "work based on the Program"
means either the Program or any derivative work under copyright law:
that is to say, a work containing the Program or a portion of it,
either verbatim or with modifications and/or translated into another
language.  (Hereinafter, translation is included without limitation in
the term "modification".)  Each licensee is addressed as "you".

Activities other than copying, distribution and modification are not
covered by this License; they are outside its scope.  The act of
running the Program is not restricted, and the output from the Program
is covered only if its contents constitute a work based on the
Program (independent of having been made by running the Program).
Whether that is true depends on what the Program does.

  1. You may copy and distribute verbatim copies of the Program's
source code as you receive it, in any medium, provided that you
conspicuously and appropriately publish on each copy an appropriate
copyright notice and disclaimer of warranty; keep intact all the
notices that refer to this License and to the absence of any warranty;
and give any other recipients of the Program a copy of this License
along with the Program.

You may charge a fee for the physical act of transferring a copy, and
you may at your option offer warranty protection in exchange for a fee.

  2. You may modify your copy or copies of the Program or any portion
of it, thus forming a work based on the Program, and copy and
distribute such modifications or work under the terms of Section 1
above, provided that you also meet all of these conditions:

    a) You must cause the modified files to carry prominent notices
    stating that you changed the files and the date of any change.

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

    c) If the modified program normally reads commands interactively
    when run, you must cause it, when started running for such
    interactive use in the most ordinary way, to print or display an
    announcement including an appropriate copyright notice and a
    notice that there is no warranty (or else, saying that you provide
    a warranty) and that users may redistribute the program under
    these conditions, and telling the user how to view a copy of this
    License.  (Exception: if the Program itself is interactive but
    does not normally print such an announcement, your work based on
    the Program is not required to print an announcement.)

These requirements apply to the modified work as a whole.  If
identifiable sections of that work are not derived from the Program,
and can be reasonably considered independent and separate works in
themselves, then this License, and its terms, do not apply to those
sections when you distribute them as separate works.  But when you
distribute the same sections as part of a whole which is a work based
on the Program, the distribution of the whole must be on the terms of
this License, whose permissions for other licensees extend to the
entire whole, and thus to each and every part regardless of who wrote it.

Thus, it is not the intent of this section to claim rights or contest
your rights to work written entirely by you; rather, the intent is to
exercise the right to control the distribution of derivative or
collective works based on the Program.

In addition, mere aggregation of another work not based on the Program
with the Program (or with a work based on the Program) on a volume of
a storage or distribution medium does not bring the other work under
the scope of this License.

  3. You may copy and distribute the Program (or a work based on it,
under Section 2) in object code or executable form under the terms of
Sections 1 and 2 above provided that you also do one of the following:

    a) Accompany it with the complete corresponding machine-readable
    source code, which must be distributed under the terms of Sections
    1 and 2 above on a medium customarily used for software interchange; or,

    b) Accompany it with a written offer, valid for at least three
    years, to give any third party, for a charge no more than your
    cost of physically performing source distribution, a complete
    machine-readable copy of the corresponding source code, to be
    distributed under the terms of Sections 1 and 2 above on a medium
    customarily used for software interchange; or,

    c) Accompany it with the information you received as to the offer
    to distribute corresponding source code.  (This alternative is
    allowed only for noncommercial distribution and only if you
    received the program in object code or executable form with such
    an offer, in accord with Subsection b above.)

The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.  However, as a
special exception, the source code distributed need not include
anything that is normally distributed (in either source or binary
form) with the major components (compiler, kernel, and so on) of the
operating system on which the executable runs, unless that component
itself accompanies the executable.

If distribution of executable or object code is made by offering
access to copy from a designated place, then offering equivalent
access to copy the source code from the same place counts as
distribution of the source code, even though third parties are not
compelled to copy the source along with the object code.

  4. You may not copy, modify, sublicense, or distribute the Program
except as expressly provided under this License.  Any attempt
otherwise to copy, modify, sublicense or distribute the Program is
void, and will automatically terminate your rights under this License.
However, parties who have received copies, or rights, from you under
this License will not have their licenses terminated so long as such
parties remain in full compliance.

  5. You are not required to accept this License, since you have not
signed it.  However, nothing else grants you permission to modify or
distribute the Program or its derivative works.  These actions are
prohibited by law if you do not accept this License.  Therefore, by
modifying or distributing the Program (or any work based on the
Program), you indicate your acceptance of this License to do so, and
all its terms and conditions for copying, distributing or modifying
the Program or works based on it.

  6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.

  7. If, as a consequence of a court judgment or allegation of patent
infringement or for any other reason (not limited to patent issues),
conditions are imposed on you (whether by court order, agreement or
otherwise) that contradict the conditions of this License, they do not
excuse you from the conditions of this License.  If you cannot
distribute so as to satisfy simultaneously your obligations under this
License and any other pertinent obligations, then as a consequence you
may not distribute the Program at all.  For example, if a patent
license would not permit royalty-free redistribution of the Program by
all those who receive copies directly or indirectly through you, then
the only way you could satisfy both it and this License would be to
refrain entirely from distribution of the Program.

If any portion of this section is held invalid or unenforceable under
any particular circumstance, the balance of the section is intended to
apply and the section as a whole is intended to apply in other
circumstances.

It is not the purpose of this section to induce you to infringe any
patents or other property right claims or to contest validity of any
such claims; this section has the sole purpose of protecting the
integrity of the free software distribution system, which is
implemented by public license practices.  Many people have made
generous contributions to the wide range of software distributed
through that system in reliance on consistent application of that
system; it is up to the author/donor to decide if he or she is willing
to distribute software through any other system and a licensee cannot
impose that choice.

This section is intended to make thoroughly clear what is believed to
be a consequence of the rest of this License.

  8. If the distribution and/or use of the Program is restricted in
certain countries either by patents or by copyrighted interfaces, the
original copyright holder who places the Program under this License
may add an explicit geographical distribution limitation excluding
those countries, so that distribution is permitted only in or among
countries not thus excluded.  In such case, this License incorporates
the limitation as if written in the body of this License.

  9. The Free Software Foundation may publish revised and/or new versions
of the General Public License from time to time.  Such new versions will
be similar in spirit to the present version, but may differ in detail to
address new problems or concerns.

Each version is given a distinguishing version number.  If the Program
specifies a version number of this License which applies to it and "any
later version", you have the option of following the terms and conditions
either of that version or of any later version published by the Free
Software Foundation.  If the Program does not specify a version number of
this License, you may choose any version ever published by the Free Software
Foundation.

  10. If you wish to incorporate parts of the Program into other free
programs whose distribution conditions are different, write to the author
to ask for permission.  For software which is copyrighted by the Free
Software Foundation, write to the Free Software Foundation; we sometimes
make exceptions for this.  Our decision will be guided by the two goals
of preserving the free status of all derivatives of our free software and
of promoting the sharing and reuse of software generally.
    """)

def print_env_variables():
    """Prints the dot environment variables."""
    # Get the environment variables
    print("Environment Variables:")
    dotenv_path = Path(__file__).parent / '.env'
    dotenv.load_dotenv(dotenv_path)
    for key, value in os.environ.items():
        print(f"{key}: {value}")
    

menu_options = {
    "0": run_epanda_with_ml,
    "1": run_epanda_without_ml,
    "1.1": stop_epanda,
    "1.2": pause_epanda,
    "1.3": resume_epanda,
    "2": change_wellplate,
    "2.1": remove_wellplate_from_database,
    "2.2": remove_experiment_from_database,
    "2.3": print_wellplate_info,
    "2.4": print_queue_info,
    "2.5": remove_training_data,
    "2.6": clean_up_testing_experiments,
    "3": reset_vials_stock,
    "4": reset_vials_waste,
    "5": input_new_vial_values_stock,
    "6": input_new_vial_values_waste,
    "7": run_experiment_generator,
    "8": toggle_testing_mode,
    "9": calibrate_mill,
    "9.1": change_wellplate_location,
    "11": test_camera,
    "12": generate_experiment_from_existing_data,
    "13": genererate_pedot_experiment,
    "14": analyze_pedot_experiment,
    "r": refresh,
    "w": show_warrenty,
    "c": show_conditions,
    "env": print_env_variables,
    "q": exit_program,
}

if __name__ == "__main__":

    print("""
    PANDA SDL version 1.0.0, Copyright (C) 2024 Gregory Robben, Harley Quinn
    PANDA SDL comes with ABSOLUTELY NO WARRANTY; choose `show_warrenty' 
    for more details.
    
    This is free software, and you are welcome to redistribute it
    under certain conditions; choose `show_conditions' for details.
          """)


    sql_system_state.set_system_status(
        utilities.SystemState.ON, "at main menu"
    )
    time.sleep(1)
    sql_protocol_utilities.read_in_protocols()

    while True:
        sql_system_state.set_system_status(
            utilities.SystemState.IDLE, "at main menu"
        )
        # os.system("cls" if os.name == "nt" else "clear")  # Clear the terminal
        print()
        print(print_panda.print_panda())
        print()
        print("Welcome to ePANDA!")
        print("Testing mode is currently:", "ON" if read_testing_config() else "OFF")
        num, p_type, free_wells = wellplate.read_current_wellplate_info()
        print(
            f"The current wellplate is #{num} - Type: {p_type} - Available Wells: {free_wells}"
        )
        print(f"The queue has {scheduler.get_queue_length()} experiments.")
        print("What would you like to do?")
        for key, value in menu_options.items():
            print(f"{key}. {value.__name__.replace('_', ' ').title()}")

        user_choice = input("Enter the number of your choice: ").strip().lower()
        try:
            if user_choice in menu_options:
                menu_options[user_choice]()
            else:
                print("Invalid choice. Please try again.")
                continue
        except controller.ShutDownCommand:
            pass  # The epanda loop has been stopped but we don't want to exit the program

        except controller.OCPFailure:
            slack = controller.SlackBot()
            slack.send_slack_message(
                "alert", "OCP Failure has occured. Please check the system."
            )
            channel_id = slack.channel_id("alert")
            slack.take_screenshot(channel_id, "webcam")
            slack.take_screenshot(channel_id, "vials")
            time.sleep(5)
            slack.send_slack_message("alert", "Would you like to continue? (y/n): ")
            while True:
                contiue_choice = slack.check_latest_message(channel_id)[0].strip().lower()
                if contiue_choice == "y":
                    break
                if contiue_choice == "n":
                    break
            if contiue_choice == "n":
                continue
            if contiue_choice == "y":
                menu_options[user_choice]()

        except Exception as e:
            print(f"An error occurred: {e}")
            break  # Exit the program if an unknown error occurs

    sql_system_state.set_system_status(
        utilities.SystemState.OFF, "exiting ePANDA"
    )
