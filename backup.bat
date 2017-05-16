@echo off

REM Map drive if not already mapped.

set ip="IP Address"

set username="username"

set password="password"

if not exist \\%ip%\c$ DO net use \\%ip%\c$ /user:%username% %password%

REM Store Variables

REM Store DATE as d
for /f "tokens=1,2,3 delims=/- " %%x in ("%date%") do set d=%%x%%y%%z

set backupPath=C:\Backups\Backup1

set destPath="C:\Backups\Backup1\%d%"

set zipPath="C:\Backups\Backup1\%d%.7z"

set srcPath="\\%ip%\c$\backup\location"

set MAXBACKUPS=2

IF not EXIST %destPath% mkdir %destPath%

echo "Starting backup copy for .... - %d%"

REM robocopy /eta /z %srcPath% %destPath% *.* /MAXAGE:1

echo "Finished backup copy for ....."

echo "Compressing files for ...."

REM Now compress stuff

"C:\Program Files\7-Zip\7z.exe" a -r %zipPath% %destPath%

echo "Finshed compressing files for ...."

if %ERRORLEVEL% GEQ 1 ECHO "WARNING - COMPRESSION FAILED" & PAUSE & EXIT

echo "Cleaning up uncompressed files"

REM Remove uncompressed filesbatch

rd /s %destPath%

echo "Removing oldest backups"

:: Preserve only the %MAXBACKUPS% most recent backups.

for /f "skip=%MAXBACKUPS% delims=" %%a in (
  'dir "%backupPath%\*.7z" /t:w /o:-d /b'
) do (
     echo More than %MAXBACKUPS% found - only the %MAXBACKUPS% most recent folders will be preserved.
     del /p "%backupPath%\%%a"
     )

)

echo "Finished, press enter to close window"

PAUSE

EXIT
