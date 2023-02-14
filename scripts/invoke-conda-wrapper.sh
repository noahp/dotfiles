#!/usr/bin/env bash

# This runs invoke via a configured wrapper method, if not already in a conda
# environment

if [[ -z "$CONDA_DEFAULT_ENV" ]]; then
    # Not in a conda environment, so run via the wrapper

    if [[ -z "$DEFAULT_CONDA_RUN_ENV" ]]; then
        echo "ERROR: DEFAULT_CONDA_RUN_ENV not set"
        exit 1
    fi

    conda run -n "${DEFAULT_CONDA_RUN_ENV}" invoke "$@"
else
    # Already in a conda environment, so just run invoke
    invoke "$@"
fi
