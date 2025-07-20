#!/bin/bash
set -e

extra_args=""

if [ "${USE_MERGE_INSTALL:-true}" == "true" ]; then
    extra_args+=" --merge-install"
fi

if [ -f install/setup.bash ]; then source install/setup.bash; fi
colcon test \
    $extra_args
colcon test-result --verbose
