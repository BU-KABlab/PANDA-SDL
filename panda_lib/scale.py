# -*- coding: utf-8 -*-

"""
Python Interface for
Sartorius Serial Interface for
EA, EB, GD, GE, TE scales.

2010-2011 Robert Gieseke - robert.gieseke@gmail.com
See LICENSE.
"""

import logging
import random
import serial
import time
from tqdm import tqdm
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import datetime
import os
import sys

scale_logger = logging.getLogger(__name__)
scale_logger.setLevel(logging.DEBUG)  # change to INFO to reduce verbosity
formatter = logging.Formatter("%(asctime)s:%(name)s:%(levelname)s:%(message)s")
system_handler = logging.FileHandler("code/logs/scale_testing.log")
system_handler.setFormatter(formatter)
scale_logger.addHandler(system_handler)

class Sartorius(serial.Serial):
    """
    Sartorius Serial Interface for
    EA, EB, GD, GE, TE scales.
    """
    def __init__(self, com_port: str = 'COM6'):
        """
        Initialise Sartorius device.

            Example:
            scale = Sartorius('COM1')
        """
        serial.Serial.__init__(self, com_port)
        self.baudrate = 9600
        self.bytesize = 7
        self.parity = serial.PARITY_ODD
        self.timeout = 0.5

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()

    def value(self):
        """
        Return displayed scale value.
        """
        try:
            if self.inWaiting() == 0:
                self.write(b'\033P\n')
            response = self.readline().decode()
            if len(response) != 22:
                raise Exception("corrupted reponse")
            else: # menu code 7.1.2
                value = float(response[6:16].replace(' ', ''))
                units = response[17:20].replace(' ', '')
                if units is None:
                    value, units = self.value()
            return round(value,4), units
        except Exception as e:
            return "NA"

    def display_unit(self):
        """
        Return unit.
        """
        self.write(b'\033P\n')
        answer = self.readline()
        try:
            answer = answer[11].strip()
        except:
            answer = "No answer"
        return answer

    def tara_zero(self):
        """
        Tara and zeroing combined.
        """
        self.write(b'\033T\n')

    def tara(self):
        """
        Tara.
        """
        self.write(b'\033U\n')

    def zero(self):
        """
        Zero.
        """
        self.write(b'\033V\n')


class MockSartorius:
    """
    Mock Sartorius Serial Interface for
    EA, EB, GD, GE, TE scales.
    """
    def __init__(self):
        """
        Initialise Sartorius device.

            Example:
            scale = Sartorius('COM1')
        """

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()

    def value(self):
        """
        Return displayed scale value.
        """
        return random.uniform(-10, 10)

    def display_unit(self):
        """
        Return unit.
        """
        return "g"

    def tara_zero(self):
        """
        Tara and zeroing combined.
        """

    def tara(self):
        """
        Tara.
        """

    def zero(self):
        """
        Zero.
        """

    def close(self):
        """
        Close connection.
        """

def scale_variance_check(mock: bool = False):
    """
    Log multiple series of reading from the scale to determine the variance in the readings. 

    Check will consist of three regimes:
    10s between readings    
    5s between readings
    1s between readings

    """
    scale_logger.info("Starting scale variance check")
    scale_logger.info("Current working directory: %s", os.getcwd())
    scale_logger.info("Python version: %s", sys.version)
    scale_logger.info("Numpy version: %s", np.__version__)
    scale_logger.info("Matplotlib version: %s", matplotlib.__version__)
    scale_logger.info("Time: %s", datetime.datetime.now().isoformat(timespec="seconds"))
    scale_logger.info("Mock: %s", mock)
    scale_logger.info("Test 05 | Apparent filter = final readout | plate type 5")

    scale_logger.info("Creating scale object")
    if mock:
        scale = MockSartorius()
    else:
        scale = Sartorius('COM6')
    scale_logger.info("Scale object created")

    #scale_logger.info("Taring scale")
    #scale.tara()
    #time.sleep(60)
    #scale_logger.info("Scale tared")

    scale_logger.info("Creating data arrays")
    scale_logger.info("Creating 10s array")
    ten_sec_array = np.zeros(60)
    scale_logger.info("Creating 5s array")
    five_sec_array = np.zeros(120)
    scale_logger.info("Creating 3s array")
    three_sec_array = np.zeros(200)

    scale_logger.info("Data arrays created")

    scale_logger.info("Starting 10s loop")
    for i in tqdm(range(60)):
        ten_sec_array[i] = scale.value()[0]
        time.sleep(10)
    scale_logger.info("10s loop complete")

    time.sleep(10)

    scale_logger.info("Starting 5s loop")
    for i in tqdm(range(120)):
        five_sec_array[i] = scale.value()[0]
        time.sleep(5)
    scale_logger.info("5s loop complete")

    time.sleep(10)

    scale_logger.info("Starting 3s loop")
    for i in tqdm(range(200)):
        three_sec_array[i] = scale.value()[0]
        time.sleep(3)
    scale_logger.info("3s loop complete")

    scale_logger.info("Closing scale object")
    scale.close()
    scale_logger.info("Scale object closed")

    scale_logger.info("Plotting data")
    plt.figure()
    plt.subplot(3,1,1)
    plt.plot(ten_sec_array)
    plt.title("10s between readings")
    plt.ylabel("Reading (g)")
    plt.subplot(3,1,2)
    plt.plot(five_sec_array)
    plt.title("5s between readings")
    plt.ylabel("Reading (g)")
    plt.subplot(3,1,3)
    plt.plot(three_sec_array)
    plt.title("3s between readings")
    plt.ylabel("Reading (g)")
    plt.xlabel("Reading number")
    plt.subplots_adjust(hspace=0.5)
    plt.savefig("data/scale_testing_05_appfilt_finalrd_platetype5.png")
    plt.show()
    plt.subplots_adjust(hspace=0.5)
    scale_logger.info("Plotting complete")

    scale_logger.info("Calculating variance")
    ten_sec_variance = np.var(ten_sec_array)
    five_sec_variance = np.var(five_sec_array)
    three_sec_variance = np.var(three_sec_array)
    scale_logger.info("Variance calculated")

    scale_logger.info("Writing variance to log")
    scale_logger.info("10s variance: %s", ten_sec_variance)
    scale_logger.info("5s variance: %s", five_sec_variance)
    scale_logger.info("3s variance: %s", three_sec_variance)
    scale_logger.info("Variance written to log")

    scale_logger.info("Saving data to file")
    np.savetxt("data/scale_testing_05_appfilt_finalrd_platetype5_ten_sec.txt", ten_sec_array)
    np.savetxt("data/scale_testing_05_appfilt_finalrd_platetype5_five_sec.txt", five_sec_array)
    np.savetxt("data/scale_testing_05_appfilt_finalrd_platetype5_three_sec.txt", three_sec_array)
    scale_logger.info("Scale variance check complete")

def function_test(mock: bool = False):
    """
    Test scale functions.
    """
    if mock:
        scale = MockSartorius()
    else:
        scale = Sartorius('COM6')
    scale_logger.info("Scale object created")
    sartorius_scale = scale
    print(sartorius_scale.value())
    print(sartorius_scale.display_unit())
    sartorius_scale.tara_zero()
    print(sartorius_scale.value())
    sartorius_scale.tara()
    print(sartorius_scale.value())
    sartorius_scale.zero()
    print(sartorius_scale.value())
    sartorius_scale.close()

if __name__ == '__main__':
    scale_variance_check(mock=False)
    # scale = Sartorius('COM6')
    # print(scale.value())
