# This is inside your tests folder
# Remove or rename your old tests CMakeLists if needed, then replace with something like this.

# Set the C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add debug flags
if (MSVC)
    # Use Visual Studio’s debug flags automatically (or /Zi if you want).
    # Usually you don't need to specify these explicitly for Debug builds.
else()
    # For non-Windows compilers (GCC/Clang), add -g
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")
endif()

# ------------------------------------------------------------------------------
# 1. Collect test source files (now in C++: .cpp)
# ------------------------------------------------------------------------------
set(TEST_FILES
    test_main.cpp
    # Add other test files as needed
)

# ------------------------------------------------------------------------------
# 2. Create the unit test executable
# ------------------------------------------------------------------------------
add_executable(unit_tests ${TEST_FILES})

# ------------------------------------------------------------------------------
# 3. Link the core library
# ------------------------------------------------------------------------------
target_link_libraries(unit_tests PRIVATE CppSkillDemonstratorLib)

# ------------------------------------------------------------------------------
# 4. Include Google Test headers
# ------------------------------------------------------------------------------
target_include_directories(unit_tests PRIVATE
    ${CMAKE_SOURCE_DIR}/third_party/googletest/googletest/include
)

# ------------------------------------------------------------------------------
# 5. Link Google Test
# ------------------------------------------------------------------------------
if (WIN32)
    # Specific Flag (/MT) for Microsoft Visual Studio's compiler
    target_compile_options(unit_tests PRIVATE /MT)

    # Link the .lib files on Windows
    target_link_libraries(unit_tests PRIVATE
        ${CMAKE_SOURCE_DIR}/third_party/googletest/build/lib/Release/gtest.lib
        ${CMAKE_SOURCE_DIR}/third_party/googletest/build/lib/Release/gtest_main.lib
    )
else()
    # Use pthread for multithreading on Linux/macOS
    target_compile_options(unit_tests PRIVATE -pthread)
    target_link_libraries(unit_tests PRIVATE
        ${CMAKE_SOURCE_DIR}/third_party/googletest/build/lib/libgtest.a
        ${CMAKE_SOURCE_DIR}/third_party/googletest/build/lib/libgtest_main.a
    )
endif()

# ------------------------------------------------------------------------------
# 6. Additional sources for testing (if you still need to link .c/.cpp from src)
#    This may be optional if you already linked the library
# ------------------------------------------------------------------------------
target_sources(unit_tests PRIVATE
    # If needed, add references to any core .cpp (was .c) files you want to compile
    # specifically in the test project (though normally it's enough to link the library).
)
