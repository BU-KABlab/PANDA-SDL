--
-- File generated with SQLiteStudio v3.4.4 on Fri Jun 21 03:20:57 2024
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: experiment_parameters
CREATE TABLE IF NOT EXISTS experiment_parameters (
    id              INTEGER           NOT NULL
                                      PRIMARY KEY AUTOINCREMENT,
    experiment_id   INTEGER,
    parameter_name  TEXT,
    parameter_value TEXT,
    created         DATETIME,
    updated         CURRENT_TIMESTAMP
);

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      1,
                                      10000000,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      2,
                                      10000000,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      3,
                                      10000000,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      4,
                                      10000000,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      5,
                                      10000000,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      6,
                                      10000000,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      7,
                                      10000000,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      8,
                                      10000000,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      9,
                                      10000000,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      10,
                                      10000000,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      11,
                                      10000000,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      12,
                                      10000000,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      13,
                                      10000000,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      14,
                                      10000000,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      15,
                                      10000000,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      16,
                                      10000000,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      17,
                                      10000000,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      18,
                                      10000000,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      19,
                                      10000000,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      20,
                                      10000000,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      21,
                                      10000000,
                                      'ca_step_1_voltage',
                                      '1.103574943',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      22,
                                      10000000,
                                      'ca_step_1_time',
                                      '3.797092889',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      23,
                                      10000000,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      24,
                                      10000000,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      25,
                                      10000000,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      26,
                                      10000000,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      27,
                                      10000000,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      28,
                                      10000000,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      29,
                                      10000000,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      30,
                                      10000000,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      31,
                                      10000000,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      32,
                                      10000000,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      33,
                                      10000000,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      34,
                                      10000000,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      35,
                                      10000000,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      36,
                                      10000000,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      37,
                                      10000000,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      38,
                                      10000000,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      39,
                                      10000001,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      40,
                                      10000001,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      41,
                                      10000001,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      42,
                                      10000001,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      43,
                                      10000001,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      44,
                                      10000001,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      45,
                                      10000001,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      46,
                                      10000001,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      47,
                                      10000001,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      48,
                                      10000001,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      49,
                                      10000001,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      50,
                                      10000001,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      51,
                                      10000001,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      52,
                                      10000001,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      53,
                                      10000001,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      54,
                                      10000001,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      55,
                                      10000001,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      56,
                                      10000001,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      57,
                                      10000001,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      58,
                                      10000001,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      59,
                                      10000001,
                                      'ca_step_1_voltage',
                                      '1.072247862',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      60,
                                      10000001,
                                      'ca_step_1_time',
                                      '9.942700152',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      61,
                                      10000001,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      62,
                                      10000001,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      63,
                                      10000001,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      64,
                                      10000001,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      65,
                                      10000001,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      66,
                                      10000001,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      67,
                                      10000001,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      68,
                                      10000001,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      69,
                                      10000001,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      70,
                                      10000001,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      71,
                                      10000001,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      72,
                                      10000001,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      73,
                                      10000001,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      74,
                                      10000001,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      75,
                                      10000001,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      76,
                                      10000001,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      77,
                                      10000002,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      78,
                                      10000002,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      79,
                                      10000002,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      80,
                                      10000002,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      81,
                                      10000002,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      82,
                                      10000002,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      83,
                                      10000002,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      84,
                                      10000002,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      85,
                                      10000002,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      86,
                                      10000002,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      87,
                                      10000002,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      88,
                                      10000002,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      89,
                                      10000002,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      90,
                                      10000002,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      91,
                                      10000002,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      92,
                                      10000002,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      93,
                                      10000002,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      94,
                                      10000002,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      95,
                                      10000002,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      96,
                                      10000002,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      97,
                                      10000002,
                                      'ca_step_1_voltage',
                                      '1.399574718',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      98,
                                      10000002,
                                      'ca_step_1_time',
                                      '19.99647276',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      99,
                                      10000002,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      100,
                                      10000002,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      101,
                                      10000002,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      102,
                                      10000002,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      103,
                                      10000002,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      104,
                                      10000002,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      105,
                                      10000002,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      106,
                                      10000002,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      107,
                                      10000002,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      108,
                                      10000002,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      109,
                                      10000002,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      110,
                                      10000002,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      111,
                                      10000002,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      112,
                                      10000002,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      113,
                                      10000002,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      114,
                                      10000002,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      115,
                                      10000003,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      116,
                                      10000003,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      117,
                                      10000003,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      118,
                                      10000003,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      119,
                                      10000003,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      120,
                                      10000003,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      121,
                                      10000003,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      122,
                                      10000003,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      123,
                                      10000003,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      124,
                                      10000003,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      125,
                                      10000003,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      126,
                                      10000003,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      127,
                                      10000003,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      128,
                                      10000003,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      129,
                                      10000003,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      130,
                                      10000003,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      131,
                                      10000003,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      132,
                                      10000003,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      133,
                                      10000003,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      134,
                                      10000003,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      135,
                                      10000003,
                                      'ca_step_1_voltage',
                                      '1.54445486',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      136,
                                      10000003,
                                      'ca_step_1_time',
                                      '3.141003597',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      137,
                                      10000003,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      138,
                                      10000003,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      139,
                                      10000003,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      140,
                                      10000003,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      141,
                                      10000003,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      142,
                                      10000003,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      143,
                                      10000003,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      144,
                                      10000003,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      145,
                                      10000003,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      146,
                                      10000003,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      147,
                                      10000003,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      148,
                                      10000003,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      149,
                                      10000003,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      150,
                                      10000003,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      151,
                                      10000003,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      152,
                                      10000003,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      153,
                                      10000004,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      154,
                                      10000004,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      155,
                                      10000004,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      156,
                                      10000004,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      157,
                                      10000004,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      158,
                                      10000004,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      159,
                                      10000004,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      160,
                                      10000004,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      161,
                                      10000004,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      162,
                                      10000004,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      163,
                                      10000004,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      164,
                                      10000004,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      165,
                                      10000004,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      166,
                                      10000004,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      167,
                                      10000004,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      168,
                                      10000004,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      169,
                                      10000004,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      170,
                                      10000004,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      171,
                                      10000004,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      172,
                                      10000004,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      173,
                                      10000004,
                                      'ca_step_1_voltage',
                                      '1.556551081',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      174,
                                      10000004,
                                      'ca_step_1_time',
                                      '80.30651025',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      175,
                                      10000004,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      176,
                                      10000004,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      177,
                                      10000004,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      178,
                                      10000004,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      179,
                                      10000004,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      180,
                                      10000004,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      181,
                                      10000004,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      182,
                                      10000004,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      183,
                                      10000004,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      184,
                                      10000004,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      185,
                                      10000004,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      186,
                                      10000004,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      187,
                                      10000004,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      188,
                                      10000004,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      189,
                                      10000004,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      190,
                                      10000004,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      191,
                                      10000005,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      192,
                                      10000005,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      193,
                                      10000005,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      194,
                                      10000005,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      195,
                                      10000005,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      196,
                                      10000005,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      197,
                                      10000005,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      198,
                                      10000005,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      199,
                                      10000005,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      200,
                                      10000005,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      201,
                                      10000005,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      202,
                                      10000005,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      203,
                                      10000005,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      204,
                                      10000005,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      205,
                                      10000005,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      206,
                                      10000005,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      207,
                                      10000005,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      208,
                                      10000005,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      209,
                                      10000005,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      210,
                                      10000005,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      211,
                                      10000005,
                                      'ca_step_1_voltage',
                                      '1.22126257',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      212,
                                      10000005,
                                      'ca_step_1_time',
                                      '45.8954972',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      213,
                                      10000005,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      214,
                                      10000005,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      215,
                                      10000005,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      216,
                                      10000005,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      217,
                                      10000005,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      218,
                                      10000005,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      219,
                                      10000005,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      220,
                                      10000005,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      221,
                                      10000005,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      222,
                                      10000005,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      223,
                                      10000005,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      224,
                                      10000005,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      225,
                                      10000005,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      226,
                                      10000005,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      227,
                                      10000005,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      228,
                                      10000005,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      229,
                                      10000006,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      230,
                                      10000006,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      231,
                                      10000006,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      232,
                                      10000006,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      233,
                                      10000006,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      234,
                                      10000006,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      235,
                                      10000006,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      236,
                                      10000006,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      237,
                                      10000006,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      238,
                                      10000006,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      239,
                                      10000006,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      240,
                                      10000006,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      241,
                                      10000006,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      242,
                                      10000006,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      243,
                                      10000006,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      244,
                                      10000006,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      245,
                                      10000006,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      246,
                                      10000006,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      247,
                                      10000006,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      248,
                                      10000006,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      249,
                                      10000006,
                                      'ca_step_1_voltage',
                                      '1.290493376',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      250,
                                      10000006,
                                      'ca_step_1_time',
                                      '27.55509538',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      251,
                                      10000006,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      252,
                                      10000006,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      253,
                                      10000006,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      254,
                                      10000006,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      255,
                                      10000006,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      256,
                                      10000006,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      257,
                                      10000006,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      258,
                                      10000006,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      259,
                                      10000006,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      260,
                                      10000006,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      261,
                                      10000006,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      262,
                                      10000006,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      263,
                                      10000006,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      264,
                                      10000006,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      265,
                                      10000006,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      266,
                                      10000006,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      267,
                                      10000007,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      268,
                                      10000007,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      269,
                                      10000007,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      270,
                                      10000007,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      271,
                                      10000007,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      272,
                                      10000007,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      273,
                                      10000007,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      274,
                                      10000007,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      275,
                                      10000007,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      276,
                                      10000007,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      277,
                                      10000007,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      278,
                                      10000007,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      279,
                                      10000007,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      280,
                                      10000007,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      281,
                                      10000007,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      282,
                                      10000007,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      283,
                                      10000007,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      284,
                                      10000007,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      285,
                                      10000007,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      286,
                                      10000007,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      287,
                                      10000007,
                                      'ca_step_1_voltage',
                                      '1.302078029',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      288,
                                      10000007,
                                      'ca_step_1_time',
                                      '16.80250948',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      289,
                                      10000007,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      290,
                                      10000007,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      291,
                                      10000007,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      292,
                                      10000007,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      293,
                                      10000007,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      294,
                                      10000007,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      295,
                                      10000007,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      296,
                                      10000007,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      297,
                                      10000007,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      298,
                                      10000007,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      299,
                                      10000007,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      300,
                                      10000007,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      301,
                                      10000007,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      302,
                                      10000007,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      303,
                                      10000007,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      304,
                                      10000007,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      305,
                                      10000008,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      306,
                                      10000008,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      307,
                                      10000008,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      308,
                                      10000008,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      309,
                                      10000008,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      310,
                                      10000008,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      311,
                                      10000008,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      312,
                                      10000008,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      313,
                                      10000008,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      314,
                                      10000008,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      315,
                                      10000008,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      316,
                                      10000008,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      317,
                                      10000008,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      318,
                                      10000008,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      319,
                                      10000008,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      320,
                                      10000008,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      321,
                                      10000008,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      322,
                                      10000008,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      323,
                                      10000008,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      324,
                                      10000008,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      325,
                                      10000008,
                                      'ca_step_1_voltage',
                                      '0.942949728',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      326,
                                      10000008,
                                      'ca_step_1_time',
                                      '36.37135724',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      327,
                                      10000008,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      328,
                                      10000008,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      329,
                                      10000008,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      330,
                                      10000008,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      331,
                                      10000008,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      332,
                                      10000008,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      333,
                                      10000008,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      334,
                                      10000008,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      335,
                                      10000008,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      336,
                                      10000008,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      337,
                                      10000008,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      338,
                                      10000008,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      339,
                                      10000008,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      340,
                                      10000008,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      341,
                                      10000008,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      342,
                                      10000008,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      343,
                                      10000009,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      344,
                                      10000009,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      345,
                                      10000009,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      346,
                                      10000009,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      347,
                                      10000009,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      348,
                                      10000009,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      349,
                                      10000009,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      350,
                                      10000009,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      351,
                                      10000009,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      352,
                                      10000009,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      353,
                                      10000009,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      354,
                                      10000009,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      355,
                                      10000009,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      356,
                                      10000009,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      357,
                                      10000009,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      358,
                                      10000009,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      359,
                                      10000009,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      360,
                                      10000009,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      361,
                                      10000009,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      362,
                                      10000009,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      363,
                                      10000009,
                                      'ca_step_1_voltage',
                                      '1.464067178',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      364,
                                      10000009,
                                      'ca_step_1_time',
                                      '1.973997251',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      365,
                                      10000009,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      366,
                                      10000009,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      367,
                                      10000009,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      368,
                                      10000009,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      369,
                                      10000009,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      370,
                                      10000009,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      371,
                                      10000009,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      372,
                                      10000009,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      373,
                                      10000009,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      374,
                                      10000009,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      375,
                                      10000009,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      376,
                                      10000009,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      377,
                                      10000009,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      378,
                                      10000009,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      379,
                                      10000009,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      380,
                                      10000009,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      381,
                                      10000010,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      382,
                                      10000010,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      383,
                                      10000010,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      384,
                                      10000010,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      385,
                                      10000010,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      386,
                                      10000010,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      387,
                                      10000010,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      388,
                                      10000010,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      389,
                                      10000010,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      390,
                                      10000010,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      391,
                                      10000010,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      392,
                                      10000010,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      393,
                                      10000010,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      394,
                                      10000010,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      395,
                                      10000010,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      396,
                                      10000010,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      397,
                                      10000010,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      398,
                                      10000010,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      399,
                                      10000010,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      400,
                                      10000010,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      401,
                                      10000010,
                                      'ca_step_1_voltage',
                                      '1.194614655',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      402,
                                      10000010,
                                      'ca_step_1_time',
                                      '59.60546757',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      403,
                                      10000010,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      404,
                                      10000010,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      405,
                                      10000010,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      406,
                                      10000010,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      407,
                                      10000010,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      408,
                                      10000010,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      409,
                                      10000010,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      410,
                                      10000010,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      411,
                                      10000010,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      412,
                                      10000010,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      413,
                                      10000010,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      414,
                                      10000010,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      415,
                                      10000010,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      416,
                                      10000010,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      417,
                                      10000010,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      418,
                                      10000010,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      419,
                                      10000011,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      420,
                                      10000011,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      421,
                                      10000011,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      422,
                                      10000011,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      423,
                                      10000011,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      424,
                                      10000011,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      425,
                                      10000011,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      426,
                                      10000011,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      427,
                                      10000011,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      428,
                                      10000011,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      429,
                                      10000011,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      430,
                                      10000011,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      431,
                                      10000011,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      432,
                                      10000011,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      433,
                                      10000011,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      434,
                                      10000011,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      435,
                                      10000011,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      436,
                                      10000011,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      437,
                                      10000011,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      438,
                                      10000011,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      439,
                                      10000011,
                                      'ca_step_1_voltage',
                                      '0.866789927',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      440,
                                      10000011,
                                      'ca_step_1_time',
                                      '4.302646073',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      441,
                                      10000011,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      442,
                                      10000011,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      443,
                                      10000011,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      444,
                                      10000011,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      445,
                                      10000011,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      446,
                                      10000011,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      447,
                                      10000011,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      448,
                                      10000011,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      449,
                                      10000011,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      450,
                                      10000011,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      451,
                                      10000011,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      452,
                                      10000011,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      453,
                                      10000011,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      454,
                                      10000011,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      455,
                                      10000011,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      456,
                                      10000011,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      457,
                                      10000012,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      458,
                                      10000012,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      459,
                                      10000012,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      460,
                                      10000012,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      461,
                                      10000012,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      462,
                                      10000012,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      463,
                                      10000012,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      464,
                                      10000012,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      465,
                                      10000012,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      466,
                                      10000012,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      467,
                                      10000012,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      468,
                                      10000012,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      469,
                                      10000012,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      470,
                                      10000012,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      471,
                                      10000012,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      472,
                                      10000012,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      473,
                                      10000012,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      474,
                                      10000012,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      475,
                                      10000012,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      476,
                                      10000012,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      477,
                                      10000012,
                                      'ca_step_1_voltage',
                                      '0.842818578',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      478,
                                      10000012,
                                      'ca_step_1_time',
                                      '5.874526581',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      479,
                                      10000012,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      480,
                                      10000012,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      481,
                                      10000012,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      482,
                                      10000012,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      483,
                                      10000012,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      484,
                                      10000012,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      485,
                                      10000012,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      486,
                                      10000012,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      487,
                                      10000012,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      488,
                                      10000012,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      489,
                                      10000012,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      490,
                                      10000012,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      491,
                                      10000012,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      492,
                                      10000012,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      493,
                                      10000012,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      494,
                                      10000012,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      495,
                                      10000013,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      496,
                                      10000013,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      497,
                                      10000013,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      498,
                                      10000013,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      499,
                                      10000013,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      500,
                                      10000013,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      501,
                                      10000013,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      502,
                                      10000013,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      503,
                                      10000013,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      504,
                                      10000013,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      505,
                                      10000013,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      506,
                                      10000013,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      507,
                                      10000013,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      508,
                                      10000013,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      509,
                                      10000013,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      510,
                                      10000013,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      511,
                                      10000013,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      512,
                                      10000013,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      513,
                                      10000013,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      514,
                                      10000013,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      515,
                                      10000013,
                                      'ca_step_1_voltage',
                                      '1.417941178',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      516,
                                      10000013,
                                      'ca_step_1_time',
                                      '11.79534411',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      517,
                                      10000013,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      518,
                                      10000013,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      519,
                                      10000013,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      520,
                                      10000013,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      521,
                                      10000013,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      522,
                                      10000013,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      523,
                                      10000013,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      524,
                                      10000013,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      525,
                                      10000013,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      526,
                                      10000013,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      527,
                                      10000013,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      528,
                                      10000013,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      529,
                                      10000013,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      530,
                                      10000013,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      531,
                                      10000013,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      532,
                                      10000013,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      533,
                                      10000014,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      534,
                                      10000014,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      535,
                                      10000014,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      536,
                                      10000014,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      537,
                                      10000014,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      538,
                                      10000014,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      539,
                                      10000014,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      540,
                                      10000014,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      541,
                                      10000014,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      542,
                                      10000014,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      543,
                                      10000014,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      544,
                                      10000014,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      545,
                                      10000014,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      546,
                                      10000014,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      547,
                                      10000014,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      548,
                                      10000014,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      549,
                                      10000014,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      550,
                                      10000014,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      551,
                                      10000014,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      552,
                                      10000014,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      553,
                                      10000014,
                                      'ca_step_1_voltage',
                                      '0.980088091',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      554,
                                      10000014,
                                      'ca_step_1_time',
                                      '1.152476253',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      555,
                                      10000014,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      556,
                                      10000014,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      557,
                                      10000014,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      558,
                                      10000014,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      559,
                                      10000014,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      560,
                                      10000014,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      561,
                                      10000014,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      562,
                                      10000014,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      563,
                                      10000014,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      564,
                                      10000014,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      565,
                                      10000014,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      566,
                                      10000014,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      567,
                                      10000014,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      568,
                                      10000014,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      569,
                                      10000014,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      570,
                                      10000014,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      571,
                                      10000015,
                                      'experiment_name',
                                      'system_test',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      572,
                                      10000015,
                                      'solutions',
                                      '{"edot": 120, "liclo4": 120, "rinse": 120}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      573,
                                      10000015,
                                      'solutions_corrected',
                                      '{"edot": 0, "liclo4": 0, "rinse": 0}',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      574,
                                      10000015,
                                      'well_type_number',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      575,
                                      10000015,
                                      'pumping_rate',
                                      '0.3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      576,
                                      10000015,
                                      'plate_id',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      577,
                                      10000015,
                                      'override_well_selection',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      578,
                                      10000015,
                                      'ocp',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      579,
                                      10000015,
                                      'ca',
                                      '1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      580,
                                      10000015,
                                      'cv',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      581,
                                      10000015,
                                      'baseline',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      582,
                                      10000015,
                                      'flush_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      583,
                                      10000015,
                                      'flush_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      584,
                                      10000015,
                                      'mix_count',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      585,
                                      10000015,
                                      'mix_volume',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      586,
                                      10000015,
                                      'rinse_count',
                                      '4',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      587,
                                      10000015,
                                      'rinse_vol',
                                      '120',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      588,
                                      10000015,
                                      'ca_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      589,
                                      10000015,
                                      'ca_prestep_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      590,
                                      10000015,
                                      'ca_prestep_time_delay',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      591,
                                      10000015,
                                      'ca_step_1_voltage',
                                      '1.040741426',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      592,
                                      10000015,
                                      'ca_step_1_time',
                                      '1.542247632',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      593,
                                      10000015,
                                      'ca_step_2_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      594,
                                      10000015,
                                      'ca_step_2_time',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      595,
                                      10000015,
                                      'ca_sample_rate',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      596,
                                      10000015,
                                      'char_sol_name',
                                      '',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      597,
                                      10000015,
                                      'char_vol',
                                      '0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      598,
                                      10000015,
                                      'cv_sample_period',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      599,
                                      10000015,
                                      'cv_initial_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      600,
                                      10000015,
                                      'cv_first_anodic_peak',
                                      '0.5',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      601,
                                      10000015,
                                      'cv_second_anodic_peak',
                                      '-0.2',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      602,
                                      10000015,
                                      'cv_final_voltage',
                                      '0.0',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      603,
                                      10000015,
                                      'cv_step_size',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      604,
                                      10000015,
                                      'cv_cycle_count',
                                      '3',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      605,
                                      10000015,
                                      'cv_scan_rate_cycle_1',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      606,
                                      10000015,
                                      'cv_scan_rate_cycle_2',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      607,
                                      10000015,
                                      'cv_scan_rate_cycle_3',
                                      '0.1',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );

