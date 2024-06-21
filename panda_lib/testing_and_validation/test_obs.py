import unittest
from panda_lib.obs_controls import OBSController
import time
from pathlib import Path

class TestOBSController(unittest.TestCase):

    def setUp(self):
        self.obs_controller = OBSController()

    def tearDown(self):
        self.obs_controller.disconnect_from_obs()  # Disconnect from OBS

    # def test_place_experiment_on_screen(self):
    #     instructions = ExperimentBase()
    #     self.obs_controller.place_experiment_on_screen(instructions)
    #     # Add your assertions here

    def test_place_text_on_screen(self):
        text = "Sample text"
        self.obs_controller.place_text_on_screen(text)

        time.sleep(5)
        text = "Sample text 2"
        self.obs_controller.place_text_on_screen(text)
        # Add your assertions here

    # def test_webcam_on(self):
    #     self.obs_controller.webcam_on()
    #     # Add your assertions here

    # def test_webcam_off(self):
    #     self.obs_controller.webcam_off()
    #     # Add your assertions here

    # def test_start_streaming(self):
    #     self.obs_controller.start_streaming()
    #     # Add your assertions here

    # def test_stop_streaming(self):
    #     self.obs_controller.stop_streaming()
    #     # Add your assertions here

    # def test_start_recording(self):
    #     self.obs_controller.start_recording()
    #     # Add your assertions here

    # def test_stop_recording(self):
    #     self.obs_controller.stop_recording()
    #     # Add your assertions here

    # def test_set_recording_file_name(self):
    #     file_name = "testing\\test_image.png"
    #     result = self.obs_controller.set_recording_file_name(file_name)
    #     self.assertEqual(result, "testing\\test_image.png")
    def test_change_image(self):
        file_path = Path("testing\\test_image.png")
        source_name = "image"
        self.obs_controller.change_image(file_path, source_name)
        time.sleep(5)
        file_path = Path("testing\\test_image_2.png")
        source_name = "image"
        self.obs_controller.change_image(file_path,source_name)
        # Add your assertions here
if __name__ == "__main__":
    unittest.main()
