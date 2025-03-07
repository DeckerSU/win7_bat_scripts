@echo off
wmic useraccount where name="%username%" set PasswordExpires=False
rem powershell -Command "Get-LocalUser -Name '"%USERNAME%"' | Set-LocalUser -PasswordNeverExpires $true"
wmic useraccount where name="%username%" get Name,Domain,FullName,PasswordExpires,PasswordChangeable,PasswordRequired,Lockout