INSERT INTO experiment_parameters (
                                      id,
                                      experiment_id,
                                      parameter_name,
                                      parameter_value,
                                      created,
                                      updated
                                  )
                                  VALUES (
                                      608,
                                      10000015,
                                      'edot_concentration',
                                      '0.01',
                                      '2024-06-21T00:38:02',
                                      NULL
                                  );


-- Table: experiment_results
CREATE TABLE IF NOT EXISTS experiment_results (
    id            INTEGER           PRIMARY KEY,
    experiment_id INTEGER,
    result_type   TEXT,
    result_value  TEXT,
    created       DATETIME          DEFAULT (datetime('now', 'localtime') ),
    updated       CURRENT_TIMESTAMP,
    context       TEXT
);

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   1,
                                   10000001,
                                   'ocp_ca_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000001_A2_CA_deposition_OCP_CA_0.txt',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   2,
                                   10000001,
                                   'ocp_ca_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000001_A2_CA_bleaching_OCP_CA_0.txt',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_bleaching'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   3,
                                   10000001,
                                   'ocp_ca_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000001_A2_CA_coloring_OCP_CA_0.txt',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_coloring'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   4,
                                   10000001,
                                   'ocp_ca_passed',
                                   '1',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   5,
                                   10000001,
                                   'ocp_ca_passed',
                                   '1',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_bleaching'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   6,
                                   10000001,
                                   'ocp_ca_passed',
                                   '1',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_coloring'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   7,
                                   10000001,
                                   'ocp_cv_final_voltage',
                                   '0.0',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   8,
                                   10000001,
                                   'ocp_cv_final_voltage',
                                   '0.0',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_bleaching'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   9,
                                   10000001,
                                   'ocp_cv_final_voltage',
                                   '0.0',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_coloring'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   10,
                                   10000001,
                                   'ca_data_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000001_A2_CA_deposition_CA_0.txt',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   11,
                                   10000001,
                                   'ca_data_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000001_A2_CA_bleaching_CA_0.txt',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_bleaching'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   12,
                                   10000001,
                                   'ca_data_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000001_A2_CA_coloring_CA_0.txt',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'CA_coloring'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   13,
                                   10000001,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A2_999_10000001_BeforeDeposition_image_0.tiff',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'BeforeDeposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   14,
                                   10000001,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A2_999_10000001_AfterDeposition_image_0.tiff',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'AfterDeposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   15,
                                   10000001,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A2_999_10000001_BeforeBleaching_image_0.tiff',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'BeforeBleaching'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   16,
                                   10000001,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A2_999_10000001_AfterBleaching_image_0.tiff',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'AfterBleaching'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   17,
                                   10000001,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A2_999_10000001_BeforeColoring_image_0.tiff',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'BeforeColoring'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   18,
                                   10000001,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A2_999_10000001_AfterColoring_image_0.tiff',
                                   '2024-06-21 00:50:32',
                                   NULL,
                                   'AfterColoring'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   19,
                                   10000003,
                                   'ocp_ca_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000003_A4_CA_deposition_OCP_CA_0.txt',
                                   '2024-06-21 02:04:23',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   20,
                                   10000003,
                                   'ocp_ca_passed',
                                   '1',
                                   '2024-06-21 02:04:23',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   21,
                                   10000003,
                                   'ocp_cv_final_voltage',
                                   '0.0',
                                   '2024-06-21 02:04:23',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   22,
                                   10000003,
                                   'ca_data_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000003_A4_CA_deposition_CA_0.txt',
                                   '2024-06-21 02:04:23',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   23,
                                   10000003,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A4_999_10000003_BeforeDeposition_image_0.tiff',
                                   '2024-06-21 02:04:23',
                                   NULL,
                                   'BeforeDeposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   24,
                                   10000004,
                                   'ocp_ca_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000004_A5_CA_deposition_OCP_CA_0.txt',
                                   '2024-06-21 02:18:30',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   25,
                                   10000004,
                                   'ocp_ca_passed',
                                   '1',
                                   '2024-06-21 02:18:30',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   26,
                                   10000004,
                                   'ocp_cv_final_voltage',
                                   '0.0',
                                   '2024-06-21 02:18:30',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   27,
                                   10000004,
                                   'ca_data_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000004_A5_CA_deposition_CA_0.txt',
                                   '2024-06-21 02:18:30',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   28,
                                   10000004,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A5_999_10000004_BeforeDeposition_image_0.tiff',
                                   '2024-06-21 02:18:30',
                                   NULL,
                                   'BeforeDeposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   29,
                                   10000006,
                                   'ocp_ca_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000006_A7_CA_deposition_OCP_CA_0.txt',
                                   '2024-06-21 02:26:51',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   30,
                                   10000006,
                                   'ocp_ca_passed',
                                   '1',
                                   '2024-06-21 02:26:51',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   31,
                                   10000006,
                                   'ocp_cv_final_voltage',
                                   '0.0',
                                   '2024-06-21 02:26:51',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   32,
                                   10000006,
                                   'ca_data_file',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\999_999_10000006_A7_CA_deposition_CA_0.txt',
                                   '2024-06-21 02:26:51',
                                   NULL,
                                   'CA_deposition'
                               );

