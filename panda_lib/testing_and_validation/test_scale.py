"""This test takes datapoints from the connected scale overtime to see how stable the readings are"""
import datetime
import logging
import os
import sys
import time

import matplotlib.pyplot as plt
import numpy as np
from config.config import PATH_TO_DATA, PATH_TO_LOGS
from sartorius_local import Scale
from sartorius_local.mock import Scale as MockScale
from tqdm import tqdm

scale_logger = logging.getLogger(__name__)
scale_logger.setLevel(logging.DEBUG)
formatter = logging.Formatter("%(asctime)s:%(name)s:%(levelname)s:%(message)s")
system_handler = logging.FileHandler(PATH_TO_LOGS / "scale_testing.log")
system_handler.setFormatter(formatter)
scale_logger.addHandler(system_handler)
console_logger = logging.StreamHandler()
console_logger.setLevel(logging.INFO)
console_logger.setFormatter(logging.Formatter("%(levelname)s:%(message)s"))
scale_logger.addHandler(console_logger)


def scale_variance_check(mock: bool = False, test_name: str = "scale_testing"):
    """
    Log multiple series of reading from the scale to determine the variance in the readings.

    Check will consist of three regimes:
    10s between readings
    5s between readings
    1s between readings

    """
    if mock:
        scale = MockScale()
    else:
        scale = Scale("COM6")

    scale_logger.info("Starting scale variance check")
    scale_logger.info("Current working directory: %s", os.getcwd())
    scale_logger.info("Python version: %s", sys.version)
    scale_logger.info("Scale firmware: %s", scale.get_info())
    scale_logger.info("Time: %s", datetime.datetime.now())
    scale_logger.info("Mock: %s", mock)

    regimes = [(10, 60), (5, 120), (3, 200)]
    arrays = []

    for interval, num_readings in regimes:
        scale_logger.debug("Creating %ss array", interval)
        data_array = np.zeros(num_readings)

        scale_logger.debug("Starting %ss loop", interval)
        for i in tqdm(range(num_readings)):
            data_array[i] = scale.read_scale()
            time.sleep(interval)
        scale_logger.debug("%ss loop complete", interval)

        arrays.append(data_array)

    plt.figure()
    for i, (interval, _) in enumerate(regimes):
        plt.subplot(3, 1, i+1)
        plt.plot(arrays[i])
        plt.title("%ss between readings", interval)
        plt.ylabel("Reading (g)")
    plt.xlabel("Reading number")
    plt.subplots_adjust(hspace=0.5)
    plt.savefig("scale_testing.png")
    plt.show()
    plt.subplots_adjust(hspace=0.5)

    variances = [np.var(data_array) for data_array in arrays]

    for i, (interval, _) in enumerate(regimes):
        scale_logger.info("%ss variance: %s", interval, variances[i])

    scale_logger.debug("Variance written to log")

    for i, (interval, _) in enumerate(regimes):
        np.savetxt(
            PATH_TO_DATA / f"{test_name}_{interval}s_array.txt",
            arrays[i],
        )

    scale_logger.info("Scale variance check complete")
