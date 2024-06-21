"""A class to hold all of the instruments"""
from dataclasses import dataclass
from logging import Logger
from typing import Union

from panda_lib.mill_control import Mill, MockMill
from panda_lib.syringepump import MockPump, SyringePump
from panda_lib.sartorius_local import Scale
from panda_lib.sartorius_local.mock import Scale as MockScale
import panda_lib.wellplate as wp


@dataclass
class Toolkit:
    """A class to hold all of the instruments"""

    mill: Union[Mill, MockMill]
    scale: Union[Scale, MockScale]
    pump: Union[SyringePump, MockPump]
    wellplate: wp.Wellplate = None
    global_logger: Logger = None
    experiment_logger: Logger = None