INSERT INTO experiment_results (
                                   id,
                                   experiment_id,
                                   result_type,
                                   result_value,
                                   created,
                                   updated,
                                   context
                               )
                               VALUES (
                                   33,
                                   10000006,
                                   'image',
                                   'C:\Users\grego\SynologyDrive\Documents\GitHub\panda_bear\data\A7_999_10000006_BeforeDeposition_image_0.tiff',
                                   '2024-06-21 02:26:51',
                                   NULL,
                                   'BeforeDeposition'
                               );


-- Table: experiments
CREATE TABLE IF NOT EXISTS experiments (
    experiment_id       BIGINT   PRIMARY KEY,
    project_id          INTEGER,
    project_campaign_id INTEGER,
    well_type           INTEGER,
    protocol_id         INTEGER,
    pin                 TEXT,
    experiment_type     INTEGER,
    jira_issue_key      TEXT,
    priority            INTEGER  DEFAULT 0,
    process_type        INTEGER  DEFAULT 0,
    filename            TEXT     DEFAULT NULL,
    created             DATETIME,
    updated             DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000000,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000000',
                            '2024-06-21T00:38:02',
                            '2024-06-21 00:38:28'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000001,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            4,
                            'system_test 10000001',
                            '2024-06-21T00:38:02',
                            '2024-06-21 00:50:32'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000002,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000002',
                            '2024-06-21T00:38:02',
                            '2024-06-21 01:58:23'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000003,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000003',
                            '2024-06-21T00:38:02',
                            '2024-06-21 02:04:21'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000004,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000004',
                            '2024-06-21T00:38:02',
                            '2024-06-21 02:18:28'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000005,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000005',
                            '2024-06-21T00:38:02',
                            '2024-06-21 02:19:54'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000006,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000006',
                            '2024-06-21T00:38:02',
                            '2024-06-21 02:26:50'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000007,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000007',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000008,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000008',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000009,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000009',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000010,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000010',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000011,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000011',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000012,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000012',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000013,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000013',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000014,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000014',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );

INSERT INTO experiments (
                            experiment_id,
                            project_id,
                            project_campaign_id,
                            well_type,
                            protocol_id,
                            pin,
                            experiment_type,
                            jira_issue_key,
                            priority,
                            process_type,
                            filename,
                            created,
                            updated
                        )
                        VALUES (
                            10000015,
                            999,
                            999,
                            4,
                            'system_test',
                            '201010102040500000101',
                            2,
                            NULL,
                            0,
                            1,
                            'system_test 10000015',
                            '2024-06-21T00:38:02',
                            '2024-06-21 04:38:02'
                        );


-- Table: generators
CREATE TABLE IF NOT EXISTS generators (
    id          INTEGER NOT NULL
                        PRIMARY KEY AUTOINCREMENT,
    project_id  INTEGER,
    protocol_id INTEGER,
    name        TEXT,
    filepath    TEXT
);

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           1,
                           '',
                           '',
                           'exp_a_ferrocyanide_generator',
                           'exp_a_ferrocyanide_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           2,
                           '',
                           '',
                           'exp_a_ferrocyanide_generator_baseline',
                           'exp_a_ferrocyanide_generator_baseline.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           3,
                           '',
                           '',
                           'exp_b_pipette_contamination_generator',
                           'exp_b_pipette_contamination_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           4,
                           '',
                           '',
                           'exp_c_rinsing_assessment_generator',
                           'exp_c_rinsing_assessment_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           5,
                           '',
                           '',
                           'exp_d2_mixing_assessment_generator',
                           'exp_d2_mixing_assessment_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           6,
                           '',
                           '',
                           'exp_d_mixing_assessment_generator',
                           'exp_d_mixing_assessment_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           7,
                           '',
                           '',
                           'exp_edot_bleaching_generator',
                           'exp_edot_bleaching_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           8,
                           '',
                           '',
                           'exp_edot_repeatability_generator',
                           'exp_edot_repeatability_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           9,
                           '',
                           '',
                           'exp_edot_repeatability_generator_v2',
                           'exp_edot_repeatability_generator_v2.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           10,
                           '',
                           '',
                           'exp_edot_screening_generator_v1',
                           'exp_edot_screening_generator_v1.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           11,
                           '',
                           '',
                           'exp_edot_screening_generator_v2',
                           'exp_edot_screening_generator_v2.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           12,
                           '',
                           '',
                           'exp_edot_screening_generator_v3',
                           'exp_edot_screening_generator_v3.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           13,
                           '',
                           '',
                           'exp_edot_voltage_sweep_generator',
                           'exp_edot_voltage_sweep_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           14,
                           '',
                           '',
                           'exp_fecn_conc_assessment_generator',
                           'exp_fecn_conc_assessment_generator.py'
                       );

INSERT INTO generators (
                           id,
                           project_id,
                           protocol_id,
                           name,
                           filepath
                       )
                       VALUES (
                           15,
                           '',
                           '',
                           'system_test',
                           'system_test.py'
                       );


