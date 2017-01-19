@echo off
rem Для текущего пользователя

reg add "HKEY_CURRENT_USER\Keyboard Layout\Preload" /v 1 /t REG_SZ /d 00000409 /f
reg add "HKEY_CURRENT_USER\Keyboard Layout\Preload" /v 2 /t REG_SZ /d 00000419 /f
reg add "HKEY_CURRENT_USER\Keyboard Layout\Toggle" /v Hotkey /t REG_SZ /d 2 /f
reg add "HKEY_CURRENT_USER\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d 2 /f
reg add "HKEY_CURRENT_USER\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d 3 /f
rem "%windir%\system32\rundll32.exe" shell32.dll,Control_RunDLL input.dll


rem Для всех пользователей (пользователь по-умолчанию)

reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Preload" /v 1 /t REG_SZ /d 00000409 /f
reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Preload" /v 2 /t REG_SZ /d 00000419 /f
reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Toggle" /v Hotkey /t REG_SZ /d 2 /f
reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d 2 /f
reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d 3 /f


rem nircmdc elevate reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Preload" /v 1 /t REG_SZ /d 00000409 /f
rem nircmdc elevate reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Preload" /v 2 /t REG_SZ /d 00000419 /f
rem nircmdc elevate reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Toggle" /v Hotkey /t REG_SZ /d 2 /f
rem nircmdc elevate reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d 2 /f
rem nircmdc elevate reg add "HKEY_USERS\.DEFAULT\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d 3 /f
rem nircmdc elevate "%windir%\system32\rundll32.exe" shell32.dll,Control_RunDLL input.dll
