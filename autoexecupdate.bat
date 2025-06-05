@echo off
setlocal

REM === CONFIGURATION ===
set "file_name=autoexec.cfg"
set "github_raw_url=https://raw.githubusercontent.com/RayT11/cs2autoexec/main/autoexec.cfg"

REM === DETERMINE CURRENT DIRECTORY ===
set "script_dir=%~dp0"
set "file_to_update=%script_dir%%file_name%"
set "temp_file=%script_dir%temp_%file_name%"

REM === WARNING AND CONFIRMATION ===
echo.
echo WARNING: This script will download the latest version of:
echo    %file_name%
echo from:
echo    %github_raw_url%
echo and will overwrite:
echo    %file_to_update%
echo.
set /p "confirm=Are you sure you want to proceed? (Y/N): "
if /i "%confirm%" NEQ "Y" (
    echo Operation canceled.
    exit /b
)

REM === DOWNLOAD TO TEMPORARY FILE ===
echo Downloading the file from GitHub...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%github_raw_url%', '%temp_file%')"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to download the file.
    exit /b 1
)

REM === OVERWRITE THE ORIGINAL FILE ===
move /y "%temp_file%" "%file_to_update%"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to overwrite the file.
    exit /b 1
)

echo Update complete. The file has been overwritten.
endlocal
