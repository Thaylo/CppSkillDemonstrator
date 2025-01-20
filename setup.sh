#!/bin/bash

########################################
# 1) Check if a command is available
########################################
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

########################################
# 2) Install CMake if missing
########################################
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if command_exists cmake; then
    echo "CMake is already installed (Linux). Skipping apt update."
  else
    sudo apt update
    sudo apt -y install cmake
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  if command_exists brew; then
    if brew list cmake &>/dev/null; then
      echo "CMake is already installed (macOS). Skipping."
    else
      brew install cmake
    fi
  else
    echo "Error: Homebrew is required but not installed. Please install Homebrew."
    exit 1
  fi

elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin" ]]; then
  # Windows (Git Bash)
  if command_exists cmake; then
    echo "CMake has been detected (Windows)."
  else
    winget install cmake
  fi

else
  echo "Error: Unsupported operating system."
  exit 1
fi

########################################
# 3) Clone Google Test if needed
########################################
if [[ ! -d "third_party/googletest" ]]; then
  mkdir -p third_party
  cd third_party
  echo "Cloning Google Test..."
  git clone https://github.com/google/googletest.git
  cd ..
else
  echo "Google Test already exists. Skipping clone."
fi

########################################
# 4) Build Steps
########################################
if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin" ]]; then
  #
  # --- WINDOWS BUILD ---
  #
  echo "Building Google Test (Windows)..."
  cd third_party/googletest
  mkdir -p build
  cd build
  cmake -DCMAKE_CXX_STANDARD=14 ..
  "/c/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Current/Bin/MSBuild.exe" \
    "googletest-distribution.sln" -property:Configuration=Release
  cd ../../../

  echo "Building CppSkillDemonstrator (Windows)..."
  mkdir -p build
  cd build
  cmake -DCMAKE_CXX_STANDARD=14 ..
  "/c/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Current/Bin/MSBuild.exe" \
    "CppSkillDemonstrator.sln" -property:Configuration=Release

  # Run tests (if present)
  if [ -f "./tests/Release/unit_tests.exe" ]; then
    echo "Running unit tests..."
    ./tests/Release/unit_tests.exe
  else
    echo "No unit_tests.exe found in ./tests/Release. Skipping test run."
  fi

else
  #
  # --- LINUX/MACOS BUILD ---
  #
  echo "Building Google Test (Unix)..."
  cd third_party/googletest
  mkdir -p build
  cd build
  cmake -DCMAKE_CXX_STANDARD=14 ..
  make
  cd ../../../

  echo "Building CppSkillDemonstrator (Unix)..."
  mkdir -p build
  cd build
  cmake -DCMAKE_CXX_STANDARD=14 ..
  make

  # Run tests (if present)
  if [ -f "./tests/unit_tests" ]; then
    echo "Running unit tests..."
    ./tests/unit_tests
  else
    echo "No unit_tests binary found in ./tests/. Skipping test run."
  fi

  echo "Starting project demonstrator (Unix)..."
  if [ -f "./CppSkillDemonstrator" ]; then
    ./CppSkillDemonstrator
  else
    echo "No CppSkillDemonstrator binary found in ./build/. Skipping."
  fi
fi

echo "Setup script completed."
