@echo off
REM =============================================================================
REM win10_disable_websearch_cortana.cmd
REM Script to disable Cortana and web search via registry tweaks
REM =============================================================================

REM Check for administrative privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo.
    echo ERROR: This script must be run as Administrator.
    echo Right-click the script and choose "Run as administrator".
    pause
    exit /b 1
)

REM =====================================================================
REM Disable Cortana and built-in Windows Search features (HKLM)
REM =====================================================================
echo Disabling Cortana and built-in web search...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWebOverMeteredConnections /t REG_DWORD /d 0 /f

REM =====================================================================
REM Disable search box suggestions and news feed (HKCU)
REM =====================================================================
echo Disabling search box suggestions and news feed...
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f

echo.
echo Registry changes applied successfully.
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
