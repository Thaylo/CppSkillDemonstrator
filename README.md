# C++ Skill Demonstrator

A portable **C++** library to showcase and speed up cross-platform development on Windows, GNU/Linux, and macOS. This repository demonstrates core C++ skills, including organizing a project with CMake, writing tests with Google Test, and managing a clean directory structure.

## Setup

### General Setup Procedures

1. **Install Git:**

   Follow the instructions from the [official Git documentation](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to install Git on your system.

### Specific Setup Procedures by Operating System

#### Linux

1. **Ensure APT is Available (e.g., on Ubuntu):**

   ```bash
   sudo apt update
   sudo apt -y install cmake
   ```

2. **Run the setup script:**

    ```
    chmod +x setup.sh
    ./setup.sh
    ```

#### Windows

1. **Install CMake:**

    Download and install CMake from the official CMake website.

2. **Install Microsoft Visual Studio 2022 (or MSBuild Tools):**
    - Download and install Visual Studio 2022.
    - During the setup, ensure you include the "Desktop development with C++" workload.
    
    Note: If you use a different version of MS Visual Studio, update the paths in setup.sh to match your MSBuild location.

3. **Run the Setup Script in Git Bash or a Similar Shell:**

    ```
    ./setup.sh
    ```


#### MacOS

1. **Install Homebrew (Required by the Script):**

    Install Homebrew by following the instructions at [brew.sh](brew.sh)

2. **Run the Setup Script:**
    ```
    ./setup.sh
    ```

###  Validating Installation

If you see output from Google Test (e.g., [==========] Running X tests...) during the setup, then the dependencies are installed and the build is successful.

###  Building the Project

The project utilizes CMake with C++14 as the default standard. Make sure your compiler supports C++14.

1. **Linux/macOS:**

    ```
    bash
    Copy
    mkdir build && cd build
    cmake -DCMAKE_CXX_STANDARD=14 ..
    make
    ```

2. **Windows (PowerShell or Git Bash):**

    ```
    mkdir build
    cd build
    cmake -DCMAKE_CXX_STANDARD=14 ..
    msbuild CppSkillDemonstrator.sln /p:Configuration=Release
    ```

###  Running the Application

After a successful build, run the following commands:

1. **Linux/macOS:**

    ```
    ./build/CppSkillDemonstrator
    ```

2. **Windows (PowerShell or Git Bash):**

    ```
    ./build/Release/CppSkillDemonstrator.exe
    ```