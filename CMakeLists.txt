cmake_minimum_required(VERSION 3.16)
project(SnakeGame VERSION 1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# --- SFML location ---
# When installed via MSYS2 (pacman), SFML lives under the MinGW prefix.
# CMake will find it automatically if you build from the MSYS2 MinGW 64-bit terminal.
# If you installed SFML somewhere else, set SFML_DIR to the folder containing
# SFMLConfig.cmake, e.g.:
#   cmake .. -DSFML_DIR="C:/SFML/lib/cmake/SFML"
find_package(SFML 2.6 COMPONENTS graphics window system REQUIRED)

# Collect all .cpp files in src/
file(GLOB_RECURSE SOURCES "src/*.cpp")

# Create the executable
add_executable(snake ${SOURCES})

# On Windows, use WIN32 to suppress the console window once the game is working.
# For now, leave it as-is so you can see compiler output.
# Later you can change add_executable above to:
#   add_executable(snake WIN32 ${SOURCES})

# Link SFML
target_link_libraries(snake sfml-graphics sfml-window sfml-system)

# Include our own headers
target_include_directories(snake PRIVATE include)

# Copy assets folder next to the .exe so the game can find fonts/sounds
add_custom_command(TARGET snake POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_SOURCE_DIR}/assets"
        "$<TARGET_FILE_DIR:snake>/assets"
    COMMENT "Copying assets to build directory"
)

# Copy SFML DLLs next to the .exe (required on Windows)
# This copies every DLL that SFML's CMake targets need.
add_custom_command(TARGET snake POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_RUNTIME_DLLS:snake>
        $<TARGET_FILE_DIR:snake>
    COMMAND_EXPAND_LISTS
    COMMENT "Copying SFML DLLs to build directory"
)