-- Table: ml_pedot_best_test_points
CREATE TABLE IF NOT EXISTS ml_pedot_best_test_points (
    model_id                 INT             NOT NULL
                                             PRIMARY KEY,
    experiment_id            INT             UNIQUE,
    best_test_point_scalar   TEXT,
    best_test_point_original TEXT,
    best_test_point          TEXT,
    v_dep                    DECIMAL (18, 8),
    t_dep                    DECIMAL (18, 8),
    edot_concentration       DECIMAL (18, 8),
    predicted_response       DECIMAL (18, 8),
    standard_deviation       DECIMAL (18, 8),
    models_current_rmse      DECIMAL (18, 8) 
);

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          0,
                                          10000875,
                                          '[0.58719082 0.33052637 1.        ]',
                                          '[1.30462898 5.76170606 0.1       ]',
                                          '[1.305, 5.762, 0.1]',
                                          1.305,
                                          5.762,
                                          0.1,
                                          23.64089203,
                                          0.434540629,
                                          2.957462131
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          1,
                                          10000876,
                                          '[0.58954389 0.3130133  1.        ]',
                                          '[1.30745267 5.25113269 0.1       ]',
                                          '[1.307, 5.251, 0.1]',
                                          1.307,
                                          5.251,
                                          0.1,
                                          23.3735733,
                                          0.505571604,
                                          2.472279328
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          2,
                                          10000877,
                                          '[0.59013849 0.32150699 1.        ]',
                                          '[1.30816619 5.49284361 0.1       ]',
                                          '[1.308, 5.493, 0.1]',
                                          1.308,
                                          5.493,
                                          0.1,
                                          23.78996658,
                                          0.298232794,
                                          3.020569694
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          3,
                                          10000878,
                                          '[0.58744481 0.31828597 1.        ]',
                                          '[1.30493378 5.39989811 0.1       ]',
                                          '[1.305, 5.4, 0.1]',
                                          1.305,
                                          5.4,
                                          0.1,
                                          23.0240097,
                                          0.706163466,
                                          3.004929045
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          4,
                                          10000879,
                                          '[0.58957467 0.31856788 1.        ]',
                                          '[1.30748961 5.40796956 0.1       ]',
                                          '[1.307, 5.408, 0.1]',
                                          1.307,
                                          5.408,
                                          0.1,
                                          22.92770576,
                                          0.655078769,
                                          2.943466735
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          5,
                                          10000880,
                                          '[0.93167328 0.38460762 1.        ]',
                                          '[1.71800794 7.67350324 0.1       ]',
                                          '[1.718, 7.674, 0.1]',
                                          1.718,
                                          7.674,
                                          0.1,
                                          13.17465782,
                                          4.853104591,
                                          2.907309762
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          6,
                                          10000881,
                                          '[0.93466242 0.39311849 1.        ]',
                                          '[1.7215949  8.02744695 0.1       ]',
                                          '[1.722, 8.027, 0.1]',
                                          1.722,
                                          8.027,
                                          0.1,
                                          13.23623466,
                                          4.861187458,
                                          2.899766914
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          7,
                                          10000882,
                                          '[0.96391517 0.60476333 0.74444444]',
                                          '[ 1.75669821 24.63647415  0.05551936]',
                                          '[1.757, 24.636, 0.056]',
                                          1.757,
                                          24.636,
                                          0.056,
                                          15.62130165,
                                          4.464239597,
                                          2.769285342
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          8,
                                          10000883,
                                          '[0.52295747 0.3546264  1.        ]',
                                          '[1.22754896 6.54645182 0.1       ]',
                                          '[1.228, 6.546, 0.1]',
                                          1.228,
                                          6.546,
                                          0.1,
                                          22.83761024,
                                          1.636495113,
                                          3.01153306
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          9,
                                          10000884,
                                          '[0.51473078 0.35826491 1.        ]',
                                          '[1.21767693 6.67387866 0.1       ]',
                                          '[1.218, 6.674, 0.1]',
                                          1.218,
                                          6.674,
                                          0.1,
                                          22.91518021,
                                          1.63032186,
                                          2.922157511
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          10,
                                          10000885,
                                          '[0.5148784  0.35670411 1.        ]',
                                          '[1.21785408 6.61891581 0.1       ]',
                                          '[1.218, 6.619, 0.1]',
                                          1.218,
                                          6.619,
                                          0.1,
                                          22.85887909,
                                          1.554706573,
                                          2.909049121
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          11,
                                          10000886,
                                          '[0.52133797 0.34904517 1.        ]',
                                          '[1.22560556 6.35570025 0.1       ]',
                                          '[1.226, 6.356, 0.1]',
                                          1.226,
                                          6.356,
                                          0.1,
                                          22.67613792,
                                          1.513703346,
                                          2.918515083
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          12,
                                          10000887,
                                          '[0.53271967 0.34252296 1.        ]',
                                          '[1.23926361 6.13981962 0.1       ]',
                                          '[1.239, 6.14, 0.1]',
                                          1.239,
                                          6.14,
                                          0.1,
                                          22.49046898,
                                          1.497202635,
                                          2.935931025
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          13,
                                          10000888,
                                          '[0.54383138 0.3381599  1.        ]',
                                          '[1.25259766 5.99951397 0.1       ]',
                                          '[1.253, 6.0, 0.1]',
                                          1.253,
                                          6,
                                          0.1,
                                          22.31875801,
                                          1.49994278,
                                          2.935348128
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          14,
                                          10000889,
                                          '[0.54903141 0.33264569 1.        ]',
                                          '[1.25883769 5.82676768 0.1       ]',
                                          '[1.259, 5.827, 0.1]',
                                          1.259,
                                          5.827,
                                          0.1,
                                          22.20999146,
                                          1.486394644,
                                          2.937827395
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          15,
                                          10000890,
                                          '[0.55551112 0.32640415 1.        ]',
                                          '[1.26661335 5.63722992 0.1       ]',
                                          '[1.267, 5.637, 0.1]',
                                          1.267,
                                          5.637,
                                          0.1,
                                          22.03875732,
                                          1.516065836,
                                          2.944705805
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          16,
                                          10000891,
                                          '[0.5609699  0.32750562 1.        ]',
                                          '[1.27316387 5.67022443 0.1       ]',
                                          '[1.273, 5.67, 0.1]',
                                          1.273,
                                          5.67,
                                          0.1,
                                          21.86888504,
                                          1.555195212,
                                          2.948208859
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          17,
                                          10000892,
                                          '[0.56423356 0.33324192 1.        ]',
                                          '[1.27708028 5.8452039  0.1       ]',
                                          '[1.277, 5.845, 0.1]',
                                          1.277,
                                          5.845,
                                          0.1,
                                          21.56004143,
                                          1.740750909,
                                          2.96584845
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          18,
                                          10000893,
                                          '[0.84463666 0.11141556 1.        ]',
                                          '[1.61356399 1.8045568  0.1       ]',
                                          '[1.614, 1.805, 0.1]',
                                          1.614,
                                          1.805,
                                          0.1,
                                          18.22092819,
                                          3.480129957,
                                          2.97707334
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          19,
                                          10000894,
                                          '[0.83460697 0.10642799 1.        ]',
                                          '[1.60152837 1.75749455 0.1       ]',
                                          '[1.602, 1.757, 0.1]',
                                          1.602,
                                          1.757,
                                          0.1,
                                          18.29380417,
                                          3.510001183,
                                          2.947498361
                                      );

INSERT INTO ml_pedot_best_test_points (
                                          model_id,
                                          experiment_id,
                                          best_test_point_scalar,
                                          best_test_point_original,
                                          best_test_point,
                                          v_dep,
                                          t_dep,
                                          edot_concentration,
                                          predicted_response,
                                          standard_deviation,
                                          models_current_rmse
                                      )
                                      VALUES (
                                          20,
                                          10000895,
                                          '[0.83422518 0.10723327 1.        ]',
                                          '[1.60107022 1.76500917 0.1       ]',
                                          '[1.601, 1.765, 0.1]',
                                          1.601,
                                          1.765,
                                          0.1,
                                          18.308321,
                                          3.502789021,
                                          2.947505468
                                      );


-- Table: ml_pedot_training_data
CREATE TABLE IF NOT EXISTS ml_pedot_training_data (
    id            INTEGER         PRIMARY KEY,
    delta_e       DECIMAL (18, 8),
    voltage       DECIMAL (18, 8),
    time          DECIMAL (18, 8),
    bleach_cp     DECIMAL (18, 8),
    concentration DECIMAL (18, 8),
    experiment_id INTEGER
);

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       1,
                                       22.15005312,
                                       1.26,
                                       4.2,
                                       1.282230512,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       2,
                                       21.13255215,
                                       1.38,
                                       6.6,
                                       1.504366282,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       3,
                                       20.38620672,
                                       1.22,
                                       12.2,
                                       1.646379092,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       4,
                                       19.8592108,
                                       1.41,
                                       2.6,
                                       1.313409752,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       5,
                                       18.90243966,
                                       1.02,
                                       8.1,
                                       0.980163746,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       6,
                                       17.02124653,
                                       0.96,
                                       56.9,
                                       2.221613715,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       7,
                                       13.90102569,
                                       1.07,
                                       50.2,
                                       3.036894115,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       8,
                                       13.84305638,
                                       1.52,
                                       15,
                                       1.92057435,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       9,
                                       12.58864948,
                                       1.15,
                                       1.8,
                                       1.049852181,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       10,
                                       11.24153556,
                                       0.942949728,
                                       36.37135724,
                                       0.845229218,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       11,
                                       11.15469852,
                                       1.56,
                                       33.7,
                                       1.554583905,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       12,
                                       10.63355321,
                                       1.556551081,
                                       80.30651025,
                                       1.154786614,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       13,
                                       9.371989194,
                                       1.1,
                                       1.2,
                                       0.948319326,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       14,
                                       9.189772968,
                                       1.48,
                                       27.6,
                                       2.910642024,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       15,
                                       8.47760379,
                                       1.34,
                                       94.7,
                                       1.742267966,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       16,
                                       7.836381489,
                                       1.072247862,
                                       9.942700152,
                                       0.991847401,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       17,
                                       7.470526349,
                                       1.22126257,
                                       45.8954972,
                                       0.802049226,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       18,
                                       7.103112719,
                                       1.194614655,
                                       59.60546757,
                                       0.834122902,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       19,
                                       6.350163474,
                                       1.399574718,
                                       19.99647276,
                                       0.978611305,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       20,
                                       6.229782591,
                                       1.290493376,
                                       27.55509538,
                                       0.697819656,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       21,
                                       5.257736804,
                                       1.54445486,
                                       3.141003597,
                                       1.125221966,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       22,
                                       5.024680061,
                                       1.417941178,
                                       11.79534411,
                                       0.813517482,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       23,
                                       4.726981697,
                                       1.103574943,
                                       3.797092889,
                                       0.843193347,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       24,
                                       4.717167251,
                                       1.302078029,
                                       16.80250948,
                                       0.730234074,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       25,
                                       4.423638278,
                                       1.040741426,
                                       1.542247632,
                                       0.634036306,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       26,
                                       3.468944527,
                                       1.464067178,
                                       1.973997251,
                                       0.792607165,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       27,
                                       3.050363222,
                                       1.476284328,
                                       80.64333778,
                                       0.725985493,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       28,
                                       3.035407012,
                                       0.980088091,
                                       1.152476253,
                                       0.487954869,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       29,
                                       2.93930697,
                                       0.83,
                                       19.6,
                                       0.678668388,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       30,
                                       2.247216232,
                                       1.362921311,
                                       50.50406742,
                                       0.800550353,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       31,
                                       1.90915917,
                                       1.120957751,
                                       4.800255552,
                                       0.598215629,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       32,
                                       1.719663108,
                                       0.832403577,
                                       20.65278532,
                                       0.179248415,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       33,
                                       1.654847411,
                                       1.096680145,
                                       66.35487927,
                                       0.702556801,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       34,
                                       1.645571514,
                                       0.898103037,
                                       7.539866894,
                                       0.190768776,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       35,
                                       1.645340585,
                                       0.866789927,
                                       4.302646073,
                                       0.13413755,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       36,
                                       1.549496238,
                                       0.996982271,
                                       28.19759552,
                                       0.407900009,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       37,
                                       1.511556099,
                                       1.50705351,
                                       1.044500861,
                                       0.557276732,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       38,
                                       1.481273952,
                                       1.580441339,
                                       1.630583861,
                                       0.70797176,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       39,
                                       1.286666582,
                                       1.155223307,
                                       2.145634869,
                                       0.489560031,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       40,
                                       1.257342906,
                                       1.013504235,
                                       2.832101146,
                                       0.14512127,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       41,
                                       1.036072496,
                                       1.2315587,
                                       13.20309211,
                                       0.538277624,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       42,
                                       1.013637043,
                                       1.413812047,
                                       15.28245176,
                                       0.639750696,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       43,
                                       0.836020784,
                                       0.912147792,
                                       41.14075221,
                                       0.208379828,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       44,
                                       0.672891551,
                                       0.842818578,
                                       5.874526581,
                                       0.128212552,
                                       0.03,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       45,
                                       0.536995121,
                                       1.309069321,
                                       3.319612441,
                                       0.642637406,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       46,
                                       0.524058943,
                                       1.252344976,
                                       6.501574726,
                                       0.683000882,
                                       0.01,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       47,
                                       0,
                                       0.9,
                                       1.3,
                                       0.376127951,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       48,
                                       0,
                                       0.89,
                                       4.9,
                                       0.27695286,
                                       0.1,
                                       NULL
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       49,
                                       23.86323649285064,
                                       1.305,
                                       5.762,
                                       1.11495061131424,
                                       0.1,
                                       10000875
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       50,
                                       20.74746801417566,
                                       1.307,
                                       5.249,
                                       0.09805428634392,
                                       0.1,
                                       10000876
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       51,
                                       22.65553974,
                                       1.308,
                                       5.493,
                                       8.976421266,
                                       0.1,
                                       10000877
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       52,
                                       22.57453936,
                                       1.305,
                                       5.4,
                                       0.00020348,
                                       0.1,
                                       10000878
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       53,
                                       22.49837549,
                                       1.307,
                                       5.408,
                                       0.000370084,
                                       0.1,
                                       10000879
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       54,
                                       19.34670348,
                                       1.718,
                                       7.674,
                                       0.0000147,
                                       0.1,
                                       10000880
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       55,
                                       13.14720119,
                                       1.722,
                                       8.027,
                                       0.80832719,
                                       0.1,
                                       10000881
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       56,
                                       6.193329715,
                                       1.757,
                                       24.636,
                                       0.0000509,
                                       0.056,
                                       10000882
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       57,
                                       22.57241064,
                                       1.228,
                                       6.546,
                                       0.000120195,
                                       0.1,
                                       10000883
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       58,
                                       21.89733825,
                                       1.218,
                                       6.674,
                                       0.000209901,
                                       0.1,
                                       10000884
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       59,
                                       21.38175993,
                                       1.218,
                                       6.619,
                                       0.000208387,
                                       0.1,
                                       10000885
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       60,
                                       20.97105217,
                                       1.226,
                                       6.356,
                                       0.000345661,
                                       0.1,
                                       10000886
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       61,
                                       21.13854722,
                                       1.239,
                                       6.14,
                                       0.000136273,
                                       0.1,
                                       10000887
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       62,
                                       20.25071276,
                                       1.253,
                                       6,
                                       0.0000421,
                                       0.1,
                                       10000888
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       63,
                                       19.85975206,
                                       1.259,
                                       5.827,
                                       0.0000926,
                                       0.1,
                                       10000889
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       64,
                                       17.67858134,
                                       1.267,
                                       5.637,
                                       0.000107888,
                                       0.1,
                                       10000890
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       65,
                                       17.13360519,
                                       1.273,
                                       5.67,
                                       0.0000682,
                                       0.1,
                                       10000891
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       66,
                                       16.87181274,
                                       1.277,
                                       5.845,
                                       0.000154147,
                                       0.1,
                                       10000892
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       67,
                                       17.26693918,
                                       1.614,
                                       1.805,
                                       0.00016617,
                                       0.1,
                                       10000893
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       68,
                                       13.43540868,
                                       1.602,
                                       1.757,
                                       0.000123146,
                                       0.1,
                                       10000894
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       69,
                                       22.30174061,
                                       1.305,
                                       5.762,
                                       0.740467284,
                                       0.1,
                                       10000895
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       70,
                                       21.38193384,
                                       1.305,
                                       5.762,
                                       0.000407186,
                                       0.1,
                                       10000896
                                   );

