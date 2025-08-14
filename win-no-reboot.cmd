@echo off
setlocal EnableExtensions
:: https://learn.microsoft.com/en-us/windows/deployment/update/waas-restart

:: --- Requires administrator rights to write HKLM
net session >nul 2>&1 || (
  echo [!] Please run this script as Administrator.
  exit /b 1
)

:: --- Kill the Windows Update reboot toast (quiet if the process isn't running)
taskkill /f /im MusNotificationUx.exe >nul 2>&1

set "KeyUX=HKLM\SOFTWARE\Microsoft\Windows\WindowsUpdate\UX\Settings"
set "KeyPolWU=HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
set "KeyPolAU=HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"

:: --- Fixed Active Hours range (hours)
set /a RANGE=11

:: --- Current hour (00–23), resilient to a leading space in %TIME%
for /f "tokens=1 delims=:." %%H in ("%time%") do set /a HH=1%%H-100

:: --- Start = current hour - 1 (wrap 0..23), End = Start + RANGE (mod 24)
set /a StartHour=(HH+23) %% 24
set /a EndHour=(StartHour + RANGE) %% 24

:: --- Optional UX keys (UI reflects values; not policy-enforced)
reg add "%KeyUX%"    /v ActiveHoursStart      /t REG_DWORD /d %StartHour% /f >nul
reg add "%KeyUX%"    /v ActiveHoursEnd        /t REG_DWORD /d %EndHour%   /f >nul
reg add "%KeyUX%"    /v IsActiveHoursEnabled  /t REG_DWORD /d 1           /f >nul

:: --- POLICY: Turn off auto-restart during active hours
reg add "%KeyPolWU%" /v SetActiveHours   /t REG_DWORD /d 1           /f >nul
reg add "%KeyPolWU%" /v ActiveHoursStart /t REG_DWORD /d %StartHour% /f >nul
reg add "%KeyPolWU%" /v ActiveHoursEnd   /t REG_DWORD /d %EndHour%   /f >nul

:: --- POLICY: No auto-restart if a user is logged on (requires AUOptions=4)
reg add "%KeyPolAU%" /v AUOptions                     /t REG_DWORD /d 4 /f >nul
reg add "%KeyPolAU%" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul

echo [OK] Active Hours policy set: start=%StartHour%, end=%EndHour% (range=%RANGE%h)
echo [OK] Auto-restart blocked when a user is signed in (AUOptions=4).

exit /b 0
