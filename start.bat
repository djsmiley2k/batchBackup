@echo off

:: FOR %%A in (LIST_OF_IPs_COMMA_SEPERATED) DO net use \\%%A\c$ /delete & net use \\%%A\c$ /user:$username $password

echo 'All drives mapped'

echo 'Starting Copies'
start "Name of Window" /D "script_path" backup.bat 


