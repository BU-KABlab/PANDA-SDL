"""
Methods and classses related to logging for the ePANDA project
"""
import logging
from .config.config import EPANDA_LOG
e_panda_logger = logging.getLogger("ePANDA")
e_panda_logger.setLevel(logging.DEBUG)  # change to INFO to reduce verbosity
formatter = logging.Formatter(
    "%(asctime)s&%(name)s&%(levelname)s&%(module)s&%(funcName)s&%(lineno)d&&&&%(message)s&"
)
system_handler = logging.FileHandler(EPANDA_LOG)
system_handler.setFormatter(formatter)
e_panda_logger.addHandler(system_handler)
console_logger = logging.StreamHandler()
console_logger.setLevel(logging.INFO)
e_panda_logger.addHandler(console_logger)


class CustomLoggingFilter(logging.Filter):
    """This is a filter which injects custom values into the log record.
    From: https://stackoverflow.com/questions/56776576/how-to-add-custom-values-to-python-logging
    The values will be the experiment id and the well id
    """

    def __init__(self, custom1, custom2, custom3,custom4):
        super().__init__()
        self.custom1 = custom1
        self.custom2 = custom2
        self.custom3 = custom3
        self.custom4 = custom4

    def filter(self, record):
        record.custom1 = self.custom1
        record.custom2 = self.custom2
        record.custom3 = self.custom3
        record.custom4 = self.custom4
        return True