INSERT INTO ml_pedot_training_data (
                                       id,
                                       delta_e,
                                       voltage,
                                       time,
                                       bleach_cp,
                                       concentration,
                                       experiment_id
                                   )
                                   VALUES (
                                       71,
                                       21.41036124,
                                       1.305,
                                       5.762,
                                       0.000195648,
                                       0.1,
                                       10000897
                                   );


-- Table: pipette
CREATE TABLE IF NOT EXISTS pipette (
    id          INTEGER   PRIMARY KEY AUTOINCREMENT,
    capacity_ul FLOAT     NOT NULL,
    capacity_ml FLOAT     NOT NULL,
    volume_ul   FLOAT     NOT NULL,
    volume_ml   FLOAT     NOT NULL,
    contents    TEXT,
    updated     TIMESTAMP DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now', 'localtime') ) 
);

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        1,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        '{}',
                        '2024-06-21 00:38:11.207'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        2,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        '{}',
                        '2024-06-21 00:38:11.215'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        3,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{}',
                        '2024-06-21 00:38:11.223'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        4,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{}',
                        '2024-06-21 00:38:11.231'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        5,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{}',
                        '2024-06-21 00:38:12.055'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        6,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{}',
                        '2024-06-21 00:38:12.063'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        7,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{}',
                        '2024-06-21 00:38:18.625'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        8,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{}',
                        '2024-06-21 00:38:18.637'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        9,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:38:18.650'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        10,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:38:21.199'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        11,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:38:21.207'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        12,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:38:27.724'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        13,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:38:27.731'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        14,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:38:27.763'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        15,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:40:56.976'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        16,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:40:57.779'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        17,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:40:57.787'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        18,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:41:04.311'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        19,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:41:04.318'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        20,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:41:04.326'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        21,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:41:06.854'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        22,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:41:06.862'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        23,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:41:13.380'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        24,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 00:41:13.388'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        25,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:41:13.423'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        26,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:42:13.253'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        27,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:42:13.260'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        28,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:42:19.780'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        29,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0}',
                        '2024-06-21 00:42:19.788'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        30,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:42:19.796'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        31,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:42:22.322'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        32,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:42:22.329'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        33,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:42:28.851'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        34,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:42:28.859'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        35,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:42:28.878'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        36,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:42:28.886'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        37,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:42:57.496'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        38,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:42:57.505'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        39,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:04.023'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        40,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:04.030'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        41,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:04.039'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        42,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:04.045'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        43,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:04.562'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        44,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:04.570'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        45,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:07.080'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        46,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:07.089'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        47,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:13.606'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        48,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:13.615'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        49,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 00:43:13.648'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        50,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:13.655'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        51,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:14.182'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        52,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:14.190'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        53,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:20.709'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        54,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:20.718'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        55,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 00:43:20.726'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        56,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 00:43:23.254'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        57,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 00:43:23.261'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        58,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 00:43:29.782'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        59,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 00:43:29.790'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        60,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:29.825'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        61,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:29.833'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        62,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:30.360'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        63,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:30.368'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        64,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:36.885'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        65,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:36.893'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        66,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:36.901'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        67,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:39.426'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        68,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:39.436'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        69,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:45.953'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        70,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:45.961'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        71,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:45.980'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        72,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:45.987'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        73,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:46.500'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        74,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:46.508'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        75,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:49.021'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        76,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:49.028'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        77,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:49.036'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        78,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:49.044'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        79,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:49.561'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        80,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:49.569'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        81,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:52.078'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        82,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:52.087'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        83,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:58.605'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        84,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:43:58.613'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        85,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:58.644'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        86,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:58.652'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        87,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:59.163'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        88,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:43:59.170'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        89,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:05.690'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        90,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:05.698'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        91,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:05.706'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        92,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:08.233'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        93,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:08.241'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        94,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:14.759'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        95,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:14.767'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        96,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:14.786'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        97,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:14.794'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        98,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:15.305'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        99,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:15.315'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        100,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:17.827'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        101,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:17.836'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        102,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:17.844'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        103,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:17.852'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        104,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:18.370'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        105,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:18.379'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        106,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:20.890'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        107,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:20.899'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        108,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:27.415'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        109,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:27.423'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        110,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:27.456'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        111,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:27.463'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        112,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:27.973'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        113,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:27.980'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        114,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:34.498'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        115,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:34.507'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        116,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:34.515'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        117,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:37.041'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        118,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:37.048'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        119,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:43.569'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        120,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:43.577'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        121,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:43.593'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        122,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:43.602'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        123,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:44.114'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        124,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:44.122'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        125,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:46.635'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        126,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:46.644'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        127,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:46.652'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        128,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:46.659'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        129,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:47.175'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        130,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:47.182'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        131,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:49.692'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        132,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:49.701'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        133,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:56.217'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        134,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:44:56.225'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        135,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:56.258'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        136,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:56.266'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        137,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:56.777'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        138,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:44:56.786'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        139,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:03.305'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        140,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:03.313'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        141,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:03.321'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        142,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:05.850'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        143,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:05.865'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        144,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:12.390'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        145,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:12.398'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        146,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:12.414'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        147,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:12.422'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        148,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:12.934'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        149,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:12.942'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        150,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:15.456'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        151,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:15.464'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        152,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:15.472'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        153,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:15.480'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        154,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:15.998'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        155,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:16.007'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        156,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:18.520'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        157,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:18.529'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        158,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:25.048'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        159,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 00:45:25.056'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        160,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:25.088'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        161,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:25.095'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        162,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:43.434'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        163,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:43.443'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        164,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:49.963'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        165,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 00:45:49.970'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        166,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:45:49.979'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        167,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:45:52.504'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        168,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:45:52.513'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        169,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:45:59.037'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        170,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:45:59.047'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        171,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:45:59.072'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        172,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:45:59.081'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        173,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:45:59.090'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        174,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:27.719'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        175,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:27.728'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        176,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:34.248'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        177,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:34.257'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        178,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:34.264'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        179,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:34.272'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        180,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:34.280'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        181,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:34.799'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        182,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:34.807'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        183,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:37.317'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        184,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:37.325'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        185,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:43.841'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        186,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:43.848'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        187,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:43.882'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        188,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:46:43.889'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        189,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:43.897'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        190,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:44.427'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        191,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:44.434'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        192,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:50.951'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        193,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:50.959'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        194,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:50.966'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        195,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:53.494'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        196,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:46:53.501'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        197,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:47:00.021'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        198,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:47:00.030'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        199,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:47:00.062'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        200,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:47:00.070'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        201,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:47:00.078'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        202,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:48:33.629'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        203,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:48:33.637'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        204,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:48:40.153'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        205,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:48:40.161'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        206,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:48:40.169'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        207,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:48:42.696'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        208,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:48:42.705'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        209,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:48:49.222'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        210,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:48:49.229'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        211,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:48:49.247'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        212,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:48:49.255'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        213,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:48:49.262'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        214,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:17.878'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        215,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:17.888'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        216,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:24.417'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        217,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:24.426'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        218,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:24.435'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        219,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:24.444'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        220,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:24.452'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        221,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:24.994'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        222,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:25.014'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        223,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:27.550'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        224,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:27.560'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        225,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:34.084'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        226,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:34.092'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        227,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:34.126'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        228,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 127.43}',
                        '2024-06-21 00:49:34.134'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        229,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:34.143'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        230,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:34.670'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        231,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:34.678'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        232,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:41.199'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        233,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:41.208'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        234,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:41.216'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        235,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:43.747'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        236,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:43.757'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        237,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:50.276'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        238,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:50.284'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        239,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:50.317'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        240,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:50.326'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        241,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:50.334'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        242,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:50.845'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        243,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:50.855'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        244,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:57.376'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        245,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:57.383'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        246,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:57.390'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        247,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:59.917'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        248,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:49:59.928'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        249,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:06.447'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        250,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:06.455'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        251,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:06.490'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        252,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:06.497'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        253,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:06.505'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        254,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:07.015'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        255,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:07.022'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        256,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:13.537'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        257,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:13.545'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        258,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:13.553'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        259,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:16.081'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        260,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:16.089'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        261,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:22.607'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        262,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:22.615'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        263,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:22.651'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        264,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:22.659'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        265,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0, "liclo4": 0.0}',
                        '2024-06-21 00:50:22.667'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        266,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{}',
                        '2024-06-21 00:50:32.495'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        267,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{}',
                        '2024-06-21 00:50:32.504'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        268,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{}',
                        '2024-06-21 01:58:05.712'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        269,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{}',
                        '2024-06-21 01:58:07.080'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        270,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{}',
                        '2024-06-21 01:58:07.087'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        271,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{}',
                        '2024-06-21 01:58:13.606'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        272,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{}',
                        '2024-06-21 01:58:13.616'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        273,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 140.0}',
                        '2024-06-21 01:58:13.625'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        274,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 01:58:16.153'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        275,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 01:58:16.161'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        276,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 01:58:22.682'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        277,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 01:58:22.691'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        278,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0}',
                        '2024-06-21 01:58:22.726'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        279,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:07.078'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        280,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:08.309'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        281,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:08.316'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        282,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:14.837'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        283,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:14.846'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        284,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 140.0}',
                        '2024-06-21 02:02:14.857'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        285,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 02:02:17.385'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        286,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0}',
                        '2024-06-21 02:02:17.393'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        287,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 02:02:23.915'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        288,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0}',
                        '2024-06-21 02:02:23.923'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        289,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:23.956'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        290,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:33.743'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        291,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:33.752'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        292,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:40.268'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        293,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0}',
                        '2024-06-21 02:02:40.277'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        294,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:02:40.285'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        295,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:09.819'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        296,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:09.827'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        297,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:16.345'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        298,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:16.353'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        299,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:16.373'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        300,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:03:16.381'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        301,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:03:44.985'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        302,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:03:44.994'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        303,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:03:51.511'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        304,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:03:51.519'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        305,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:03:51.527'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        306,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:51.535'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        307,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:52.052'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        308,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:52.060'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        309,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:54.569'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        310,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:03:54.577'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        311,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:04:01.095'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        312,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:04:01.102'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        313,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:04:01.134'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        314,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:04:01.141'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        315,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:04:01.668'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        316,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:04:01.675'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        317,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:04:08.194'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        318,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:04:08.201'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        319,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:04:08.209'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        320,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:04:10.737'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        321,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:04:10.748'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        322,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:16:07.241'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        323,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:16:14.687'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        324,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:16:14.695'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        325,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:14.729'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        326,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:14.737'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        327,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:15.248'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        328,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:15.256'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        329,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:21.773'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        330,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:21.780'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        331,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:16:21.787'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        332,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:16:24.312'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        333,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:16:24.321'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        334,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:16:30.838'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        335,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:16:30.846'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        336,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:30.877'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        337,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:30.885'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        338,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:40.549'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        339,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:40.556'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        340,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:47.073'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        341,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:47.081'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        342,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:16:47.089'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        343,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:16:49.614'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        344,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:16:49.622'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        345,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:16:56.141'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        346,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:16:56.149'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        347,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:16:56.166'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        348,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:16:56.175'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        349,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:24.782'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        350,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:24.789'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        351,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:31.305'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        352,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:31.313'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        353,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:31.321'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        354,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:31.328'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        355,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:31.851'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        356,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:31.858'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        357,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:34.369'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        358,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:34.377'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        359,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:40.896'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        360,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:40.903'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        361,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:17:40.936'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        362,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:40.944'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        363,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:41.472'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        364,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:41.481'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        365,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:47.997'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        366,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:48.006'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        367,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:17:48.016'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        368,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:17:50.546'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        369,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:17:50.554'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        370,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:17:57.075'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        371,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:17:57.082'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        372,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:57.113'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        373,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:57.121'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        374,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:57.652'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        375,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:17:57.662'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        376,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:04.206'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        377,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:04.213'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        378,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:04.221'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        379,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:06.772'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        380,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:06.781'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        381,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:13.308'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        382,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:13.316'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        383,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:13.334'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        384,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:13.342'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        385,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:13.855'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        386,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:13.863'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        387,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:16.378'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        388,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:18:16.388'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        389,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:16.397'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        390,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:16.409'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        391,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:16.929'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        392,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:16.938'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        393,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:19.450'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        394,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:18:19.459'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        395,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:19:30.083'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        396,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:19:37.356'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        397,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 127.43, "edot": 0.0}',
                        '2024-06-21 02:19:37.364'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        398,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:37.396'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        399,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:37.404'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        400,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:37.916'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        401,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:37.924'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        402,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:44.440'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        403,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:44.448'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        404,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:19:44.458'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        405,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:19:46.985'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        406,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:19:46.994'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        407,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:19:53.510'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        408,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:19:53.517'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        409,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:53.549'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        410,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:19:53.556'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        411,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:24:56.985'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        412,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:24:57.558'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        413,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:24:57.565'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        414,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:04.083'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        415,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:04.091'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        416,
                        200.0,
                        0.2,
                        180.0,
                        0.18,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:25:04.099'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        417,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:25:06.625'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        418,
                        200.0,
                        0.2,
                        185.0,
                        0.185,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:25:06.633'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        419,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:25:13.152'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        420,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 140.0, "edot": 0.0}',
                        '2024-06-21 02:25:13.160'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        421,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:13.194'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        422,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:13.202'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        423,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:22.102'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        424,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:22.111'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        425,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:28.627'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        426,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:28.635'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        427,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:25:28.643'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        428,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:25:31.170'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        429,
                        200.0,
                        0.2,
                        172.43,
                        0.17243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:25:31.178'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        430,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:25:37.700'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        431,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:25:37.710'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        432,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:25:37.727'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        433,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:25:37.734'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        434,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:06.346'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        435,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:06.353'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        436,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:12.870'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        437,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:12.877'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        438,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:12.886'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        439,
                        200.0,
                        0.2,
                        167.43,
                        0.16743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:12.893'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        440,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:13.409'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        441,
                        200.0,
                        0.2,
                        187.43,
                        0.18743,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:13.417'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        442,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:15.929'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        443,
                        200.0,
                        0.2,
                        192.43,
                        0.19243,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:15.937'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        444,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:22.454'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        445,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:22.461'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        446,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 127.43}',
                        '2024-06-21 02:26:22.490'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        447,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:22.497'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        448,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:23.024'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        449,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:23.032'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        450,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:29.548'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        451,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:29.556'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        452,
                        200.0,
                        0.2,
                        160.0,
                        0.16,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:26:29.564'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        453,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:26:32.090'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        454,
                        200.0,
                        0.2,
                        165.0,
                        0.165,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:26:32.098'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        455,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:26:38.619'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        456,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 120.0, "edot": 0.0}',
                        '2024-06-21 02:26:38.626'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        457,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:38.658'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        458,
                        200.0,
                        0.2,
                        0.0,
                        0.0,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:38.666'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        459,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:39.192'
                    );

