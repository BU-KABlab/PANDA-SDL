"""
Gausian Process ML Model for optimal PEDOT electrodeposition
Verion 8
Author: Harley Quinn
Date: 2024-05-02 
"""

import math

# pylint: disable=line-too-long
import os
from pathlib import Path

import gpytorch
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import torch
from gpytorch.distributions import MultivariateNormal
from gpytorch.kernels import RBFKernel, ScaleKernel
from gpytorch.means import ConstantMean
from gpytorch.models import ExactGP
from scipy.interpolate import griddata
from scipy.stats import qmc
from sklearn.metrics import mean_squared_error

# from tqdm.notebook import tqdm #use in jupyter notebook
from tqdm import tqdm  # use in vscode

from panda_lib.experiment_class import (
    ExperimentResultsRecord,
    insert_experiment_results,
)
from panda_lib.analyzer.pedot.sql_ml_functions import (
    model_iteration,
    select_best_test_points,
    select_best_test_points_by_model_id,
    select_best_test_points_by_experiment_id,
    insert_best_test_point,
    select_ml_training_data,
    insert_ml_training_data,
    execute_sql_command,
)


def main(
    training_file_path,
    model_base_path,
    counter_file_path,
    BestTestPointsCSV,
    contourplots_path,
    experiment_id: int = 0,
) -> tuple[float, float, float, float, float, int]:
    """Main function for the PEDOT ML model.

    Args:
    -------
        training_file_path: The path to the training data file.
        model_base_path: The base path for the model files.
        counter_file_path: The path to the file that stores the counter for the model files.
        BestTestPointsCSV: The path to the file that stores the best test points.
        contourplots_path: The path to save the contour plots.

    Returns:
    -------
        tuple(v_dep, t_dep, edot_concentration, predicted_mean, predicted_stddev, model_id)

    """

    # Best parameters when creating the model from scratch
    # lengthscale = 4.440890500793454
    # noise = 0.4852273827820476
    # lr = 0.07184898163805888
    # outputscale = 6.444085436313317
    model_id = None

    class GPModel(ExactGP):
        """Gaussian Process model for the PEDOT electrodeposition."""

        def __init__(
            self,
            train_x,
            train_y,
            likelihood,
            lengthscale=1.0,
            outputscale=1.0,
            noise=0.1,
        ):
            super(GPModel, self).__init__(train_x, train_y, likelihood)
            self.mean_module = ConstantMean()
            self.covar_module = ScaleKernel(RBFKernel(ard_num_dims=3))
            self.covar_module.base_kernel.lengthscale = lengthscale
            self.covar_module.outputscale = outputscale
            self.likelihood.noise = noise

        def forward(self, x):
            mean_x = self.mean_module(x)
            covar_x = self.covar_module(x)
            return MultivariateNormal(mean_x, covar_x)

    # def read_counter(file_path):
    #     """Read the counter from the file."""
    #     # try:
    #     #     with open(file_path, "r") as file:
    #     #         return int(file.read().strip())
    #     # except FileNotFoundError:
    #     #     return 0

    #def update_counter(file_path, counter):
        #"""Update the counter in the file."""
        # with open(file_path, "w") as file:
        #     file.write(str(counter))

    def load_model(base_path, counter_file, train_x, train_y):
        """Load the model from a file."""
        counter = model_iteration()
        load_filename = f"{base_path}_{counter}.pth"
        if not os.path.exists(load_filename):
            raise FileNotFoundError(
                f"No model found at {load_filename}. Check the model path or counter."
            )
        try:
            saved_state = torch.load(load_filename)
            likelihood = gpytorch.likelihoods.GaussianLikelihood()
            model = GPModel(train_x, train_y, likelihood)
            model.load_state_dict(saved_state["model_state_dict"])
            likelihood.load_state_dict(saved_state["likelihood_state_dict"])
            lr = saved_state["learning_rate"]
            return model, likelihood, lr
        except Exception as e:
            print(f"An error occurred while loading model: {e}")
            return None, None, None

    def save_model(model, optimizer, base_path, counter_file):
        """Save the model to a file and increment the counter."""
        counter = model_iteration()
        new_counter = counter + 1
        filename = f"{base_path}_{new_counter}.pth"
        torch.save(
            {
                "model_state_dict": model.state_dict(),
                "optimizer_state_dict": optimizer.state_dict(),
                "likelihood_state_dict": model.likelihood.state_dict(),
                "learning_rate": optimizer.param_groups[0]["lr"],
            },
            filename,
        )
        #update_counter(counter_file, new_counter)
        return filename, new_counter

    def get_next_filename(base_path, extensions):
        """Functions to increment the filenames"""
        counter = 1
        while True:
            exists = False
            for ext in extensions:
                if os.path.exists(f"{base_path}_{counter}.{ext}"):
                    exists = True
                    break
            if not exists:
                return f"{base_path}_{counter}"
            counter += 1

    # Scale inputs to the desired ranges
    def scale_inputs(
        x,
        voltage_bounds,
        time_bounds,
        concentration_bounds,
        voltage_target,
        time_target,
        concentration_target,
    ):
        voltage, time, concentration = x[:, 0], x[:, 1], x[:, 2]

        voltage_scaled = voltage_target[0] + (
            (voltage - voltage_bounds[0])
            * (voltage_target[1] - voltage_target[0])
            / (voltage_bounds[1] - voltage_bounds[0])
        )

        time_scaled = time_target[0] + (
            (np.vectorize(math.log)(time) - math.log(time_bounds[0]))
            * (time_target[1] - time_target[0])
            / (math.log(time_bounds[1]) - math.log(time_bounds[0]))
        )

        concentration_scaled = concentration_target[0] + (
            (np.vectorize(math.log)(concentration) - math.log(concentration_bounds[0]))
            * (concentration_target[1] - concentration_target[0])
            / (math.log(concentration_bounds[1]) - math.log(concentration_bounds[0]))
        )

        x_scaled = np.stack((voltage_scaled, time_scaled, concentration_scaled), axis=1)
        return x_scaled

    def convert_back_to_original(
        best_test_point_scaled,
        voltage_original=(0.6, 1.8),
        time_original=(1, 200),
        concentration_original=(0.01, 0.1),
        voltage_target=(0, 1),
        time_target=(0, 1),
        concentration_target=(0, 1),
    ):

        voltage = voltage_original[0] + (
            (best_test_point_scaled[0] - voltage_target[0])
            * (voltage_original[1] - voltage_original[0])
            / (voltage_target[1] - voltage_target[0])
        )

        time_scaled_back = time_target[0] + (
            (best_test_point_scaled[1] - time_target[0])
            * (time_target[1] - time_target[0])
            / (time_target[1] - time_target[0])
        )
        time = math.log(time_original[0]) + (
            time_scaled_back * (math.log(time_original[1]) - math.log(time_original[0]))
        )
        time = math.exp(time)

        concentration_scaled_back = concentration_target[0] + (
            (best_test_point_scaled[2] - concentration_target[0])
            * (concentration_target[1] - concentration_target[0])
            / (concentration_target[1] - concentration_target[0])
        )
        concentration = math.log(concentration_original[0]) + (
            concentration_scaled_back
            * (
                math.log(concentration_original[1])
                - math.log(concentration_original[0])
            )
        )
        concentration = math.exp(concentration)

        return np.array([voltage, time, concentration])

    # Import training data and convert to Pytorch tensors
    data_df = select_ml_training_data()
    # data_df = pd.read_csv(training_file_path)
    voltage = data_df["voltage"].values
    time = data_df["time"].values
    concentration = data_df["concentration"].values
    response = data_df["deltaE"].values
    # bleachCP = data_df['bleachCP'].values

    original_data = np.stack((voltage, time, concentration), axis=1)
    # x_scaled = scale_inputs(original_data, voltage_bounds=(0.6, 1.8), time_bounds=(1, 200), concentration_bounds=(0.01, 0.1),
    #                        voltage_target=(0,1), time_target=(0,1), concentration_target=(0,1))

    def train_model(model, likelihood, optimizer, train_x, train_y, training_iter):
        model.train()
        likelihood.train()
        # best_model = model.state_dict()
        losses = []

        for _ in tqdm(range(training_iter), desc="Training"):
            optimizer.zero_grad()
            output = model(train_x)
            loss = -mll(output, train_y)
            loss.backward()
            optimizer.step()
            losses.append(loss.item())

    n_data = len(response)
    predictions = np.zeros(n_data)
    actuals = np.zeros(n_data)
    best_validation_rmse = float("inf")
    # best_model = None
    previous_rmse = float("inf")

    for i in tqdm(range(n_data)):
        train_indices = list(set(range(n_data)) - {i})
        test_index = i

        x_train, y_train = original_data[train_indices], response[train_indices]
        x_test, y_test = (
            original_data[test_index : test_index + 1],
            response[test_index : test_index + 1],
        )

        # Scale inputs
        x_train_scaled = scale_inputs(
            x_train,
            voltage_bounds=(0.6, 1.8),
            time_bounds=(1, 200),
            concentration_bounds=(0.01, 0.1),
            voltage_target=(0, 1),
            time_target=(0, 1),
            concentration_target=(0, 1),
        )
        x_test_scaled = scale_inputs(
            x_test,
            voltage_bounds=(0.6, 1.8),
            time_bounds=(1, 200),
            concentration_bounds=(0.01, 0.1),
            voltage_target=(0, 1),
            time_target=(0, 1),
            concentration_target=(0, 1),
        )

        # Convert to PyTorch tensors
        train_x = torch.tensor(x_train_scaled, dtype=torch.float32)
        train_y = torch.tensor(y_train, dtype=torch.float32)
        test_x = torch.tensor(x_test_scaled, dtype=torch.float32)
        test_y = torch.tensor(y_test, dtype=torch.float32)

        # Set hyperparameters and call model
        # likelihood = gpytorch.likelihoods.GaussianLikelihood(noise=torch.tensor(noise))
        # model = GPModel(train_x, train_y, likelihood, lengthscale=lengthscale, outputscale=outputscale)
        model, likelihood, lr = load_model(
            model_base_path, counter_file_path, train_x, train_y
        )

        optimizer = torch.optim.Adam(model.parameters(), lr=lr)
        mll = gpytorch.mlls.ExactMarginalLogLikelihood(likelihood, model)

        # Train the model on the training set
        train_model(model, likelihood, optimizer, train_x, train_y, training_iter=500)

        # Evaluate on the test set
        model.eval()
        likelihood.eval()
        with torch.no_grad(), gpytorch.settings.fast_pred_var():
            observed_pred = likelihood(model(test_x))
            pred = observed_pred.mean.numpy()
            rmse = np.sqrt(mean_squared_error(test_y.numpy(), pred))
            if rmse < best_validation_rmse:
                best_validation_rmse = rmse
                # best_model = model.state_dict()

        if rmse < previous_rmse:
            lr *= 0.95
        else:
            lr *= 1.05
        for param_group in optimizer.param_groups:
            param_group["lr"] = lr

        previous_rmse = rmse

        if pred.size == 1:
            predictions[i] = pred.item()
        else:
            raise ValueError("Prediction `pred` is not a single value as expected.")

        actuals[i] = y_test[0]

    rmse = np.sqrt(mean_squared_error(actuals, predictions))
    print(f"RMSE: {rmse}")

    _, model_id = save_model(model, optimizer, model_base_path, counter_file_path)

    model.eval()
    likelihood.eval()

    def generate_and_scale_lhs_points(
        num_points,
        voltage_target=(0, 1),
        time_target=(0, 1),
        concentration_target=(0, 1),
        concentrations: list = None,
    ):
        if concentrations is None:
            concentrations = []
        combined_samples = []
        for concentration in concentrations:
            sampler = qmc.LatinHypercube(d=2)
            samples = sampler.random(n=num_points)
            samples[:, 0] = voltage_target[0] + (
                samples[:, 0] * (voltage_target[1] - voltage_target[0])
            )
            samples[:, 1] = time_target[0] + (
                samples[:, 1] * (time_target[1] - time_target[0])
            )
            scaled_concentration = np.full(
                (num_points, 1),
                concentration_target[0]
                + (concentration - 0.01)
                * (concentration_target[1] - concentration_target[0])
                / (0.1 - 0.01),
            )
            samples_with_concentration = np.hstack((samples, scaled_concentration))
            combined_samples.append(samples_with_concentration)

        combined_samples = np.vstack(combined_samples)
        return combined_samples

    # Configuration for generating and scaling LHS points
    voltage_target = (0, 1)
    time_target = (0, 1)
    concentration_target = (0, 1)
    concentrations = [
        0.027,
        0.023,
        0.020,
        0.017,
        0.013,
        0.010,
        0.085,
        0.070,
        0.055,
        0.040,
        0.025,
        0.030,
        0.100,
        0.088,
        0.077,
        0.065,
        0.053,
        0.042,
    ]
    num_points = 50000
    test_points_scaled = generate_and_scale_lhs_points(
        num_points, voltage_target, time_target, concentration_target, concentrations
    )
    test_x_scaled = torch.tensor(test_points_scaled, dtype=torch.float32)
    current_best_response = train_y.max().item()

    def expected_improvement(model, test_points_scaled, current_best, likelihood):
        with torch.no_grad(), gpytorch.settings.fast_pred_var():
            observed_pred = likelihood(model(test_points_scaled))
            mean = observed_pred.mean
            std_dev = observed_pred.stddev
            z = (mean - current_best) / std_dev
            ei = (mean - current_best) * torch.distributions.Normal(0, 1).cdf(
                z
            ) + std_dev * torch.distributions.Normal(0, 1).log_prob(z).exp()
            return ei.numpy(), std_dev.numpy(), mean.numpy()

    ei, std_dev, mean = expected_improvement(
        model, test_x_scaled, current_best_response, likelihood
    )
    best_point_index = np.argmax(ei)
    best_test_point = test_points_scaled[best_point_index]

    with torch.no_grad(), gpytorch.settings.fast_pred_var():
        best_test_point_tensor = torch.tensor(
            best_test_point, dtype=torch.float32
        ).unsqueeze(
            0
        )  # Add batch dimension
        predicted_distribution = likelihood(model(best_test_point_tensor))
        predicted_mean = predicted_distribution.mean.item()
        predicted_stddev = predicted_distribution.stddev.item()
    print("Best Test Point in scalar values:", best_test_point)
    best_test_point_original = convert_back_to_original(best_test_point)

    print("Best Test Point in Original Values:", best_test_point_original)
    print("Predicted Response at Best Test Point:", predicted_mean)
    print("Standard Deviation of Prediction:", predicted_stddev)

    precision = 3
    rounded_best_test_point_original = [
        round(value, precision) for value in best_test_point_original
    ]
    print("Best Test Point in Original Values:", rounded_best_test_point_original)

    # Unpack values
    v_dep, t_dep, edot_concentration = rounded_best_test_point_original

    # df = pd.DataFrame(
    #     {
    #         "Best Test Point Scalar": [best_test_point],
    #         "Best Test Point Original": [best_test_point_original],
    #         "Best Test Point": [rounded_best_test_point_original],
    #         "v_dep": [v_dep],
    #         "t_dep": [t_dep],
    #         "edot_concentration": [edot_concentration],
    #         "Predicted Response": [predicted_mean],
    #         "Standard Deviation": [predicted_stddev],
    #         "Models current RMSE": [rmse],
    #     }
    # )
    df = pd.DataFrame(
        {
            "Model ID": [model_id],
            "Experiment ID": [experiment_id],
            "Best Test Point Scalar": [best_test_point],
            "Best Test Point Original": [best_test_point_original],
            "Best Test Point": [rounded_best_test_point_original],
            "v_dep": [v_dep],
            "t_dep": [t_dep],
            "edot_concentration": [edot_concentration],
            "Predicted Response": [predicted_mean],
            "Standard Deviation": [predicted_stddev],
            "Models current RMSE": [rmse],
        }
    )

    # file_exists = os.path.isfile(BestTestPointsCSV)
    # df.to_csv(BestTestPointsCSV, mode="a", header=not file_exists, index=False)
    insert_best_test_point(df)
    mask = np.isclose(
        test_points_scaled[:, 2], test_points_scaled[best_point_index, 2], rtol=1e-3
    )

    voltage_values = test_points_scaled[mask, 0]
    time_values = test_points_scaled[mask, 1]
    ei_values = ei[mask]
    std_dev_values = std_dev[mask]
    mean_values = mean[mask]

    voltage_range = np.linspace(0.8, 1.6, 100)
    # log_time_range = np.linspace(np.log(1), np.log(100), 100)
    # V, LogT = np.meshgrid(voltage_range, log_time_range)
    # T = np.exp(LogT)  # Convert back to original time for model input
    # voltage_bounds, time_bounds, concentration_bounds = (0.8, 1.6), (1, 100), (0.01, 0.1)
    voltage_target, time_target, concentration_target = (0, 1), (0, 1), (0, 1)
    fig, axes = plt.subplots(nrows=1, ncols=3, figsize=(18, 5))
    # Reshape data for contour plotting
    voltage_range = np.linspace(np.min(voltage_values), np.max(voltage_values), 300)
    time_range = np.linspace(np.min(time_values), np.max(time_values), 300)
    voltage_grid, time_grid = np.meshgrid(voltage_range, time_range)

    # Interpolation for EI
    ei_grid = griddata(
        (voltage_values, time_values),
        ei_values,
        (voltage_grid, time_grid),
        method="cubic",
    )
    # Interpolation for Standard Deviation
    std_dev_grid = griddata(
        (voltage_values, time_values),
        std_dev_values,
        (voltage_grid, time_grid),
        method="cubic",
    )
    # Interpolation for Predicted Response
    mean_grid = griddata(
        (voltage_values, time_values),
        mean_values,
        (voltage_grid, time_grid),
        method="cubic",
    )

    # Plot Expected Improvement
    contour_ei = axes[0].contourf(
        voltage_grid, time_grid, ei_grid, levels=50, cmap="viridis"
    )
    fig.colorbar(contour_ei, ax=axes[0])
    axes[0].set_title(f"Expected Improvement {edot_concentration} M")
    axes[0].set_xlabel("Voltage (scaled)")
    axes[0].set_ylabel("Time (scaled)")

    # Plot Standard Deviation
    contour_std = axes[1].contourf(
        voltage_grid, time_grid, std_dev_grid, levels=50, cmap="viridis"
    )
    fig.colorbar(contour_std, ax=axes[1])
    axes[1].set_title(f"Uncertainty {edot_concentration} M")
    axes[1].set_xlabel("Voltage (scaled)")
    axes[1].set_ylabel("Time (scaled)")

    # Plot Predicted Response
    contour_mean = axes[2].contourf(
        voltage_grid, time_grid, mean_grid, levels=50, cmap="viridis"
    )
    fig.colorbar(contour_mean, ax=axes[2])
    axes[2].set_title(f"$\Delta$ E$_{{00}}$ {edot_concentration} M")  # Modified title
    axes[2].set_xlabel("Voltage (scaled)")
    axes[2].set_ylabel("Time (scaled)")
    contourplots_filename = get_next_filename(
        contourplots_path, extensions=["svg", "png"]
    )
    sv_path = Path(f"{contourplots_filename}.svg")
    png_path = Path(f"{contourplots_filename}.png")
    plt.savefig(sv_path)
    plt.savefig(png_path)

    # Save the results to results
    to_be_inserted = [
        ExperimentResultsRecord(
            experiment_id=experiment_id,
            result_type="PEDOT_Deposition_Voltage",
            result_value=v_dep,
            context="pedot ml output",
        ),
        ExperimentResultsRecord(
            experiment_id=experiment_id,
            result_type="PEDOT_Deposition_Time",
            result_value=t_dep,
            context="pedot ml output",
        ),
        ExperimentResultsRecord(
            experiment_id=experiment_id,
            result_type="PEDOT_Concentration",
            result_value=edot_concentration,
            context="pedot ml output",
        ),
        ExperimentResultsRecord(
            experiment_id=experiment_id,
            result_type="PEDOT_Predicted_Mean",
            result_value=predicted_mean,
            context="pedot ml output",
        ),
        ExperimentResultsRecord(
            experiment_id=experiment_id,
            result_type="PEDOT_Predicted_Uncertainty",
            result_value=predicted_stddev,
            context="pedot ml output",
        ),
        ExperimentResultsRecord(
            experiment_id=experiment_id,
            result_type="PEDOT_Contour_Plots",
            result_value=f"{contourplots_filename}.png",
            context="pedot ml output",
        ),
    ]

    insert_experiment_results(to_be_inserted)

    return (
        v_dep,
        t_dep,
        edot_concentration,
        predicted_mean,
        predicted_stddev,
        f"{contourplots_filename}.png",
        model_id
    )


if __name__ == "__main__":

    # Before running update the paths accordingly
    TEST_TRAINING_FILE_PATH = "MLTrainingData_PEDOT.csv"  # training data file path
    TEST_MODEL_BASE_PATH = "pedot_gp_model_v8"
    TEST_COUNTER_FILE_PATH = "model_counter.txt"
    TEST_BESTTESTPOINTSCSV = "BestTestPoints.csv"  # file to save best test points, adds to the file doesn't overwrite
    TEST_CONTOURPLOTS_PATH = "contourplots\\"  # file to save contour plots, without extension

    main(
        TEST_TRAINING_FILE_PATH,
        TEST_MODEL_BASE_PATH,
        TEST_COUNTER_FILE_PATH,
        TEST_BESTTESTPOINTSCSV,
        TEST_CONTOURPLOTS_PATH,
    )
