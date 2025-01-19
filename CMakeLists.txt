cmake_minimum_required(VERSION 3.13)

# Specify that this is a C++ project
project(CppSkillDemonstrator LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add debug flags (if desired)
if (MSVC)
    # Use Visual Studio’s debug flags automatically (or /Zi if you want).
    # Usually you don't need to specify these explicitly for Debug builds.
else()
    # For non-Windows compilers (GCC/Clang), add -g
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")
endif()

# ------------------------------------------------------------------------------
# 1. Define library source files
#    (Rename .c to .cpp if you're converting the implementation to C++)
# ------------------------------------------------------------------------------
set(SOURCE_FILES
    ${CMAKE_SOURCE_DIR}/src/RevenueModel/CustomerSegment/CustomerSegment.cpp
    # Add other .cpp source files as needed
)

# ------------------------------------------------------------------------------
# 2. Create a library for the core CppSkillDemonstrator functionality
# ------------------------------------------------------------------------------
add_library(CppSkillDemonstratorLib ${SOURCE_FILES})

# ------------------------------------------------------------------------------
# 3. Include directories
#    (You can keep your .h headers or rename them to .hpp/.hxx if you prefer)
# ------------------------------------------------------------------------------
target_include_directories(CppSkillDemonstratorLib
    PUBLIC
        ${CMAKE_SOURCE_DIR}/include
        ${CMAKE_SOURCE_DIR}/include/RevenueModel
        ${CMAKE_SOURCE_DIR}/include/RevenueModel/CustomerSegment
    # Add other subdirectories as needed
)

# ------------------------------------------------------------------------------
# 4. Create the main executable
#    (Rename src/main.c to src/main.cpp if converting to C++)
# ------------------------------------------------------------------------------
add_executable(CppSkillDemonstrator
    ${CMAKE_SOURCE_DIR}/src/main.cpp
)

# ------------------------------------------------------------------------------
# 5. Platform-specific compile options (optional)
# ------------------------------------------------------------------------------
if (WIN32)
    target_compile_options(CppSkillDemonstrator PRIVATE /MT)
else()
    target_compile_options(CppSkillDemonstrator PRIVATE -pthread)
endif()

# ------------------------------------------------------------------------------
# 6. Link library to the main executable
# ------------------------------------------------------------------------------
target_link_libraries(CppSkillDemonstrator PRIVATE CppSkillDemonstratorLib)

# ------------------------------------------------------------------------------
# 7. Include the tests subdirectory
# ------------------------------------------------------------------------------
add_subdirectory(tests)
