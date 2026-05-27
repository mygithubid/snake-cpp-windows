@echo off
REM ============================================================
REM  build.bat — Snake Game build helper for Windows
REM
REM  Run this from the MSYS2 MinGW 64-bit terminal, NOT from
REM  Command Prompt or PowerShell, or it will fail to find the
REM  compiler.
REM
REM  Usage:  just double-click this file in File Explorer,
REM          or type   bash build.bat   in the MSYS2 terminal.
REM ============================================================

echo [build.bat] Creating build directory...
if not exist build mkdir build

echo [build.bat] Running CMake configure...
cmake -S . -B build -G "MinGW Makefiles"
if errorlevel 1 (
    echo.
    echo ERROR: CMake configure failed. See messages above.
    pause
    exit /b 1
)

echo [build.bat] Building...
cmake --build build
if errorlevel 1 (
    echo.
    echo ERROR: Build failed. See messages above.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  Build succeeded!  Run the game:
echo    build\snake.exe
echo ============================================================
pause
