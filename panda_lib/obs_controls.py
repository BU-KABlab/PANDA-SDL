"""
This file simplifies controlling the OBS software in the ways that we need. 
It is used to place the experiment information on the screen and to turn on and off the webcam.
"""

# pylint: disable=unnecessary-pass
import logging
from dataclasses import dataclass
from pathlib import Path
import obsws_python as obsws
from obsws_python import error as OBSerror
import os
from .config.config import PATH_TO_LOGS, read_testing_config
from .log_tools import e_panda_logger as logger

## set up logging to log to both the obs_control.log file and the ePANDA.log file
formatter = logging.Formatter("%(asctime)s:%(name)s:%(message)s")
file_handler = logging.FileHandler(PATH_TO_LOGS / "obs_control.log")
# system_handler = logging.FileHandler("ePANDA.log")
file_handler.setFormatter(formatter)
# system_handler.setFormatter(formatter)
logger.addHandler(file_handler)
# logger.addHandler(system_handler)

@dataclass
class OBSSecrets:
    """This class is used to store the OBS secrets"""

    HOST = os.environ.get("OBS_HOST")
    PASSWORD = os.environ.get("OBS_PASSWORD")
    PORT = int(os.environ.get("OBS_PORT"))
    TIMEOUT = int(os.environ.get("OBS_TIMEOUT"))

class OBSController:
    """This class is used simplify the control the OBS software for our needs"""

    def __init__(
        self,
        client_host=OBSSecrets.HOST,
        client_password=OBSSecrets.PASSWORD,
        client_port=OBSSecrets.PORT,
        client_timeout=3,
    ):
        try:
            self.client = obsws.ReqClient(
                host=client_host,
                port=client_port,
                password=client_password,
                timeout=client_timeout,
            )
            self.logger = logging.getLogger(__name__)
            self.sources = {
                "pstat": 0,
                "webcam": 0,
                "vials": 0,
                "text": 0,
                "image": 0,
            }
        except OBSerror.OBSSDKRequestError as e:
            self.logger.error("Error connecting to OBS: %s", e)
            self.client = None

        for source in self.sources.keys():
            try:
                self.sources[source] = self.client.get_source_active(source)
            except OBSerror.OBSSDKRequestError:

                self.logger.error("Error getting source active status: %s", e)
                # self.logger.error("Trying to make source instead")
                # self.client.create_input(source, source)
                self.sources[source] = -1

    def disconnect_from_obs(self):
        """Disconnect from OBS"""
        pass

    def place_experiment_on_screen(self, instructions):
        """Place the experiment information on the screen"""
        try:
            exp_id = (
                instructions.experiment_id if instructions.experiment_id else "None"
            )
            project_id = instructions.project_id if instructions.project_id else "None"
            well_id = instructions.well_id if instructions.well_id else "None"
            status = instructions.status if instructions.status else "None"
            campaign_id = (
                instructions.project_campaign_id
                if instructions.project_campaign_id
                else 0
            )

            video_information = f"""Experiment Info:
ID: {project_id}.{campaign_id}.{exp_id}
Status: {status.value}
Well: {well_id}"""
            label = self.client.get_input_settings("text")
            label.input_settings["text"] = video_information
            # label.input_settings["font"]["size"]=240
            self.client.set_input_settings("text", label.input_settings, True)
            self.logger.info("Experiment information placed on screen.")
        except OBSerror.OBSSDKRequestError as e:
            self.logger.error("Error placing experiment information on screen: %s", e)

    def place_text_on_screen(self, text: str = None):
        """Place the given text on the screen"""
        try:
            if not text:
                text = ""
            label = self.client.get_input_settings("text")
            label.input_settings["text"] = text
            # label.input_settings["font"]["size"]=240
            self.client.set_input_settings("text", label.input_settings, True)
            self.logger.info("Text placed on screen.")
        except Exception as e:
            self.logger.error("Error placing text on screen: %s", e)

    def webcam_on(self):
        """Turn on the webcam"""
        webcam = self.client.get_input_settings("webcam")
        webcam.input_settings["sceneItemEnabled"] = True
        self.client.set_input_settings("Webcam", webcam.input_settings, True)
        self.logger.info("Webcam turned on.")

    def webcam_off(self):
        """Turn off the webcam"""
        webcam = self.client.get_input_settings("webcam")
        webcam.input_settings["sceneItemEnabled"] = False
        self.client.set_input_settings("Webcam", webcam.input_settings, True)
        self.logger.info("Webcam turned off.")

    def start_streaming(self):
        """Start the streaming"""
        self.client.start_stream()
        self.logger.info("Streaming started.")

    def stop_streaming(self):
        """Stop the streaming"""
        self.client.stop_stream()
        self.logger.info("Streaming stopped.")

    def start_recording(self):
        """Start the recording"""
        if read_testing_config():
            return
        try:
            self.client.start_record()
            self.logger.info("Recording started.")
        except Exception as e:
            self.logger.error("Error starting recording: %s", e)

    def stop_recording(self):
        """Stop the recording"""
        if read_testing_config():
            return
        try:
            self.client.stop_record()
            self.logger.info("Recording stopped.")
        except Exception as e:
            self.logger.error("Error stopping recording: %s", e)

    def set_recording_file_name(self, file_name: str):
        """Set the recording file name"""
        record_directory = self.client.get_record_directory()
        return record_directory.record_directory
        # record_name = self.client.get_recor

    # def take_preview_snapshot(self):
    #     """Take a preview snapshot"""
    #     return self.client.get_source_screenshot("Preview", "png")

    def take_snapshot(self, source: str = "Webcam"):
        """Takes a snapshot of the given source and returns a base64 encoded string of the image"""
        try:
            screenshot = self.client.get_source_screenshot(
                source, "png", 1920, 1080, -1
            )
            return screenshot
        except OBSerror.OBSSDKRequestError as e:
            self.logger.error("Failed to take snapshot: %s", e)
            return None

    def change_image(self, new_image_path, source_name: str = "image"):
        try:
            self.client.get_input_settings(source_name)
            self.client.set_input_settings(
                source_name, {"file": str(Path(new_image_path).resolve())}, True
            )
        except OBSerror.OBSSDKRequestError as e:
            self.logger.error("Error changing image: %s", e)


class MockOBSController:
    """This class is used to mock the OBS software for testing"""

    def __init__(self):
        self.logger = logging.getLogger(__name__)

    def place_experiment_on_screen(self, instructions):
        """Place the experiment information on the screen"""
        pass

    def place_text_on_screen(self, text: str = None):
        """Place the given text on the screen"""
        pass

    def webcam_on(self):
        """Turn on the webcam"""
        pass

    def webcam_off(self):
        """Turn off the webcam"""
        pass

    def start_streaming(self):
        """Start the streaming"""
        pass

    def stop_streaming(self):
        """Stop the streaming"""
        pass

    def start_recording(self):
        """Start the recording"""
        pass

    def stop_recording(self):
        """Stop the recording"""
        pass

    def set_recording_file_name(self, file_name: str):
        """Set the recording file name"""
        pass

    def take_snapshot(self, source: str = "Webcam"):
        """Takes a snapshot of the given source and returns a base64 encoded string of the image"""
        pass

    def change_image(self, new_image_path, source_name: str = "image"):
        pass

    def disconnect_from_obs(self):
        """Disconnect from OBS"""
        pass

