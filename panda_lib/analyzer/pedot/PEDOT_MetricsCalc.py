"""For PEDOT films calculates the charge passed during deposition, the capacitance, 
the deposition efficiency, and the electrochromic efficiency."""

# pylint: disable=broad-exception-caught
import math
import re

import pandas as pd
from scipy.integrate import trapezoid

from .pedot_classes import RequiredData, PEDOTMetrics, RawMetrics


def modify_function(value):
    """
    converts the current from amps to milliamps and changes the current column
    to current density for circular wells
    """

    return value * 100000 / (math.pi * 3.25 * 3.25)


def calc_charge(deposition_file):
    """Calculate charge passed using text file for deposition"""
    # Read in the text file
    if deposition_file is None:
        return None
    df = pd.read_csv(
        deposition_file,
        sep=" ",
        header=None,
        names=[
            "Time",
            "Vf",
            "Vu",
            "Im",
            "Q",
            "Vsig",
            "Ach",
            "IERange",
            "Over",
            "StopTest",
        ],
    )
    # Calculate the charge passed by integrating the current over time using the trapezoidal rule
    df_copy = df.copy()
    df_copy["Im"] = df_copy["Im"].apply(modify_function)

    charge = trapezoid(df_copy["Im"], df_copy["Time"])
    return charge


def calc_capacitance(cv_file):
    """Calculate metric for capacitance using CV by finding the area enclosed by the CV curve."""
    if cv_file is None:
        return None
    df = pd.read_csv(
        cv_file,
        sep=" ",
        header=None,
        names=[
            "Time",
            "Vf",
            "Vu",
            "Im",
            "Vsig",
            "Ach",
            "IERange",
            "Overload",
            "StopTest",
            "Cycle",
            "Ach2",
        ],
    )
    df = df.dropna(subset=["Cycle"])
    df["Cycle"] = df["Cycle"].astype(int)
    df_second_cycle = df[df["Cycle"] == 1].copy()

    if len(df_second_cycle) == 0:
        print("No second cycle found")
        return None

    df_second_cycle["Im_mod"] = df_second_cycle["Im"].apply(modify_function)

    min_current = df_second_cycle["Im_mod"].min()
    df_second_cycle["Im_shifted"] = df_second_cycle["Im_mod"] - min_current + 0.0001
    max_voltage_index = df_second_cycle["Vf"].idxmax()

    ascending_df = df_second_cycle.iloc[: max_voltage_index + 1]
    descending_df = df_second_cycle.iloc[max_voltage_index:]
    descending_df = descending_df.iloc[::-1]

    area_ascending = trapezoid(ascending_df["Im_mod"], ascending_df["Vf"])
    area_descending = trapezoid(descending_df["Im_mod"], descending_df["Vf"])
    enclosed_area = abs(area_ascending - area_descending)
    capacitance = enclosed_area
    return capacitance


def calc_bleach_charge(bleach_file):
    """Calculate the charge passed during bleaching using text file for bleaching"""
    if bleach_file is None:
        return None
    df = pd.read_csv(
        bleach_file,
        sep=" ",
        header=None,
        names=[
            "Time",
            "Vf",
            "Vu",
            "Im",
            "Q",
            "Vsig",
            "Ach",
            "IERange",
            "Over",
            "StopTest",
        ],
    )
    df_copy = df.copy()
    df_copy["Im"] = df_copy["Im"].apply(modify_function)
    bleach_charge = abs(trapezoid(df_copy["Im"], df_copy["Time"]))
    return bleach_charge


def calc_dep_eff(charge, capacitance):
    """
    Calculate the deposition efficiency using the charge passed and the
    capacitance of the film.
    """
    dep_eff = charge / capacitance
    return dep_eff


def calc_echromic_eff(bleach_charge, delta_e00):
    """
    Calculate the electrochromic efficiency using the charge passed during
    bleaching and the color change.
    """
    echromic_eff = delta_e00 / bleach_charge
    return echromic_eff


def get_exp_id(filename):
    """Extract the experiment ID from the filename"""
    match = re.search(r"_([0-9]{8})_", filename)
    if match:
        return match.group(1)
    else:
        return None


def process_metrics(metrics: RawMetrics, input_df: RequiredData) -> PEDOTMetrics:
    """
    Process the metrics to calculate the deposition efficiency and
    electrochromic efficiency.
    """
    delta_e00 = metrics.delta_e00

    deposition_file = input_df.CA_deposition
    cv_file = input_df.CV_characterization
    bleach_file = input_df.CA_bleaching

    try:
        charge = None
        capacitance = None
        bleach_charge = None

        try:
            charge = calc_charge(deposition_file)
        except Exception as e:
            print(
                f"Error calculating charge for experiment_ID {input_df.experiment_id}: {e}"
            )

        try:
            capacitance = calc_capacitance(cv_file)
        except Exception as e:
            print(
                f"Error calculating capacitance for experiment_ID {input_df.experiment_id}: {e}"
            )

        try:
            bleach_charge = calc_bleach_charge(bleach_file)
        except Exception as e:
            print(
                f"Error calculating bleach charge for experiment_ID {input_df.experiment_id}: {e}"
            )

        if charge is not None and capacitance:
            dep_eff = calc_dep_eff(charge, capacitance)
        else:
            dep_eff = None
            print(
                f"Deposition efficiency not calculated for experiment_ID {input_df.experiment_id} due to missing data."
            )
        if delta_e00 is not None and bleach_charge is not None:
            echromic_eff = calc_echromic_eff(bleach_charge, delta_e00)
        else:
            echromic_eff = None
            print(
                f"Electrochromic efficiency not calculated for experiment_ID {input_df.experiment_id} due to missing data."
            )

        calculated_metrics = PEDOTMetrics(
            experiment_id=input_df.experiment_id,
            DepositionChargePassed=charge,
            BleachChargePassed=bleach_charge,
            Capacitance=capacitance,
            DepositionEfficiency=dep_eff,
            ElectrochromicEfficiency=echromic_eff,
        )
        print(f"Processed experiment_ID: {input_df.experiment_id}")

    except Exception as e:
        print(f"Unexpected error for experiment_ID {input_df.experiment_id}: {e}")

    return calculated_metrics
