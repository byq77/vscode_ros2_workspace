# Copyright 2025 byq77
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/usr/bin/env bash

set -e

if [ -z "${1}" ]; then
    echo "Usage: $0 <package_name|all>"
    echo "Example: $0 my_package"
    exit 1
fi

BUILD_TYPE="${BUILD_TYPE:-RelWithDebInfo}"

colcon_build() {
    local extra_args="$1"
    local install_config=""
    local extra_cmake=""
    local parallel_workers="${PARALLEL_WORKERS:-4}"

    if [ "${USE_MERGE_INSTALL:-true}" == "true" ]; then
        install_config+=" --merge-install"
    fi

    if [ "${USE_SYMLINK_INSTALL:-true}" == "true" ]; then
        install_config+=" --symlink-install"
    fi

    if [ "${USE_CMAKE_CLEAN_FIRST:-false}" == "true" ]; then
        extra_cmake+=" --cmake-clean-first"
    fi

    if [ "${USE_CMAKE_CLEAN_CACHE:-false}" == "true" ]; then
        extra_cmake+=" --cmake-clean-cache"
    fi

    echo "Building with install config: $install_config"
    echo "Extra CMake args: ${extra_cmake:-None}"

    colcon build \
        $install_config \
        --parallel-workers $parallel_workers \
        --base-paths "/ros_ws/src" \
        --cmake-args "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
        -Wall -Wextra -Wpedantic \
        $extra_cmake \
        $extra_args
}

if [ "${1}" == "all" ]; then
    echo "Building all packages in the workspace with build type: ${BUILD_TYPE}."
    colcon_build ""
else
    PKG="${1}"
    echo "Building package: $PKG with build type: ${BUILD_TYPE}"
    colcon_build "--packages-select $PKG"
fi