INSERT INTO pipette (
                        id,
                        capacity_ul,
                        capacity_ml,
                        volume_ul,
                        volume_ml,
                        contents,
                        updated
                    )
                    VALUES (
                        460,
                        200.0,
                        0.2,
                        40.0,
                        0.04,
                        '{"rinse": 0.0, "edot": 0.0}',
                        '2024-06-21 02:26:39.200'
                    );


-- Table: projects
CREATE TABLE IF NOT EXISTS projects (
    id           INTEGER PRIMARY KEY,
    project_name TEXT
);

INSERT INTO projects (
                         id,
                         project_name
                     )
                     VALUES (
                         999,
                         'testing'
                     );


-- Table: protocols
CREATE TABLE IF NOT EXISTS protocols (
    id       INTEGER PRIMARY KEY,
    project  INTEGER,
    name     TEXT,
    filepath TEXT
);

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          1,
                          '',
                          'exp_a_2_ferrocyanide_assessment_protocol.py',
                          'exp_a_2_ferrocyanide_assessment_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          2,
                          '',
                          'exp_a_ferrocyanide_assessment_protocol.py',
                          'exp_a_ferrocyanide_assessment_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          3,
                          '',
                          'exp_b_pipette_contamination_assessment_protocol.py',
                          'exp_b_pipette_contamination_assessment_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          4,
                          '',
                          'exp_c_rinsing_assessment_protocol.py',
                          'exp_c_rinsing_assessment_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          5,
                          '',
                          'exp_d2_mixing_assessment_protocol.py',
                          'exp_d2_mixing_assessment_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          6,
                          '',
                          'exp_d_mixing_assessment_protocol.py',
                          'exp_d_mixing_assessment_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          7,
                          '',
                          'exp_edot_bleaching_protocol.py',
                          'exp_edot_bleaching_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          8,
                          '',
                          'exp_edot_repeatability_protocol.py',
                          'exp_edot_repeatability_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          9,
                          '',
                          'exp_edot_repeatability_protocol_v2.py',
                          'exp_edot_repeatability_protocol_v2.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          10,
                          '',
                          'exp_edot_screening_protocol_v1.py',
                          'exp_edot_screening_protocol_v1.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          11,
                          '',
                          'exp_edot_screening_protocol_v2.py',
                          'exp_edot_screening_protocol_v2.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          12,
                          '',
                          'exp_edot_screening_protocol_v3.py',
                          'exp_edot_screening_protocol_v3.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          13,
                          '',
                          'exp_edot_screening_protocol_v4.py',
                          'exp_edot_screening_protocol_v4.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          14,
                          '',
                          'exp_edot_voltage_sweep_protocol.py',
                          'exp_edot_voltage_sweep_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          15,
                          '',
                          'exp_fecn_conc_assessment_protocol.py',
                          'exp_fecn_conc_assessment_protocol.py'
                      );

INSERT INTO protocols (
                          id,
                          project,
                          name,
                          filepath
                      )
                      VALUES (
                          16,
                          '',
                          'system_test.py',
                          'system_test.py'
                      );


-- Table: slack_tickets
CREATE TABLE IF NOT EXISTS slack_tickets (
    msg_id              TEXT    PRIMARY KEY
                                NOT NULL
                                UNIQUE,
    channel_id          TEXT    NOT NULL,
    message             TEXT    NOT NULL,
    response            INTEGER,
    timestamp           TEXT,
    addressed_timestamp TEXT,
    db_timestamp        TEXT    DEFAULT (datetime('now', 'localtime') ) 
);


