@echo off
REM Check for administrator privileges
REM >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM if %errorlevel% NEQ 0 (
REM     echo Please run this script as Administrator.
REM     pause
REM     exit /b
REM )

echo.
echo ============================================
echo   Installing Chocolatey
echo ============================================
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
if %ERRORLEVEL% NEQ 0 (
    echo Error installing Chocolatey.
) else (
    echo Chocolatey installed successfully.
)

echo.
echo ============================================
echo   Installing Scoop
echo ============================================
@powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "Set-ExecutionPolicy RemoteSigned -Scope Process -Force; iwr -useb get.scoop.sh | iex"
if %ERRORLEVEL% NEQ 0 (
    echo Error installing Scoop.
) else (
    echo Scoop installed successfully.
)

echo.
echo ============================================
echo   Installing winget
echo ============================================
where winget >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo winget is already installed.
) else (
    echo winget not found. Attempting to install winget...
    REM Download the winget installer bundle
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' -OutFile '%TEMP%\winget.msixbundle'"
    if %ERRORLEVEL% NEQ 0 (
        echo Error downloading the winget installer.
    ) else (
        echo Download complete. Installing winget...
        @powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-AppxPackage -Path '%TEMP%\winget.msixbundle'"
        if %ERRORLEVEL% NEQ 0 (
            echo Error installing winget.
        ) else (
            echo winget installed successfully.
        )
    )
)

echo.
echo ============================================
echo   Updating PATH for the current user
echo ============================================
REM Define paths to be added
set "CHOCOLATEY_BIN=C:\ProgramData\chocolatey\bin"
set "SCOOP_SHIMS=%HOMEDRIVE%%HOMEPATH%\scoop\shims"

REM Add Chocolatey's bin folder to PATH if not already present
echo %PATH% | find /I "%CHOCOLATEY_BIN%" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Chocolatey bin folder is already in PATH.
) else (
    setx PATH "%PATH%;%CHOCOLATEY_BIN%"
)

REM Add Scoop shims to PATH if not already present
echo %PATH% | find /I "%SCOOP_SHIMS%" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Scoop shims folder is already in PATH.
) else (
    setx PATH "%PATH%;%SCOOP_SHIMS%"
)

echo.
echo All operations completed.
pause
