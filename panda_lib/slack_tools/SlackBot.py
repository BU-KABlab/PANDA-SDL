"""sendSlackMessages.py"""

# pylint: disable=line-too-long

import base64
import json
import logging
import os
import time
from dataclasses import dataclass
from datetime import datetime

# Import WebClient from Python SDK (github.com/slackapi/python-slack-sdk)
from enum import Enum
from io import BytesIO
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd
import dotenv
from PIL import Image
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

import panda_lib.config.config as config
import panda_lib.experiment_class as exp
from panda_lib import vials
from panda_lib.image_tools import add_data_zone
from panda_lib.obs_controls import OBSController
from panda_lib.sql_tools import (
    sql_queue,
    sql_slack_tickets,
    sql_system_state,
    sql_utilities,
    sql_wellplate,
)
from panda_lib.wellplate import Well, Wellplate

dotenv.load_dotenv()
# STOCK_STATUS = config.STOCK_STATUS
# WASTE_STATUS = config.WASTE_STATUS


@dataclass
class SlackCred:
    """This class is used to store the slack secrets"""

    TOKEN = os.environ.get("SLACK_TOKEN")
    DATA_CHANNEL_ID = os.environ.get("SLACK_DATA_CHANNEL_ID")
    TEST_DATA_CHANNEL_ID = os.environ.get("SLACK_TEST_DATA_CHANNEL_ID")
    CONVERSATION_CHANNEL_ID = os.environ.get("SLACK_CONVERSATION_CHANNEL_ID")
    TEST_CONVERSATION_CHANNEL_ID = os.environ.get("SLACK_TEST_CONVERSATION_CHANNEL_ID")
    ALERT_CHANNEL_ID = os.environ.get("SLACK_ALERT_CHANNEL_ID")
    TEST_ALERT_CHANNEL_ID = os.environ.get("SLACK_TEST_ALERT_CHANNEL_ID")


class Cameras(Enum):
    """
    Enum for camera types
    """

    WEBCAM = 0
    VIALS = 1
    PSTAT = 2


# region Slack Tickets
@dataclass
class SlackTicket:
    """Class for storing slack tickets."""

    msg_id: str
    channel_id: str
    msg_text: str
    valid_cmd: int
    timestamp: str
    addressed_timestamp: str


def insert_slack_ticket(ticket: SlackTicket, test: bool = False) -> None:
    """
    Insert a slack ticket into the slack_tickets table.

    Args:
        ticket (SlackTicket): The slack ticket to insert.
    """
    if os.environ["PANDA_SDL_USE_SLACK"] == "0":
        test = True
    sql_utilities.execute_sql_command_no_return(
        """
        INSERT INTO slack_tickets (
            msg_id,
            channel_id,
            message,
            response,
            timestamp,
            addressed_timestamp
            )
        VALUES (?, ?, ?, ?, ?, ?)
        """,
        (
            ticket.msg_id,
            ticket.channel_id,
            ticket.msg_text,
            ticket.valid_cmd,
            ticket.timestamp,
            ticket.addressed_timestamp,
        ),
        test=test,
    )


def select_slack_ticket(msg_id: str, test: bool = False) -> SlackTicket:
    """
    Select a slack ticket from the slack_tickets table.

    Args:
        msg_id (str): The message ID of the slack ticket.

    Returns:
        SlackTicket: The slack ticket.
    """
    if os.environ["PANDA_SDL_USE_SLACK"] == "0":
        test = True
    result = sql_utilities.execute_sql_command(
        """
        SELECT
            msg_id,
            channel_id,
            message,
            response,
            timestamp,
            addressed_timestamp
        FROM slack_tickets
        WHERE msg_id = ?
        """,
        (msg_id,),
        test=test,
    )
    if result == []:
        return None
    return SlackTicket(*result[0])


