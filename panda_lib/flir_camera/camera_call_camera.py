"""running pycapture-test.py from python 3.11"""

# Call pycapture-test.py from python 3.11 using python 3.6 envrionment using subprocess
# import subprocess
# from pathlib import Path
# file_path = Path(r"code\camera-pycapture-test.py")
# env_path = Path("C:\\Users\\Kab Lab\\anaconda3\\envs\\python360\\python.exe")
# subprocess.run([env_path, file_path], check= False, shell = True)

import subprocess
from pathlib import Path
from panda_lib.config.config import PATH_TO_DATA, PYTHON_360_PATH, CAMERA_SCRIPT_PATH

def capture_new_image(save=True, num_images=1, file_name:Path=Path("images/test.tiff")) -> None:
    """Capture a new image from the camera"""
    # Path to the Python interpreter
    python_360_path = PYTHON_360_PATH

    # Path to the script to run
    script_path = CAMERA_SCRIPT_PATH

    if file_name.suffix != ".tiff":
        file_name = file_name.with_suffix(".tiff")
    # Start a new process with the Python interpreter
    subprocess.run(
        [
            python_360_path,
            script_path,
            "--save",
            str(save),
            "--num_images",
            str(num_images),
            "--save_path",
            str(file_name.parent),
            "--file_name",
            str(file_name.name),
        ],
        check=False,
        shell=True,
    )

if __name__ == "__main__":
    FILE_NAME =  "test image"
    file_path=Path(PATH_TO_DATA / str(FILE_NAME)).with_suffix(".png")
    i=1
    while file_path.exists():
        file_path = file_path.with_name(file_path.stem + "_" + str(i) + file_path.suffix)
        i+=1
    capture_new_image(
        save=True, num_images=1, file_name=file_path
    )
