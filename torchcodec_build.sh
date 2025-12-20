#!/usr/bin/env bash
set -euo pipefail

########################################
# System dependencies (APT)
########################################

sudo apt update
sudo apt install -y \
  build-essential \
  cmake \
  ninja-build \
  python3-dev \
  pkg-config \
  libavdevice-dev \
  libavfilter-dev \
  libavformat-dev \
  libavcodec-dev \
  libavutil-dev \
  libswresample-dev \
  libswscale-dev

########################################
# User-adjustable paths
########################################

PROJECT_ROOT="/home/luke/dev/torchcodec"
VENV_PYTHON="/home/luke/dev/transcript/venv/bin/python"
TORCH_DIR="/home/luke/dev/transcript/venv/lib/python3.10/site-packages/torch/share/cmake/Torch"
CUDA_HOME="/usr/local/cuda"
WHEEL_OUTPUT="$HOME/wheels"

########################################
# Python build dependencies
########################################

"$VENV_PYTHON" -m pip install --upgrade \
  pip \
  setuptools \
  wheel \
  pybind11

########################################
# CUDA environment
########################################

export CUDA_HOME="$CUDA_HOME"
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
export ENABLE_CUDA=ON

# REQUIRED: defeat -Werror=attributes from PyTorch toolchain
export CXXFLAGS="-Wno-error=attributes -Wno-attributes"
export CFLAGS="-Wno-error=attributes -Wno-attributes"

# pybind11 CMake config location
export pybind11_DIR="$($VENV_PYTHON -c 'import pybind11; print(pybind11.get_cmake_dir())')"

########################################
# Prepare build directories
########################################

mkdir -p "$WHEEL_OUTPUT"

cd "$PROJECT_ROOT"
rm -rf build
mkdir build
cd build

########################################
# CMake configure (CUDA enabled)
########################################

cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_CUDA=ON \
  -DTORCHCODEC_DISABLE_COMPILE_WARNING_AS_ERROR=ON \
  -DTorch_DIR="$TORCH_DIR" \
  -Dpybind11_DIR="$pybind11_DIR"

########################################
# Build native code
########################################

cmake --build . --verbose

########################################
# Build wheel
########################################

cd "$PROJECT_ROOT"

I_CONFIRM_THIS_IS_NOT_A_LICENSE_VIOLATION=1 \
"$VENV_PYTHON" -m pip wheel . \
  --no-build-isolation \
  --verbose \
  --no-binary=torchcodec \
  --wheel-dir="$WHEEL_OUTPUT"

########################################
# Done
########################################

echo
echo "CUDA-enabled torchcodec build complete."
echo "Wheels written to: $WHEEL_OUTPUT"
ls -lh "$WHEEL_OUTPUT"