class SlackBot:
    """Class for sending messages to Slack."""

    def __init__(self, test: bool = config.read_testing_config()) -> None:

        self.logger = logging.getLogger("e_panda")
        self.test = test
        self.client = WebClient(token=SlackCred.TOKEN)
        if os.environ["PANDA_SDL_USE_SLACK"] == "0":
            self.test = True

    def send_slack_message(self, channel_id: str, message) -> None:
        """Send a message to Slack."""
        if os.environ["PANDA_SDL_USE_SLACK"] == "0":
            print(message)


        client = WebClient(SlackCred.TOKEN)
        channel_id = self.channel_id(channel_id)
        if channel_id == 0 or channel_id is None:
            return

        try:
            result = client.chat_postMessage(channel=channel_id, text=message)
            print("Slack:", message)
            if result["ok"]:
                self.logger.info("Message sent:%s", message)
            else:
                self.logger.error("Error sending message:%s", message)
        except SlackApiError as error:
            self.logger.error("Error posting message: %s", error)

    def send_slack_file(self, channel: str, file, message=None) -> int:
        """Send a file to Slack."""

        if os.environ["PANDA_SDL_USE_SLACK"] == "0":
            return
        
        client = WebClient(SlackCred.TOKEN)
        file = Path(file)
        filename_to_post = file.name

        channel_id = self.channel_id(channel)
        if channel_id == 0:
            return 0

        try:
            result = None
            with open(file, "rb") as f:
                result = client.files_upload_v2(
                    channel=channel_id,
                    file=f,
                    filename=filename_to_post,
                    initial_comment=message,
                )

            if result["ok"]:
                self.logger.info("File sent: %s", file.name)
                return 1
            self.logger.error("Error sending file: %s", file.name)
            return 0
        except SlackApiError as exception:
            log_msg = f"Error uploading file: {format(exception)}"
            self.logger.error(log_msg)
            return 0

    # def post_message_with_files(self, channel, message, file_list):
    #     """Post a message with files to Slack."""
    #     client = WebClient(SlackCred.TOKEN)
    #     channel_id = self.channel_id(channel)
    #     file_ids = []
    #     file_urls = []
    #     for file in file_list:
    #         file = Path(file)
    #         upload = client.files_upload_v2(
    #             channel=channel_id,
    #             file=str(file.resolve()),
    #             filename=file.name,
    #         )
    #         file_ids.append(upload["file"]["id"])
    #         file_urls.append(upload["file"]["url_private"])
    #     # Post a message with the uploaded images

    #     # Post a single message with all the uploaded files
    #     client.chat_postMessage(
    #         channel=channel_id,
    #         text=message,
    #         attachments=[
    #             {
    #                 "title": "Uploaded Image",
    #                 "image_url": f"{url}",
    #                 "alt_text": "Uploaded Image",
    #             }
    #             for url in file_urls
    #         ],
    #     )

    def upload_images(self, channel, images, message):
        """Upload images to Slack."""
        if os.environ["PANDA_SDL_USE_SLACK"] == "0":
            return
        client = WebClient(SlackCred.TOKEN)
        channel_id = self.channel_id(channel)
        image_paths = [Path(image) for image in images]
        file_upload_parts = []
        for image in image_paths:
            file_upload_parts.append(
                {
                    "file": (str(image.resolve())),
                    "title": image.name,
                }
            )
        response = client.files_upload_v2(
            file_uploads=file_upload_parts,
            channel=channel_id,
            initial_comment=message,
        )

        print(response)

    def check_latest_message(self, channel: str) -> str:
        """Check Slack for the latest message."""
        if os.environ["PANDA_SDL_USE_SLACK"] == "0":
            return
        client = WebClient(token=SlackCred.TOKEN)
        channel_id = self.channel_id(channel)
        if channel_id == 0:
            return 0

        try:
            result = client.conversations_history(
                channel=channel_id,
                limit=1,
                inclusive=True,
                # latest=datetime.now().timestamp(),
            )
            conversation_history = result["messages"][0]["text"]
            return conversation_history
        except SlackApiError as error:
            error_msg = f"Error creating conversation: {format(error)}"
            self.logger.error(error_msg)
            return 0

    def check_slack_messages(self, channel: str) -> int:
        """Check Slack for messages."""
        if os.environ["PANDA_SDL_USE_SLACK"] == "0":
            return
        # WebClient insantiates a client that can call API methods
        # When using Bolt, you can use either `app.client` or the `client` passed to listeners.
        client = WebClient(token=SlackCred.TOKEN)
        # Store conversation history
        conversation_history = []
        # ID of the channel you want to send the message to
        channel_id = self.channel_id(channel)
        if channel_id == 0:
            return 0

        # latestTS = datetime.now().timestamp()

        try:
            self.logger.info("Checking for new messages.")
            # Call the conversations.history method using the WebClient
            # conversations.history returns the first 100 messages by default
            # These results are paginated, see:
            # https://api.slack.com/methods/conversations.history$pagination
            result = client.conversations_history(
                channel=channel_id,
                limit=5,
                inclusive=True,
                latest=datetime.now().timestamp(),
            )

            conversation_history = result["messages"]

            conversation_history2 = [
                x
                for x in conversation_history
                if (str(x["text"][0:7]).lower() == "!epanda")
            ]

            for _, payload in enumerate(conversation_history2):
                msg_id = payload["client_msg_id"]
                msg_text: str = payload["text"]
                msg_ts = payload["ts"]
                lookup_tickets = self.find_id(msg_id)
                if lookup_tickets is False:
                    # Send message to Slack
                    logging.info("New message found: %s", msg_text)
                    response = self.parse_slack_message(
                        msg_text[8:].rstrip(), channel_id
                    )
                    # Add message to csv file
                    # with open(
                    #     SLACK_TICKETS,
                    #     "a",
                    #     newline="",
                    #     encoding="utf-8",
                    # ) as csvfile:
                    #     writer = csv.DictWriter(
                    #         csvfile,
                    #         fieldnames=[
                    #             "msg_id",
                    #             "channel_id",
                    #             "msg_txt",
                    #             "valid_cmd",
                    #             "ts",
                    #             "addressed_ts",
                    #         ],
                    #     )
                    #     writer.writerow(
                    #         {
                    #             "msg_id": msg_id,
                    #             "channel_id": channel_id,
                    #             "msg_txt": msg_text,
                    #             "valid_cmd": response,
                    #             "ts": msg_ts,
                    #             "addressed_ts": datetime.now().timestamp(),
                    #         }
                    #     )
                    insert_slack_ticket(
                        SlackTicket(
                            msg_id=msg_id,
                            channel_id=channel_id,
                            msg_text=msg_text,
                            valid_cmd=response,
                            timestamp=msg_ts,
                            addressed_timestamp=datetime.now().timestamp(),
                        ),
                        test=self.test,
                    )

                    if response == 0:
                        return 0
                    else:
                        print(f"responded to {msg_id}")
                        return 1
                else:
                    continue

            return 1
            # Print results
            # print(json.dumps(conversation_history2, indent=2))

        except SlackApiError as error:
            error_msg = f"Error creating conversation: {format(error)}"
            self.logger.error(error_msg)
            return 0

    def find_id(self, msg_id):
        """Find the message ID in the slack ticket tracker csv file."""
        # with open(
        #     SLACK_TICKETS,
        #     newline="",
        #     encoding="utf-8",
        # ) as csvfile:
        #     reader = csv.DictReader(
        #         csvfile,
        #         fieldnames=[
        #             "msg_id",
        #             "channel_id",
        #             "msg_txt",
        #             "valid_cmd",
        #             "ts",
        #             "addressed_ts",
        #         ],
        #     )
        #     for row in reader:
        #         if row["msg_id"] == msg_id:
        #             return row
        # return False
        ticket = select_slack_ticket(msg_id, test=self.test)
        if ticket is not None:
            return ticket
        return False

    def parse_slack_message(self, text: str, channel_id) -> int:
        """
        Parse the Slack message for commands.
        If command is valid, execute command and returns 0 else return 1.

        Valid commands: help, plot experiment #, share experiment #, status experiment #, vial status, well status, pause, resume, start, stop

        Args:
            message (str): The message to parse without the bot keyword !epanda.

        Returns:
            1 if command is valid, 0 if command is invalid.
        """
        # clean inputs
        text = text.lower()

        # Parse message
        if text == "help":
            self.__help_menu(channel_id=channel_id)
            return 1

        elif text[0:15] == "data experiment":
            # Get experiment number.
            # experiment_number = text[7:]
            return 1

        elif (
            text[0:17] == "status-experiment"
            or text[0:17] == "status experiment"
            or text[0:17] == "experiment status"
        ):
            # Get experiment number
            try:
                experiment_number = int(text[17:].strip())
                # Get status
                status = exp.select_experiment_status(experiment_number)
                message = f"The status of experiment {experiment_number} is {status}."
                self.send_slack_message(channel_id, message)
            except ValueError:
                message = "Please enter a valid experiment number."
                self.send_slack_message(channel_id, message)
            return 1

        elif text[0:17] == "images experiment":
            # Get experiment number
            try:
                experiment_number = int(text[17:].strip())
                self.__share_experiment_images(experiment_number)

            except ValueError:
                message = "Please enter a valid experiment number."
                self.send_slack_message(channel_id, message)
            return 1
        elif text[0:11] == "vial status":
            self.__vial_status(channel_id=channel_id)
            return 1

        elif text[0:11] == "well status":
            # Get well status
            self.__well_status(channel_id=channel_id)
            return 1

        elif text[0:12] == "queue length":
            self.__queue_length(channel_id=channel_id)
            return 1
        elif text[0:13] == "system status":
            self.__queue_length(channel_id=channel_id)
            self.__well_status(channel_id=channel_id)
            time.sleep(1)
            self.__vial_status(channel_id=channel_id)
            return 1

        elif text[0:10] == "screenshot":
            try:
                parts = text.split("-")
                camera = parts[1].strip().lower()
                # # Validate the camera choice against the Cameras enum
                # try:
                #     camera = Cameras[camera.upper()]
                # except KeyError:
                #     message = "Please specify a valid camera to take a screenshot of."
                #     self.send_slack_message(channel_id, message)
                #     message = "Valid cameras are: webcam, vials, pstat"
                #     self.send_slack_message(channel_id, message)
                #     return 1

                self.take_screenshot(channel_id, camera)
            except IndexError:
                message = (
                    "Please specify which camera to take a screenshot of with a '-'."
                )
                self.send_slack_message(channel_id, message)
            return 1

        elif text[0:7] == "status":
            sql_system_state.select_system_status()
        elif text[0:5] == "pause":
            sql_system_state.set_system_status(
                sql_system_state.SystemState.PAUSE, "pausing ePANDA", self.test
            )
            return 1

        elif text[0:6] == "resume":
            sql_system_state.set_system_status(
                sql_system_state.SystemState.RESUME, "resuming ePANDA", self.test
            )
            return 1

        elif text[0:5] == "start":
            # system_state.set_system_status(system_state.SystemState.ON, "starting ePANDA", self.test)
            # start the experiment loop
            # controller.main()
            self.send_slack_message(
                channel_id, "Sorry starting the ePANDA is not something I can do yet"
            )
            return 1

        elif text[0:4] == "stop":
            sql_system_state.set_system_status(
                sql_system_state.SystemState.SHUTDOWN, "stopping ePANDA", self.test
            )
            return 1

        elif text[0:4] == "exit":
            return 0

        else:
            message = "Sorry, I don't understand that command. Type !epanda help for commands I understand."
            self.send_slack_message(channel_id, message)
            return 1

    def __help_menu(self, channel_id):
        """Sends the help menu to the user."""

        if channel_id != SlackCred.DATA_CHANNEL_ID:
            message = (
                "Here is a list of commands I understand:\n"
                "help -> displays this message\n"
                # "plot experiment # - plots plots the CV data for experiment #\n"
                # "data experiment # - sends the data files for experiment #\n"
                "status experiment # - displays the status of experiment #\n"
                "vial status -> displays the status of the vials\n"
                "well status -> displays the status of the wells and the rest of the deck\n"
                "queue length -> displays the length of the queue\n"
                "status -> displays the status of the vials, wells, and queue\n"
                "screenshot-{camera name} -> takes a screenshot of the specified camera\n"
                "pause - pauses the experiment loop\n"
                "resume - resumes the experiment loop\n"
                # "start - starts the experiment loop\n"
                "stop - stops the experiment loop\n"
                "exit -> closes the slackbot\n"
            )
        else:  # data channel
            message = (
                "Here is a list of commands I understand:\n"
                "help -> displays this message\n"
                # "plot experiment # - plots plots the CV data for experiment #\n"
                # "data experiment # - sends the data files for experiment #\n"
                "images experiment # - sends the images for experiment #\n"
                "status experiment # - displays the status of experiment #\n"
                "vial status -> displays the status of the vials\n"
                "well status -> displays the status of the wells and the rest of the deck\n"
                "queue length -> displays the length of the queue\n"
                "status -> displays the status of the vials, wells, and queue\n"
                "screenshot-{camera name} -> takes a screenshot of the specified camera\n"
                "pause - pauses the experiment loop\n"
                "resume - resumes the experiment loop\n"
                # "start - starts the experiment loop\n"
                "stop - stops the experiment loop\n"
            )
        self.send_slack_message(channel_id, message)
        return 1

    def __vial_status(self, channel_id):
        """Sends the vial status to the user."""
        # Get vial status
        # ## Load the vial status json file
        # stock_vials = pd.read_json(STOCK_STATUS)
        # ## Filter for just the vial position and volume
        # stock_vials = stock_vials[["position", "volume", "name", "contents"]]
        # # Drop any vials that have null values
        # stock_vials = stock_vials.dropna()
        # ## set position to be a string and volume to be a float
        # stock_vials["position"] = stock_vials["position"].astype(str)
        # stock_vials["volume"] = stock_vials["volume"].astype(float)

        stock_vials = vials.get_current_vials("stock")  # returns a list of Vial objects
        stock_vials = pd.DataFrame([vial.to_dict() for vial in stock_vials])
        stock_vials = stock_vials[["position", "volume", "name", "contents"]]
        stock_vials = stock_vials.dropna()
        stock_vials["position"] = stock_vials["position"].astype(str)
        stock_vials["volume"] = stock_vials["volume"].astype(float)

        ## Create a bar graph with volume on the x-axis and position on the y-axis
        ## Send the graph to slack
        plt.bar(
            stock_vials["position"],
            stock_vials["volume"],
            align="center",
            alpha=0.5,
            color="blue",
        )
        # label each bar with the volume
        for i, v in enumerate(stock_vials["volume"]):
            plt.text(i, v, str(round(v, 4)), color="black", ha="center")

        # Draw a horizontal line at 4000
        plt.axhline(y=2000, color="red", linestyle="-")
        # Write the name of the vial vertically in the bar
        for i, v in enumerate(stock_vials["contents"]):
            plt.text(i, 10, str(v), color="black", ha="center", rotation=90)
        plt.xlabel("Position")
        plt.ylabel("Volume")
        plt.title("Stock Vial Status")
        plt.savefig("vial_status.png")
        self.send_slack_file(channel_id, "vial_status.png")

        ## Delete the graph file
        Path("vial_status.png").unlink()
        plt.close()

        # And the same for the waste vials
        # waste_vials = pd.read_json(WASTE_STATUS)
        waste_vials = vials.get_current_vials("waste")
        waste_vials = pd.DataFrame([vial.to_dict() for vial in waste_vials])
        waste_vials = waste_vials[["position", "volume", "name"]]
        # Drop any vials that have null values
        waste_vials = waste_vials.dropna()
        waste_vials["position"] = waste_vials["position"].astype(str)
        waste_vials["volume"] = waste_vials["volume"].astype(float)
        plt.bar(
            waste_vials["position"],
            waste_vials["volume"],
            align="center",
            alpha=0.5,
            color="blue",
        )
        for i, v in enumerate(waste_vials["volume"]):
            plt.text(i, v, str(round(v, 4)), color="black", ha="center")
        plt.axhline(y=20000, color="red", linestyle="-")
        for i, v in enumerate(waste_vials["name"]):
            plt.text(i, 10, str(v), color="black", ha="center", rotation=90)
        plt.xlabel("Position")
        plt.ylabel("Volume")
        plt.title("Waste Vial Status")
        plt.savefig("waste_status.png")
        self.send_slack_file(channel_id, "waste_status.png")
        Path("waste_status.png").unlink()
        plt.close()

    def __well_status(self, channel_id):
        """Sends the well status to the user."""
        # Check current wellplate type
        _, type_number, _ = sql_wellplate.select_current_wellplate_info()
        _, _, _, _, wellplate_type = sql_wellplate.select_well_characteristics(
            type_number
        )
        # Choose the correct wellplate object based on the wellplate type
        wellplate: Wellplate = None
        if wellplate_type == "circular":
            wellplate = Wellplate(
                type_number=type_number,
            )
        elif wellplate_type == "square":
            wellplate = Wellplate(
                type_number=type_number,
            )

        ## Well coordinates and colors
        # Plot the well plate on a coordinate plane.
        x_coordinates = []
        y_coordinates = []
        color = []

        current_wells = sql_wellplate.select_wellplate_wells()
        # turn tuple of well info into a list of well objects
        current_wells = [Well(*well) for well in current_wells]

        for well in current_wells:
            x_coordinates.append(well.coordinates["x"])
            y_coordinates.append(well.coordinates["y"])
            color.append(self._get_well_color(well.status))

        if wellplate.shape == "circular":
            marker = "o"
        else:
            marker = "s"

        ## Label the wellplate with the plate id below the bottom row and centered to the wellplate
        # get the coordinates of wells H12 and A12
        h12: dict = wellplate.get_coordinates("H12")
        a12: dict = wellplate.get_coordinates("A12")
        # calculate the center of the wellplate
        center = h12["x"] + (a12["x"] - h12["x"]) / 2
        # plot the plate id
        plt.text(
            center, h12["y"] - 20, str(wellplate.plate_id), color="black", ha="center"
        )

        ## Vial coordinates
        vial_x = []
        vial_y = []
        vial_color = []
        vial_marker = []  # a circle for these circular vials
        ## Vials
        # with open(WASTE_STATUS, "r", encoding="utf-8") as stock:
        #     data = json.load(stock)
        data = vials.get_current_vials("waste")
        for vial in data:
            vial = vial.to_dict()
            vial_x.append(vial["vial_coordinates"]["x"])
            vial_y.append(vial["vial_coordinates"]["y"])
            volume = vial["volume"]
            capacity = vial["capacity"]
            if vial["name"] is None or vial["name"] == "":
                vial_color.append("black")
                vial_marker.append("x")
            elif volume / capacity > 0.75:
                vial_color.append("red")
                vial_marker.append("o")
            elif volume / capacity > 0.50:
                vial_color.append("yellow")
                vial_marker.append("o")
            else:
                vial_color.append("green")
                vial_marker.append("o")
        # with open(STOCK_STATUS, "r", encoding="utf-8") as stock:
        #     data = json.load(stock)
        data = vials.get_current_vials("stock")
        for vial in data:
            vial = vial.to_dict()
            vial_x.append(vial["vial_coordinates"]["x"])
            vial_y.append(vial["vial_coordinates"]["y"])
            volume = vial["volume"]
            capacity = vial["capacity"]
            if vial["name"] is None or vial["name"] == "":
                vial_color.append("black")
                vial_marker.append("x")
            elif volume / capacity > 0.5:
                vial_color.append("green")
                vial_marker.append("o")
            elif volume / capacity > 0.25:
                vial_color.append("yellow")
                vial_marker.append("o")
            else:
                vial_color.append("red")
                vial_marker.append("o")

        # rinse_vial = {"x": -411, "y": -30}
        # vial_x.append(rinse_vial["x"])
        # vial_y.append(rinse_vial["y"])
        # vial_color.append("black")
        ## combine the well and vial coordinates
        # x_coordinates.extend(stock_vial_x)
        # y_coordinates.extend(stock_vial_y)
        # color.extend(vial_color)

        # Plot the well plate
        plt.scatter(
            x_coordinates, y_coordinates, marker=marker, c=color, s=75, alpha=0.5
        )
        plt.scatter(vial_x, vial_y, marker="o", c=vial_color, s=200, alpha=1)
        plt.xlabel("X")
        plt.ylabel("Y")
        plt.title("Status of Stage Items")
        plt.grid(True, "both")
        plt.xlim(-420, 10)
        plt.ylim(-310, 10)
        plt.savefig("well_status.png", format="png")
        plt.close()
        # Send the plot to Slack
        self.send_slack_file(channel_id, "well_status.png")
        Path("well_status.png").unlink()
        return 1

    def __queue_length(self, channel_id):
        # Get queue length
        queue_length = 0
        queue_length = sql_queue.count_queue_length()
        message = f"The queue length is {queue_length}."
        self.send_slack_message(channel_id, message)
        return 1

    def _get_well_color(self, status: str) -> str:
        """Get the color of a well based on its status."""
        if status is None:
            return "black"
        color_mapping = {
            "empty": "black",
            "new": "grey",
            "queued": "orange",
            "complete": "green",
            "error": "red",
            "paused": "blue",
        }
        return color_mapping.get(status, "gold")

    def take_screenshot(self, channel_id, camera_name: str):
        """Take a screenshot of the camera."""
        try:
            file_name = "tmp_screenshot.png"
            obs = OBSController()
            # verify that the camera is an active source
            try:
                sources = obs.client.get_source_active(camera_name)
            except Exception:
                self.send_slack_message(
                    channel_id, f"Could not find a camera source named {camera_name}"
                )
                return 1
            if not sources:
                self.send_slack_message(
                    channel_id, f"Camera {camera_name} is not active"
                )
                return 1
            screenshot = obs.client.get_source_screenshot(
                camera_name, "png", 1920, 1080, -1
            )
            img = Image.open(
                BytesIO(base64.b64decode(screenshot.image_data.split(",")[1]))
            )
            img = add_data_zone(img, context=f"{camera_name.capitalize()} Screenshot")
            img.save(file_name, "png")
            self.send_slack_file(
                channel_id, file_name, f"{camera_name.capitalize()} Screenshot"
            )
            Path(file_name).unlink()  # delete the file
            return 1

        except Exception as e:
            self.send_slack_message(channel_id, "Error taking screenshot")
            self.send_slack_message(channel_id, str(e))
            return 1

    def __share_experiment_images(self, experiment_id: int):
        """Share the images for an experiment."""
        # Look up there experiment_id in the db and find all results of type image
        # Then filter the results to only include those with dz in the name
        # Then send the images to slack

        results = exp.select_specific_result(experiment_id, "image")
        if results == [] or results is None:
            message = f"Experiment {experiment_id} does not have any images. Or the experiment {experiment_id} does not exist."
            self.send_slack_message("data", message)
            return
        for result in results:
            result: exp.ExperimentResultsRecord
            if "dz" not in result.result_value:
                results.remove(result)

        # Now make a list of the image paths
        image_paths = [result.result_value for result in results]

        # Now send the images to slack
        self.upload_images(
            "data", image_paths, f"Images for experiment {experiment_id}"
        )

    def channel_id(self, channel: str) -> str:
        """Return the channel ID based on the channel name."""
        if channel == "conversation":
            channel_id = (
                SlackCred.CONVERSATION_CHANNEL_ID
                if not self.test
                else SlackCred.TEST_ALERT_CHANNEL_ID
            )
        elif channel == "alert":
            channel_id = (
                SlackCred.ALERT_CHANNEL_ID
                if not self.test
                else SlackCred.TEST_ALERT_CHANNEL_ID
            )
        elif channel == "data":
            channel_id = (
                SlackCred.DATA_CHANNEL_ID
                if not self.test
                else SlackCred.TEST_DATA_CHANNEL_ID
            )
        elif channel in [
            SlackCred.CONVERSATION_CHANNEL_ID,
            SlackCred.ALERT_CHANNEL_ID,
            SlackCred.DATA_CHANNEL_ID,
            SlackCred.TEST_ALERT_CHANNEL_ID,
            SlackCred.TEST_DATA_CHANNEL_ID,
            SlackCred.TEST_CONVERSATION_CHANNEL_ID,
        ]:
            channel_id = channel
        else:
            return 0
        return channel_id


if __name__ == "__main__":
    slack_bot = SlackBot(test=False)
    TEST_MESSAGE = "This is a test message."
    EPANDA_HELLO = """Hello ePANDA team! I am ePANDA..."""
    # slack_bot.check_slack_messages("alert")
    slack_bot.send_slack_message("alert", TEST_MESSAGE)
