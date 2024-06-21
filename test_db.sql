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

-- Table: generators
CREATE TABLE IF NOT EXISTS generators (
    id          INTEGER NOT NULL
                        PRIMARY KEY AUTOINCREMENT,
    project_id  INTEGER,
    protocol_id INTEGER,
    name        TEXT,
    filepath    TEXT
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