-- Table: system_status
CREATE TABLE IF NOT EXISTS system_status (
    id          INTEGER   PRIMARY KEY AUTOINCREMENT,
    status      TEXT      NOT NULL,
    comment     TEXT,
    status_time TIMESTAMP DEFAULT (datetime('now', 'utc') ),
    test_mode   BOOLEAN
);

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              1,
                              'on',
                              'at main menu',
                              '2024-06-21 08:36:46',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              2,
                              'idle',
                              'at main menu',
                              '2024-06-21 08:36:47',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              3,
                              'running',
                              'changing wellplate',
                              '2024-06-21 08:37:27',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              4,
                              'idle',
                              'at main menu',
                              '2024-06-21 08:37:47',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              5,
                              'running',
                              'generating experiment files',
                              '2024-06-21 08:37:59',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              6,
                              'idle',
                              'at main menu',
                              '2024-06-21 08:38:02',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              7,
                              'running',
                              'running ePANDA',
                              '2024-06-21 08:38:06',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              8,
                              'running',
                              NULL,
                              '2024-06-21 08:38:27',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              9,
                              'running',
                              NULL,
                              '2024-06-21 08:38:28',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              10,
                              'on',
                              'at main menu',
                              '2024-06-21 08:40:38',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              11,
                              'idle',
                              'at main menu',
                              '2024-06-21 08:40:39',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              12,
                              'running',
                              'running ePANDA',
                              '2024-06-21 08:40:52',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              13,
                              'running',
                              NULL,
                              '2024-06-21 08:41:13',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              14,
                              'running',
                              NULL,
                              '2024-06-21 08:41:13',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              15,
                              'idle',
                              NULL,
                              '2024-06-21 08:50:40',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              16,
                              'idle',
                              'at main menu',
                              '2024-06-21 08:50:40',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              17,
                              'off',
                              'exiting ePANDA',
                              '2024-06-21 08:50:46',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              18,
                              'on',
                              'at main menu',
                              '2024-06-21 09:57:50',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              19,
                              'idle',
                              'at main menu',
                              '2024-06-21 09:57:51',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              20,
                              'running',
                              'running ePANDA',
                              '2024-06-21 09:58:01',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              21,
                              'running',
                              NULL,
                              '2024-06-21 09:58:22',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              22,
                              'running',
                              NULL,
                              '2024-06-21 09:58:22',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              23,
                              'on',
                              'at main menu',
                              '2024-06-21 10:01:53',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              24,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:01:54',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              25,
                              'running',
                              'running ePANDA',
                              '2024-06-21 10:02:00',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              26,
                              'running',
                              NULL,
                              '2024-06-21 10:02:24',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              27,
                              'running',
                              NULL,
                              '2024-06-21 10:02:24',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              28,
                              'error',
                              NULL,
                              '2024-06-21 10:04:21',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              29,
                              'idle',
                              NULL,
                              '2024-06-21 10:04:33',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              30,
                              'on',
                              'at main menu',
                              '2024-06-21 10:04:59',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              31,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:05:00',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              32,
                              'on',
                              'at main menu',
                              '2024-06-21 10:10:39',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              33,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:10:40',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              34,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:12:39',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              35,
                              'on',
                              'at main menu',
                              '2024-06-21 10:14:24',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              36,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:14:25',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              37,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:14:28',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              38,
                              'running',
                              'running ePANDA',
                              '2024-06-21 10:15:32',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              39,
                              'running',
                              NULL,
                              '2024-06-21 10:16:31',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              40,
                              'running',
                              NULL,
                              '2024-06-21 10:16:31',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              41,
                              'error',
                              NULL,
                              '2024-06-21 10:18:28',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              42,
                              'idle',
                              NULL,
                              '2024-06-21 10:18:39',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              43,
                              'on',
                              'at main menu',
                              '2024-06-21 10:19:20',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              44,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:19:22',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              45,
                              'running',
                              'running ePANDA',
                              '2024-06-21 10:19:25',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              46,
                              'running',
                              NULL,
                              '2024-06-21 10:19:53',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              47,
                              'running',
                              NULL,
                              '2024-06-21 10:19:53',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              48,
                              'on',
                              'at main menu',
                              '2024-06-21 10:22:09',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              49,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:22:10',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              50,
                              'running',
                              'running ePANDA',
                              '2024-06-21 10:22:14',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              51,
                              'on',
                              'at main menu',
                              '2024-06-21 10:24:49',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              52,
                              'idle',
                              'at main menu',
                              '2024-06-21 10:24:50',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              53,
                              'running',
                              'running ePANDA',
                              '2024-06-21 10:24:52',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              54,
                              'running',
                              NULL,
                              '2024-06-21 10:25:13',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              55,
                              'running',
                              NULL,
                              '2024-06-21 10:25:13',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              56,
                              'error',
                              NULL,
                              '2024-06-21 10:26:50',
                              1
                          );

INSERT INTO system_status (
                              id,
                              status,
                              comment,
                              status_time,
                              test_mode
                          )
                          VALUES (
                              57,
                              'idle',
                              NULL,
                              '2024-06-21 10:26:59',
                              1
                          );


-- Table: system_versions
CREATE TABLE IF NOT EXISTS system_versions (
    id                  INTEGER       PRIMARY KEY,
    mill                INTEGER       NOT NULL,
    pump                TEXT          DEFAULT '00',
    potentiostat        TEXT          DEFAULT '00',
    reference_electrode TEXT          DEFAULT '00',
    working_electrode   TEXT          DEFAULT '00',
    wells               TEXT          DEFAULT '00',
    pipette_adapter     TEXT          DEFAULT '00',
    optics              TEXT          DEFAULT '00',
    scale               TEXT          DEFAULT '00',
    camera              TEXT          DEFAULT '00',
    lens                TEXT          DEFAULT '00',
    pin                 '"[TEXT ] " ' GENERATED ALWAYS AS (CAST (mill AS TEXT) || ' ' || CAST (pump AS TEXT) || ' ' || CAST (potentiostat AS TEXT) || ' ' || CAST (reference_electrode AS TEXT) || ' ' || CAST (working_electrode AS TEXT) || ' ' || CAST (wells AS TEXT) || ' ' || CAST (pipette_adapter AS TEXT) || ' ' || CAST (optics AS TEXT) || ' ' || CAST (scale AS TEXT) || ' ' || CAST (camera AS TEXT) || ' ' || CAST (lens AS TEXT) ) STORED
);

INSERT INTO system_versions (
                                id,
                                mill,
                                pump,
                                potentiostat,
                                reference_electrode,
                                working_electrode,
                                wells,
                                pipette_adapter,
                                optics,
                                scale,
                                camera,
                                lens
                            )
                            VALUES (
                                1,
                                2,
                                '01',
                                '01',
                                '01',
                                '02',
                                '04',
                                '05',
                                '00',
                                '00',
                                '01',
                                '01'
                            );


-- Table: vials
CREATE TABLE IF NOT EXISTS vials (
    id               INTEGER   PRIMARY KEY AUTOINCREMENT,
    position         TEXT,
    contents         TEXT,
    viscosity_cp     REAL,
    concentration    REAL,
    density          REAL,
    category         INTEGER,
    radius           INTEGER,
    height           INTEGER,
    depth            INTEGER,
    name             TEXT,
    volume           REAL,
    capacity         INTEGER,
    contamination    INTEGER,
    vial_coordinates TEXT,
    updated          TIMESTAMP DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now', 'localtime') ) 
);

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      1,
                      's0',
                      'none',
                      0.91,
                      1.0,
                      0.99714,
                      0,
                      14,
                      57,
-                     74,
                      'none',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -39, ''z_bottom'': -74}',
                      '2024-05-11 02:57:49'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      2,
                      's1',
                      'liclo4',
                      0.9,
                      1.0,
                      0.99714,
                      0,
                      14,
                      57,
-                     74,
                      'liclo4',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -72, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      3,
                      's2',
                      'edot',
                      0.91,
                      0.01,
                      0.99714,
                      0,
                      14,
                      57,
-                     74,
                      'edot',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -105, ''z_bottom'': -74}',
                      '2024-05-11 02:57:49'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      4,
                      's3',
                      'edot',
                      0.91,
                      0.03,
                      0.99714,
                      0,
                      14,
                      57,
-                     74,
                      'edot',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -138, ''z_bottom'': -74}',
                      '2024-05-11 02:57:49'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      5,
                      's4',
                      'edot',
                      0.91,
                      0.1,
                      0.99714,
                      0,
                      14,
                      57,
-                     74,
                      'edot',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -171, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      6,
                      's5',
                      'rinse',
                      0.91,
                      1.0,
                      1.1545,
                      0,
                      14,
                      57,
-                     74,
                      'rinse',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -204, ''z_bottom'': -74}',
                      '2024-05-11 02:57:49'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      7,
                      's6',
                      'rinse',
                      0.91,
                      1.0,
                      1.1945,
                      0,
                      14,
                      57,
                      0,
                      'rinse',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -237, ''z_bottom'': -74}',
                      '2024-05-11 02:57:49'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      8,
                      's7',
                      'none',
                      0.91,
                      1.0,
                      1.1545,
                      0,
                      14,
                      57,
-                     74,
                      'none',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -4, ''y'': -270, ''z_bottom'': -74}',
                      '2024-05-11 02:57:49'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      9,
                      'e1',
                      'electrolyte',
                      0.9,
                      1.0,
                      0.99714,
                      0,
                      14,
                      57,
                      0,
                      'electrode_bath',
                      20000.0,
                      20000,
                      0,
                      '{''x'': -409, ''y'': -34.4, ''z_bottom'': -50}',
                      '2024-05-11 02:57:49'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      10,
                      'w0',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
-                     74,
                      'waste',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -7, ''z_bottom'': -74}',
                      '2024-05-29 18:55:40.237'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      11,
                      'w1',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
-                     74,
                      'waste',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -40, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      12,
                      'w2',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
-                     74,
                      'waste',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -73, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      13,
                      'w3',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
                      0,
                      'waste',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -106, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      14,
                      'w4',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
                      0,
                      'none',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -139, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      15,
                      'w5',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
                      0,
                      'none',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -172, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      16,
                      'w6',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
                      0,
                      'none',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -205, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );

INSERT INTO vials (
                      id,
                      position,
                      contents,
                      viscosity_cp,
                      concentration,
                      density,
                      category,
                      radius,
                      height,
                      depth,
                      name,
                      volume,
                      capacity,
                      contamination,
                      vial_coordinates,
                      updated
                  )
                  VALUES (
                      17,
                      'w7',
                      '{}',
                      0.0,
                      '',
                      0.0,
                      1,
                      14,
                      57,
                      0,
                      'none',
                      1000.0,
                      20000,
                      0,
                      '{''x'': -50, ''y'': -238, ''z_bottom'': -74}',
                      '2024-05-11 03:00:34'
                  );


-- Table: well_hx
CREATE TABLE IF NOT EXISTS well_hx (
    plate_id      INTEGER,
    well_id       TEXT,
    experiment_id INTEGER,
    project_id    INTEGER,
    status        TEXT,
    status_date   DATETIME DEFAULT (CURRENT_TIMESTAMP),
    contents      JSON,
    volume        REAL,
    coordinates   JSON,
    updated       DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (
        plate_id,
        well_id
    )
);


-- Table: well_types
CREATE TABLE IF NOT EXISTS well_types (
    id                   INTEGER PRIMARY KEY,
    substrate            TEXT,
    gasket               TEXT,
    count                INTEGER,
    shape                TEXT,
    radius_mm            REAL,
    offset_mm            REAL,
    height_mm            REAL,
    max_liquid_height_mm REAL,
    capacity_ul          REAL
);

INSERT INTO well_types (
                           id,
                           substrate,
                           gasket,
                           count,
                           shape,
                           radius_mm,
                           offset_mm,
                           height_mm,
                           max_liquid_height_mm,
                           capacity_ul
                       )
                       VALUES (
                           1,
                           'gold',
                           'grace bio-labs',
                           96,
                           'square',
                           4.0,
                           9.0,
                           7.0,
                           6.0,
                           300.0
                       );

INSERT INTO well_types (
                           id,
                           substrate,
                           gasket,
                           count,
                           shape,
                           radius_mm,
                           offset_mm,
                           height_mm,
                           max_liquid_height_mm,
                           capacity_ul
                       )
                       VALUES (
                           2,
                           'ito',
                           'grace bio-labs',
                           96,
                           'square',
                           4.0,
                           9.0,
                           7.0,
                           6.0,
                           300.0
                       );

INSERT INTO well_types (
                           id,
                           substrate,
                           gasket,
                           count,
                           shape,
                           radius_mm,
                           offset_mm,
                           height_mm,
                           max_liquid_height_mm,
                           capacity_ul
                       )
                       VALUES (
                           3,
                           'gold',
                           'pdms',
                           96,
                           'circular',
                           3.25,
                           8.9,
                           6.0,
                           4.5,
                           150.0
                       );

