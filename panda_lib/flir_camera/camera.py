#!/c:/Users/Kab Lab/anaconda3/envs/python360/python.exe
"""
Requires the PyCapture2 library to be installed and run in a python 3.6 environment.
This script is used to capture images from the FLIR camera.
"""

import argparse
import logging
import sys
from pathlib import Path


import PyCapture2


PATH_TO_LOGS = Path("epanda_lib/logs")


class FLIRCamera:
    """Class to control the FLIR camera"""

    def __init__(self, print_to_console: bool = True):
        self.camera = None
        self.bus = None
        self.num_cams = None
        self.uid = None
        self.camera_logger: logging.Logger = logging.getLogger("FLIRCamera")
        self.capturing = False
        self.print_to_console: bool = print_to_console

        # Set up logging
        self.camera_logger.setLevel(
            logging.INFO if self.print_to_console else logging.DEBUG
        )
        ch = logging.StreamHandler()
        ch.setLevel(logging.INFO if self.print_to_console else logging.DEBUG)
        formatter = logging.Formatter(
            "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        )
        ch.setFormatter(formatter)
        self.camera_logger.addHandler(ch)

        ch = logging.FileHandler(PATH_TO_LOGS / "camera.log")
        ch.setLevel(logging.DEBUG)
        ch.setFormatter(formatter)
        self.camera_logger.addHandler(ch)

    def __enter__(self):
        self.connect()
        self.epanda_camera_profile()
        return self

    def __exit__(self, exc_type=None, exc_value=None, traceback=None):
        self.disconnect()

    def connect(self):
        """Connect to the first camera found on the bus"""
        # Ensure sufficient cameras are found
        self.bus = PyCapture2.BusManager()
        self.num_cams = self.bus.getNumOfCameras()
        self.camera_logger.debug("Number of cameras detected: %d", self.num_cams)
        if not self.num_cams:
            self.camera_logger.debug("Insufficient number of cameras. Exiting...")
            sys.exit()

        # Select camera on 0th index
        self.camera = PyCapture2.Camera()
        self.uid = self.bus.getCameraFromIndex(0)
        self.camera.connect(self.uid)
        self.print_camera_info()

        # Enable camera embedded timestamp
        self.enable_embedded_timestamp(True)

        self.camera_logger.debug("Starting image capture...")
        self.camera.startCapture()

    def disconnect(self):
        """Disconnect the camera"""
        # Disable camera embedded timestamp
        self.camera.stopCapture()
        self.enable_embedded_timestamp(False)
        self.camera.disconnect()

    def print_build_info(self):
        """Prints PyCapture2 Library Information"""
        lib_ver = PyCapture2.getLibraryVersion()
        self.camera_logger.debug(
            "PyCapture2 library version: %d %d %d %d",
            lib_ver[0],
            lib_ver[1],
            lib_ver[2],
            lib_ver[3],
        )
        self.camera_logger.debug()

    def print_camera_info(self):
        """Prints camera details"""
        cam_info = self.camera.getCameraInfo()
        self.camera_logger.debug("\n*** CAMERA INFORMATION ***\n")
        self.camera_logger.debug("Serial number - %d", cam_info.serialNumber)
        self.camera_logger.debug("Camera model - %s", cam_info.modelName)
        self.camera_logger.debug("Camera vendor - %s", cam_info.vendorName)
        self.camera_logger.debug("Sensor - %s", cam_info.sensorInfo)
        self.camera_logger.debug("Resolution - %s", cam_info.sensorResolution)
        self.camera_logger.debug("Firmware version - %s", cam_info.firmwareVersion)
        self.camera_logger.debug("Firmware build time - %s", cam_info.firmwareBuildTime)

    def enable_embedded_timestamp(self, enable_timestamp):
        """Enables/Disables embedded timestamp"""
        embedded_info = self.camera.getEmbeddedImageInfo()
        if embedded_info.available.timestamp:
            self.camera.setEmbeddedImageInfo(timestamp=enable_timestamp)
            if enable_timestamp:
                self.camera_logger.debug("\nTimeStamp is enabled.\n")
            else:
                self.camera_logger.debug("\nTimeStamp is disabled.\n")

    def grab_images(
        self, num_images_to_grab, save=False, save_path=None, save_name=None
    ):
        """Grabs images from the camera"""
        prev_ts = None
        cam = self.camera
        image: PyCapture2.Image = None
        for _ in range(num_images_to_grab):
            try:
                image = cam.retrieveBuffer()
            except PyCapture2.Fc2error as fc2_err:
                self.camera_logger.debug("Error retrieving buffer : %s", fc2_err)
                continue

            ts = image.getTimeStamp()
            if prev_ts:
                diff = (ts.cycleSeconds - prev_ts.cycleSeconds) * 8000 + (
                    ts.cycleCount - prev_ts.cycleCount
                )
                self.camera_logger.debug(
                    "Timestamp [ %d %d ] - %d", ts.cycleSeconds, ts.cycleCount, diff
                )
            prev_ts = ts

        newimg = image.convert(PyCapture2.PIXEL_FORMAT.BGR)
        if save:
            if save_path is None:
                save_path = ""
            if save_name is None:
                save_name = "fc2TestImage.png"
            self.camera_logger.debug("Saving the last image to %s", save_name)
            newimg.save(
                (save_path + "\\" + save_name).encode("utf-8"),
                PyCapture2.IMAGE_FILE_FORMAT.TIFF,
            )
        return newimg

    def set_brightness(self, brightness):
        """Sets the brightness for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.BRIGHTNESS
            brightness_property = self.camera.getProperty(prop)
            brightness_property.absControl = True
            brightness_property.absValue = brightness
            self.camera.setProperty(brightness_property)
            self.camera_logger.debug("Brightness set to: %d", brightness)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting brightness: %s", fc2_err)

    def set_exposure(self, exposure_time):
        """Sets the exposure time for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.AUTO_EXPOSURE
            auto_exposure = self.camera.getProperty(prop)
            auto_exposure.autoManualMode = False
            auto_exposure.absControl = True
            auto_exposure.onOff = True
            auto_exposure.autoManualMode = False
            auto_exposure.absValue = exposure_time
            self.camera.setProperty(auto_exposure)
            self.camera_logger.debug("Exposure time set to: %d", exposure_time)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting exposure time: %s", fc2_err)

    def set_sharpness(self, sharpness):
        """Sets the sharpness for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.SHARPNESS
            sharpness_property = self.camera.getProperty(prop)
            sharpness_property.absControl = True
            sharpness_property.absValue = sharpness
            self.camera.setProperty(sharpness_property)
            self.camera_logger.debug("Sharpness set to: %d", sharpness)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting sharpness: %s", fc2_err)

    def set_hue(self, hue):
        """Sets the hue for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.HUE
            hue_property = self.camera.getProperty(prop)
            hue_property.absControl = True
            hue_property.absValue = hue
            self.camera.setProperty(hue_property)
            self.camera_logger.debug("Hue set to: %d", hue)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting hue: %s", fc2_err)

    def set_saturation(self, saturation):
        """Sets the saturation for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.SATURATION
            saturation_property = self.camera.getProperty(prop)
            saturation_property.absControl = True
            saturation_property.absValue = saturation
            self.camera.setProperty(saturation_property)
            self.camera_logger.debug("Saturation set to: %d", saturation)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting saturation: %s", fc2_err)

    def set_gamma(self, gamma):
        """Sets the gamma for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.GAMMA
            gamma_property = self.camera.getProperty(prop)
            gamma_property.absControl = True
            gamma_property.onOff = True
            gamma_property.absValue = gamma
            self.camera.setProperty(gamma_property)
            self.camera_logger.debug("Gamma set to: %d", gamma)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting gamma: %s", fc2_err)

    def set_shutter(self, shutter):
        """Sets the shutter for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.SHUTTER
            shutter_property = self.camera.getProperty(prop)
            shutter_property.absControl = True
            shutter_property.onOff = True
            shutter_property.autoManualMode = False
            shutter_property.absValue = shutter
            self.camera.setProperty(shutter_property)
            self.camera_logger.debug("Shutter set to: %d", shutter)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting shutter: %s", fc2_err)

    def set_gain(self, gain):
        """Sets the gain for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.GAIN
            gain_property = self.camera.getProperty(prop)
            gain_property.absControl = True
            gain_property.onOff = True
            gain_property.autoManualMode = False
            gain_property.absValue = gain
            self.camera.setProperty(gain_property)
            self.camera_logger.debug("Gain set to: %d", gain)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting gain: %s", fc2_err)

    def set_framerate(self, framerate):
        """Sets the framerate for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.FRAME_RATE
            framerate_property = self.camera.getProperty(prop)
            framerate_property.absControl = True
            framerate_property.onOff = True
            framerate_property.autoManualMode = False
            framerate_property.absValue = framerate
            self.camera.setProperty(framerate_property)
            self.camera_logger.debug("Framerate set to: %d", framerate)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting framerate: %s", fc2_err)

    def set_white_balance(self, red, blue):
        """Sets the white balance for the camera"""
        try:
            prop = PyCapture2.PROPERTY_TYPE.WHITE_BALANCE
            wb = self.camera.getProperty(prop)
            wb.onOff = True
            wb.absControl = False
            wb.autoManualMode = False
            wb.valueA = red
            wb.valueB = blue
            self.camera.setProperty(wb)
            self.camera_logger.debug("White balance set to: %d %d", red, blue)
        except PyCapture2.Fc2error as fc2_err:
            self.camera_logger.debug("Error setting white balance: %s", fc2_err)

    def epanda_camera_profile(self):
        """Camera settings for the epanda profile"""
        self.camera_logger.debug("Turning off auto settings...")
        self.set_brightness(12.012)
        self.set_exposure(1.392)
        self.set_sharpness(1024)
        self.set_hue(0.0)
        self.set_saturation(100)
        self.set_gamma(1.250)
        self.set_shutter(50.023)
        self.set_gain(0.0)
        self.set_framerate(5)
        self.set_white_balance(762, 813)
        self.enable_embedded_image_info()

    def enable_embedded_image_info(self):
        """Enable embedding of various camera settings"""
        embedded_info = self.camera.getEmbeddedImageInfo()
        if embedded_info.available.timestamp:
            self.camera.setEmbeddedImageInfo(timestamp=True)
        else:
            print("Timestamp is not available.")

        if embedded_info.available.frameCounter:
            self.camera.setEmbeddedImageInfo(frameCounter=True)
        else:
            print("Frame counter is not available.")

        if embedded_info.available.gain:
            self.camera.setEmbeddedImageInfo(gain=True)
        else:
            print("Gain is not available.")

        if embedded_info.available.shutter:
            self.camera.setEmbeddedImageInfo(shutter=True)
        else:
            print("Shutter is not available.")

        if embedded_info.available.brightness:
            self.camera.setEmbeddedImageInfo(brightness=True)
        else:
            print("Brightness is not available.")

        if embedded_info.available.exposure:
            self.camera.setEmbeddedImageInfo(exposure=True)
        else:
            print("Exposure is not available.")

        if embedded_info.available.whiteBalance:
            self.camera.setEmbeddedImageInfo(whiteBalance=True)
        else:
            print("White balance is not available.")

        if embedded_info.available.ROIPosition:
            self.camera.setEmbeddedImageInfo(ROIPosition=True)
        else:
            print("ROI position is not available.")

    def get_stats(self) -> dict:
        """camera.getStats() -> cameraStats"""
        return self.camera.getStats()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process some integers.")

    parser.add_argument(
        "--num_images", type=int, default=1, help="Number of images to grab"
    )
    parser.add_argument(
        "--save", type=bool, default=False, help="Whether to save the image"
    )
    parser.add_argument(
        "--save_path", type=str, default="images/", help="Path to save the image"
    )

    parser.add_argument(
        "--file_name", type=str, default="test.tiff", help="Name of the file to save"
    )

    parser.add_argument(
        "--print_to_console", type=bool, default=True, help="Print to console"
    )

    args = parser.parse_args()
    logging.basicConfig(level=logging.DEBUG)
    with FLIRCamera() as camera:
        camera.grab_images(
            num_images_to_grab=int(args.num_images),
            save=True,
            save_path=args.save_path,
            save_name=args.file_name,
        )
