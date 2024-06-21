"""Utilities for working with generators in the database."""

from panda_lib.sql_tools.sql_protocols_and_generators import (
    GeneratorEntry,
    get_generators,
    get_generator_by_id,
    insert_generator,
    update_generator,
    delete_generator,
    read_in_generators,
    get_generator_id,
    get_generator_name,
    run_generator
    )

if __name__ == "__main__":
    read_in_generators()
    generators_in_db = get_generators()
    for each_generator in generators_in_db:
        print(each_generator)
