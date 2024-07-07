@echo off

REM Set backup directory
set "backup_dir=%~dp0backup"

REM Create backup directory if it doesn't exist
if not exist "%backup_dir%" mkdir "%backup_dir%"

REM Backup registry keys before deleting

REM Backup Debugger registry keys for 32-bit and 64-bit systems
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" "%backup_dir%\AeDebug_Backup.reg" /y
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" "%backup_dir%\DbgManagedDebugger_Backup.reg" /y

REM Backup Wow6432Node registry keys for 64-bit systems
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\AeDebug" "%backup_dir%\Wow6432Node_AeDebug_Backup.reg" /y
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework" "%backup_dir%\Wow6432Node_DbgManagedDebugger_Backup.reg" /y

echo Backup of registry keys completed successfully.

echo Deleting registry keys to disable Visual Studio JIT debugger...

REM Delete Debugger registry keys for 32-bit and 64-bit systems
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug" /v Debugger /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" /v DbgManagedDebugger /f

REM Delete Wow6432Node registry keys for 64-bit systems
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\AeDebug" /v Debugger /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework" /v DbgManagedDebugger /f

echo Registry keys deleted successfully.

pause
