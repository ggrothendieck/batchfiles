
@echo off

:: Without args this lists the R_HOME directory for each version of R
:: on the system.  If one of those directories is given as an argument
:: then that version is set to the current version
:: Note: Use Rfind.bat and look on R_HOME line to find current version of R.

setlocal
rem ver | findstr XP >NUL
rem if errorlevel 1 echo Warning: This script has only been tested on Windows XP.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: use environment variable R_HOME if defined
:: else current folder if bin\rcmd.exe exists 
:: else most current R as determined by registry entry
:: else error
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not defined R_HOME if exist bin\rcmd.exe set R_HOME=%CD%
if not defined R_HOME for /f "tokens=2*" %%a in (
 'reg query hklm\software\r-core\r /v InstallPath 2^>NUL ^| findstr InstallPath'
  ) do set R_HOME=%%~b
if not defined R_HOME echo "Error: R not found" & goto:eof

cd %R_HOME%
cd ..

if "%1"=="" (
	for /d %%a in (*) do if exist %%a\bin\R.exe echo %%a
) else %1\bin\RSetReg

endlocal
