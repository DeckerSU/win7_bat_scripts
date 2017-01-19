@echo off
echo Disable GWX by Decker [www.decker.su] v0.1b
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\GWX /v DisableGWX /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v DisableOSUpgrade /t REG_DWORD /d 1 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade /v ReservationsAllowed /d 0 /f
pause
