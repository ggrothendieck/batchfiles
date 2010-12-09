
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
if not defined R_HOME for /f "tokens=2*" %%a in (
 'reg query hklm\software\wow6432Node\r-core\r /v InstallPath 2^>NUL ^| findstr InstallPath'
  ) do set R_HOME=%%~b
if not defined R_HOME echo "Error: R not found" & goto:eof

:: look for architecture in these places in this order:
:: - environment variable R_ARCH
:: - first arg if its --arch
:: - check if R_HOME\bin\i386 exists
:: - if R_HOME\bin\x64 exists
:: - if none of the above then use i386

if not defined R_ARCH if /i "%1"=="--arch=x64" set R_ARCH=x64
if not defined R_ARCH if /i "%1"=="--arch=64" set R_ARCH=x64
if not defined R_ARCH if /i "%1"=="--arch=i386" set R_ARCH=i386
if not defined R_ARCH if /i "%1"=="--arch=32" set R_ARCH=i386
if defined R_ARCH goto:archdefined
if exist %R_HOME%\bin\i386 (set R_ARCH=i386) & goto:arch_defined
if exist %R_HOME%\bin\x64 (set R_ARCH=x64) & goto:arch_defined
set R_ARCH=i386
:arch_defined


cd %R_HOME%
cd ..

if "%1"=="" (
	for /d %%a in (*) do if exist %%a\bin\R.exe echo %%a
	goto:eof
)

:: Look in architecture specific subdirectory of bin. If not there look in bin.
set cmdpath=%1\bin\%R_ARCH%\RSetReg.exe
set cmdpath
if exist "%cmdpath%" goto:cmdpathfound
set cmdpath=%1\bin\RSetReg.exe
set cmdpath
if exist "%cmdpath%" goto:cmdpathfound
echo "Error: RSetReg.exe not found" & goto:eof
goto:eof
:cmdpathfound
"%cmdpath%"

endlocal
