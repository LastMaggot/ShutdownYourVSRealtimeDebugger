@echo off

REM Set backup directory
set "backup_dir=%~dp0backup"

REM Check if backup directory exists
if not exist "%backup_dir%" (
    echo Backup directory not found. Cannot proceed with restore.
    pause
    exit /b
)

echo Restoring registry keys for Visual Studio JIT debugger...

REM Restore Debugger registry keys for 32-bit and 64-bit systems
reg import "%backup_dir%\AeDebug_Backup.reg"
reg import "%backup_dir%\DbgManagedDebugger_Backup.reg"

REM Restore Wow6432Node registry keys for 64-bit systems
reg import "%backup_dir%\Wow6432Node_AeDebug_Backup.reg"
reg import "%backup_dir%\Wow6432Node_DbgManagedDebugger_Backup.reg"

echo Registry keys restored successfully.

pause