INSERT INTO well_types (
                           id,
                           substrate,
                           gasket,
                           count,
                           shape,
                           radius_mm,
                           offset_mm,
                           height_mm,
                           max_liquid_height_mm,
                           capacity_ul
                       )
                       VALUES (
                           4,
                           'ito',
                           'pdms',
                           96,
                           'circular',
                           3.25,
                           9.0,
                           6.0,
                           4.5,
                           150.0
                       );


-- Table: wellplates
CREATE TABLE IF NOT EXISTS wellplates (
    id      INTEGER NOT NULL
                    PRIMARY KEY,
    type_id INTEGER,
    current BOOLEAN DEFAULT 0,
    FOREIGN KEY (
        type_id
    )
    REFERENCES well_types (id) 
);


-- Index: idx_unique_current
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_current ON wellplates (
    current
)
WHERE current = 1;


-- Index: idx_vials_position
CREATE INDEX IF NOT EXISTS idx_vials_position ON vials (
    position
);


-- Index: idx_vials_updated
CREATE INDEX IF NOT EXISTS idx_vials_updated ON vials (
    updated
);


-- Index: msg_id_index
CREATE INDEX IF NOT EXISTS msg_id_index ON slack_tickets (
    msg_id,
    timestamp DESC
);


-- Trigger: update_timestamp_experiments
CREATE TRIGGER IF NOT EXISTS update_timestamp_experiments
                       AFTER UPDATE OF experiment_id,
                                       project_id,
                                       project_campaign_id,
                                       well_type,
                                       protocol_id,
                                       pin,
                                       experiment_type,
                                       jira_issue_key,
                                       priority,
                                       process_type,
                                       filename,
                                       created
                          ON experiments
                    FOR EACH ROW
BEGIN
    UPDATE experiments
       SET updated = datetime('now', 'localtime') 
     WHERE experiment_id = OLD.experiment_id;
END;


-- Trigger: update_timestamp_pipette
CREATE TRIGGER IF NOT EXISTS update_timestamp_pipette
                       AFTER UPDATE OF capacity_ul,
                                       capacity_ml,
                                       volume_ul,
                                       volume_ml,
                                       contents
                          ON pipette
                    FOR EACH ROW
BEGIN
    UPDATE pipette
       SET updated = strftime('%Y-%m-%d %H:%M:%f', 'now', 'localtime') 
     WHERE id = OLD.id;
END;


-- Trigger: update_timestamp_vials
CREATE TRIGGER IF NOT EXISTS update_timestamp_vials
                       AFTER UPDATE OF position,
                                       contents,
                                       viscosity_cp,
                                       concentration,
                                       density,
                                       category,
                                       radius,
                                       height,
                                       depth,
                                       name,
                                       volume,
                                       capacity,
                                       contamination,
                                       vial_coordinates
                          ON vials
                    FOR EACH ROW
BEGIN
    UPDATE vials
       SET updated = strftime('%Y-%m-%d %H:%M:%f', 'now', 'localtime') 
     WHERE id = OLD.id;
END;


-- Trigger: update_timestamp_well_hx
CREATE TRIGGER IF NOT EXISTS update_timestamp_well_hx
                       AFTER UPDATE OF plate_id,
                                       well_id,
                                       experiment_id,
                                       project_id,
                                       status,
                                       status_date,
                                       contents,
                                       volume,
                                       coordinates
                          ON well_hx
                    FOR EACH ROW
BEGIN
    UPDATE well_hx
       SET updated = datetime('now', 'localtime') 
     WHERE plate_id = OLD.plate_id AND 
           well_id = OLD.well_id;
END;


-- Trigger: update_timstamp_parameters
CREATE TRIGGER IF NOT EXISTS update_timstamp_parameters
                      BEFORE UPDATE OF experiment_id,
                                       parameter_name,
                                       parameter_value,
                                       created
                          ON experiment_parameters
                    FOR EACH ROW
BEGIN
    UPDATE experiment_parameters
       SET updated = datetime('now', 'localtime') 
     WHERE id = OLD.id;
END;


-- Trigger: update_timstamp_results
CREATE TRIGGER IF NOT EXISTS update_timstamp_results
                       AFTER UPDATE OF experiment_id,
                                       result_type,
                                       result_value,
                                       created,
                                       context
                          ON experiment_results
                    FOR EACH ROW
BEGIN
    UPDATE experiment_results
       SET updated = datetime('now', 'localtime') 
     WHERE id = OLD.id;
END;


-- View: experiment_params
CREATE VIEW IF NOT EXISTS experiment_params AS
    SELECT experiment_id,
           MAX(CASE WHEN parameter_name = 'experiment_name' THEN parameter_value END) AS experiment_name,
           MAX(CASE WHEN parameter_name = 'solutions' THEN parameter_value END) AS solutions,
           MAX(CASE WHEN parameter_name = 'solutions_corrected' THEN parameter_value END) AS solutions_corrected,
           MAX(CASE WHEN parameter_name = 'well_type_number' THEN parameter_value END) AS well_type_number,
           MAX(CASE WHEN parameter_name = 'pumping_rate' THEN parameter_value END) AS pumping_rate,
           MAX(CASE WHEN parameter_name = 'plate_id' THEN parameter_value END) AS plate_id,
           MAX(CASE WHEN parameter_name = 'override_well_selection' THEN parameter_value END) AS override_well_selection,
           MAX(CASE WHEN parameter_name = 'ocp' THEN parameter_value END) AS ocp,
           MAX(CASE WHEN parameter_name = 'ca' THEN parameter_value END) AS ca,
           MAX(CASE WHEN parameter_name = 'cv' THEN parameter_value END) AS cv,
           MAX(CASE WHEN parameter_name = 'baseline' THEN parameter_value END) AS baseline,
           MAX(CASE WHEN parameter_name = 'flush_sol_name' THEN parameter_value END) AS flush_sol_name,
           MAX(CASE WHEN parameter_name = 'flush_vol' THEN parameter_value END) AS flush_vol,
           MAX(CASE WHEN parameter_name = 'mix_count' THEN parameter_value END) AS mix_count,
           MAX(CASE WHEN parameter_name = 'mix_volume' THEN parameter_value END) AS mix_volume,
           MAX(CASE WHEN parameter_name = 'rinse_count' THEN parameter_value END) AS rinse_count,
           MAX(CASE WHEN parameter_name = 'rinse_vol' THEN parameter_value END) AS rinse_vol,
           MAX(CASE WHEN parameter_name = 'ca_sample_period' THEN parameter_value END) AS ca_sample_period,
           MAX(CASE WHEN parameter_name = 'ca_prestep_voltage' THEN parameter_value END) AS ca_prestep_voltage,
           MAX(CASE WHEN parameter_name = 'ca_prestep_time_delay' THEN parameter_value END) AS ca_prestep_time_delay,
           MAX(CASE WHEN parameter_name = 'ca_step_1_voltage' THEN parameter_value END) AS ca_step_1_voltage,
           MAX(CASE WHEN parameter_name = 'ca_step_1_time' THEN parameter_value END) AS ca_step_1_time,
           MAX(CASE WHEN parameter_name = 'ca_step_2_voltage' THEN parameter_value END) AS ca_step_2_voltage,
           MAX(CASE WHEN parameter_name = 'ca_step_2_time' THEN parameter_value END) AS ca_step_2_time,
           MAX(CASE WHEN parameter_name = 'ca_sample_rate' THEN parameter_value END) AS ca_sample_rate,
           MAX(CASE WHEN parameter_name = 'char_sol_name' THEN parameter_value END) AS char_sol_name,
           MAX(CASE WHEN parameter_name = 'char_vol' THEN parameter_value END) AS char_vol,
           MAX(CASE WHEN parameter_name = 'cv_sample_period' THEN parameter_value END) AS cv_sample_period,
           MAX(CASE WHEN parameter_name = 'cv_initial_voltage' THEN parameter_value END) AS cv_initial_voltage,
           MAX(CASE WHEN parameter_name = 'cv_first_anodic_peak' THEN parameter_value END) AS cv_first_anodic_peak,
           MAX(CASE WHEN parameter_name = 'cv_second_anodic_peak' THEN parameter_value END) AS cv_second_anodic_peak,
           MAX(CASE WHEN parameter_name = 'cv_final_voltage' THEN parameter_value END) AS cv_final_voltage,
           MAX(CASE WHEN parameter_name = 'cv_step_size' THEN parameter_value END) AS cv_step_size,
           MAX(CASE WHEN parameter_name = 'cv_cycle_count' THEN parameter_value END) AS cv_cycle_count,
           MAX(CASE WHEN parameter_name = 'cv_scan_rate_cycle_1' THEN parameter_value END) AS cv_scan_rate_cycle_1,
           MAX(CASE WHEN parameter_name = 'cv_scan_rate_cycle_2' THEN parameter_value END) AS cv_scan_rate_cycle_2,
           MAX(CASE WHEN parameter_name = 'cv_scan_rate_cycle_3' THEN parameter_value END) AS cv_scan_rate_cycle_3,
           MAX(CASE WHEN parameter_name = 'edot_concentration' THEN parameter_value END) AS edot_concentration
      FROM experiment_parameters
     GROUP BY experiment_id
     ORDER BY experiment_id DESC;


-- View: new_wellplates
CREATE VIEW IF NOT EXISTS new_wellplates AS
    SELECT wh.plate_id,
           wp.type_id
      FROM well_hx wh
           JOIN
           wellplates wp ON wh.plate_id = wp.id
     WHERE wh.status = 'new'
     GROUP BY wh.plate_id
    HAVING COUNT( * ) = 96;


-- View: pipette_status
CREATE VIEW IF NOT EXISTS pipette_status AS
    SELECT *
      FROM pipette-- WHERE updated = (SELECT MAX(updated) FROM pipette)
     WHERE id = (
                    SELECT MAX(id) 
                      FROM pipette
                )
     LIMIT 1;


-- View: queue
CREATE VIEW IF NOT EXISTS queue AS
    SELECT a.experiment_id,
           a.project_id,
           a.priority,
           a.process_type,
           a.filename,
           a.well_type AS [well type],
           c.well_id,
           c.status,
           c.status_date
      FROM experiments AS a
           JOIN
           wellplates AS b ON a.well_type = b.type_id
           JOIN
           well_hx AS c ON a.experiment_id = c.experiment_id AND 
                           c.status IN ('queued', 'waiting') 
     WHERE b.current = 1
     ORDER BY a.priority DESC,
              a.experiment_id ASC;


-- View: vial_status
CREATE VIEW IF NOT EXISTS vial_status AS
    SELECT v1.*
      FROM vials v1
           LEFT JOIN
           vials v2 ON v1.position = v2.position AND 
                       (v1.updated < v2.updated OR 
                        (v1.updated = v2.updated AND 
                         v1.id < v2.id) ) 
     WHERE v2.id IS NULL;


-- View: well_status
CREATE VIEW IF NOT EXISTS well_status AS
    SELECT a.plate_id,
           b.type_id AS type_number,
           a.well_id,
           a.status,
           a.status_date,
           a.contents,
           a.experiment_id,
           a.project_id,
           a.volume,
           a.coordinates,
           c.capacity_ul AS capacity,
           c.height_mm AS height
      FROM well_hx AS a
           JOIN
           wellplates AS b ON a.plate_id = b.id
           JOIN
           well_types AS c ON b.type_id = c.id
     WHERE b.current = 1
     ORDER BY SUBSTRING(a.well_id, 1, 1),
              CAST (SUBSTRING(a.well_id, 2) AS UNSIGNED);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
