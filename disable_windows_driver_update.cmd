@echo off
rem Source: https://github.com/perampokgoogle/Tweak-Windows/blob/bcaf2ece1015c8649009579bbbf5d87161826c20/Win%2010/Windows%20Update/Disable%20(1709%20Fall%20Creators%20Update)%20automatically%20Windows%20Updates/Disable%20Windows%20driver%20Update.cmd

rem Prevent device meta-data retrieval from the Internet / Do not automatically download manufacturer's apps and custom icons available for your devices
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
sc config DsmSvc start= disabled

rem Do you want Windows to download driver Software / 0 - Never / 1 - Always / 2 - Install driver Software, if it is not found on my computer
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f

rem Specify search order for device driver source locations
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DriverSearching" /v "DriverUpdateWizardWuSearchEnabled" /t REG_DWORD /d "0" /f

rem 1 - Disable driver updates in Windows Update
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f
