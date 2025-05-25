@echo off
REM =====================================================================
REM win11_disable_recall.cmd
REM Script to disable and remove the Recall feature, and enforce the GPO policy
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

echo Disabling the Recall feature...
dism.exe /Online /Disable-Feature /FeatureName:Recall /Remove /NoRestart
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to disable Recall via DISM. Code=%ERRORLEVEL%
) else (
    echo Recall has been successfully disabled and removed.
)

echo.
echo Applying AllowRecallEnablement = 0 registry policy...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v AllowRecallEnablement /t REG_DWORD /d 0 /f
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to write registry value. Code=%ERRORLEVEL%
) else (
    echo Registry policy has been successfully applied.
)

echo.
echo A system restart is required to complete the changes.
choice /M "Restart now?"
if %ERRORLEVEL% EQU 1 (
    echo Restarting...
    shutdown /r /t 5
) else (
    echo Restart cancelled. Please remember to restart manually.
)

exit /b 0
