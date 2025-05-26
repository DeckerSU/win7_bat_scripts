@echo off
REM =====================================================================
REM win10-enable-long-paths.cmd
REM Enables Win32 long paths support on Windows 10/Server 2016+ by setting
REM the LongPathsEnabled registry value to 1.
REM For more information, see:
REM https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry
REM =====================================================================

REM Check for administrative privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo.
    echo ERROR: This script must be run as Administrator.
    echo Right-click the script and choose "Run as administrator".
    pause
    exit /b 1
)

echo Enabling Win32 long paths...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f >nul

if %errorlevel% EQU 0 (
    echo.
    echo SUCCESS: LongPathsEnabled has been set to 1.
    echo Please restart your computer for the change to take effect.
) else (
    echo.
    echo ERROR: Failed to set LongPathsEnabled.
)

pause
