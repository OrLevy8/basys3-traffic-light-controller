@echo off
REM ==============================================================================
REM Script to run ModelSim simulation for Basys 3 Traffic Light Controller
REM ==============================================================================

echo [INFO] Starting ModelSim Simulation...
cd /d "%~dp0..\tb"

if exist "do.do" (
    vsim -do do.do
) else (
    echo [ERROR] Simulation script do.do not found!
)

pause
