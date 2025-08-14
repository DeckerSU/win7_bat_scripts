@echo off
setlocal EnableExtensions

:: --- Requires administrator rights to write HKLM
net session >nul 2>&1 || (
  echo [!] Please run this script as Administrator.
  exit /b 1
)

:: --- Kill the Windows Update reboot toast (quiet if the process isn't running)
taskkill /f /im MusNotificationUx.exe >nul 2>&1

set "Key=HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"

:: --- Fixed Active Hours range (hours)
set /a RANGE=18

:: --- Current hour (00–23), resilient to a leading space in %TIME%
for /f "tokens=1 delims=:." %%H in ("%time%") do set /a HH=1%%H-100

:: --- Start = current hour - 1 (wrap 0..23), End = Start + RANGE (mod 24)
set /a StartHour=(HH+23) %% 24
set /a EndHour=(StartHour + RANGE) %% 24

:: --- Apply Active Hours directly to the registry
reg add "%Key%" /v ActiveHoursStart /t REG_DWORD /d %StartHour% /f >nul
reg add "%Key%" /v ActiveHoursEnd   /t REG_DWORD /d %EndHour%   /f >nul
reg add "%Key%" /v IsActiveHoursEnabled /t REG_DWORD /d 1 /f >nul

echo [OK] Active Hours set: start=%StartHour%, end=%EndHour%, range=%RANGE%h (fixed)
exit /b 0
