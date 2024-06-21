
def test_parse():
    """Test that the class can be parsed from json and back"""
    value = make_test_value()
    print(f"Original---> {value}")
    sample_json = RootModel[ExperimentBase](value).model_dump_json(indent=4)
    parsed_value = RootModel[ExperimentBase].model_validate_json(sample_json).root
    print(f"Parsed--->{parsed_value}")
    assert value == parsed_value


def test_serialize_experiment():
    """Test that the class can be serialized to json"""
    value = make_test_value()
    sample_json = RootModel[ExperimentBase](value).model_dump_json(indent=4)
    print(sample_json)
    with open("temp_test_file.json", "w", encoding="UTF-8") as f:
        f.write(sample_json)


def test_serialize_experimentbase():
    """Test that the class can be serialized to json"""
    value = make_test_base_value()
    sample_json = RootModel[ExperimentBase](value).model_dump_json(indent=4)
    print(sample_json)
    with open("temp_test_file.json", "w", encoding="UTF-8") as f:
        f.write(sample_json)


# def test_serialize_layered_experiment():
#     '''Test that the class can be serialized to json'''
#     value = make_test_layered_value()
#     sample_json = RootModel[LayeredExperiments](value).model_dump_json(indent=4)
#     print(sample_json)
#     with open('temp_test_file.json', 'w', encoding='UTF-8') as f:
#         f.write(sample_json)


def test_serialize_results():
    """Test that the class can be serialized to json"""
    value = ExperimentResult(
        experiment_id=0,
        well_id="D5",
        ocp_ca_file=["ocp_dep_file"],
        ocp_ca_passed=[True],
        ocp_cv_file=["ocp_char_file"],
        ocp_cv_passed=[True],
        ca_data_file=["deposition_data_file"],
        # deposition_plot_files=["deposition_plot_file"],
        # deposition_max_values=[0.0],
        # depsotion_min_values=[0.0],
        cv_data_file=["characterization_data_file"],
        # characterization_plot_files=["characterization_plot_file"],
        # characterization_max_values=[0.0],
        # characterization_min_values=[0.0],
    )
    sample_json = RootModel[ExperimentResult](value).model_dump_json(indent=4)
    print(sample_json)
    with open("temp_test_file.json", "w", encoding="UTF-8") as f:
        f.write(sample_json)


def test_schema():
    """Test that the class can generate a json schema"""
    # Useful if you have tools that validate your json externally
    print(json.dumps(TypeAdapter(ExperimentBase).json_schema(), indent=4))

