"""Unit tests for the Scheduler class."""
import json
from datetime import datetime
from pathlib import Path
import pandas as pd
import unittest
from unittest.mock import patch

from panda_lib import scheduler
from panda_lib.experiment_class import ExperimentBase, ExperimentStatus, ExperimentResult
from panda_lib.scheduler import Scheduler
from panda_lib import sql_utilities
from panda_lib.sql_tools.sql_system_state import get_current_pin

CURRENT_PIN =  get_current_pin()

