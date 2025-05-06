@echo off
wmic useraccount where name="%username%" set PasswordExpires=False
reg ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" /v DevicePasswordLessBuildVersion /t REG_DWORD /d 0 /f
rem netplwiz
control userpasswords2

