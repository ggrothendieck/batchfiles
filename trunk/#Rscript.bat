@echo off
setlocal
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Placing this file in your path will allow rcmd to be run anywhere
:: without changing your path environment variable.  See comments
:: below on how it finds where R is.  Your path can be listed by
:: the Windows console command:  path
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ver | findstr XP >NUL
if errorlevel 1 echo Warning: This script has only been tested on Windows XP.

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

set here=%CD%

:: get name by which this command was called
:: this allows same file to be used for Rgui, Rterm, etc. by just renaming it
for %%i in (%0) do set cmd=%%~ni.exe

cd %R_HOME%\bin
if /i %cmd%==rgui.exe set st=start
if /i %0==#rscript.bat set cmd=rscript.exe
if /i %0==#rscript set cmd=rscript.exe
cd %here%
set cmdpath=%R_HOME%\bin\%cmd%

:: if called as jgr.bat locate the JGR package to find jgr.exe
if /i %cmd%==jgr.exe (
  set st=start
  set cmdpath=jgr.exe
  for /f "delims=" %%i in (JGR) do set jgrpkg=%%~$R_LIBS:i
  if defined jgrpkg set cmdpath=%jgrpkg%\jgr.exe
  if exist "%R_HOME%\library\JGR\jgr.exe" set cmdpath=%R_HOME%\library\JGR\jgr.exe
) 

if defined st (start "" "%cmdpath%" %*) else "%cmdpath%" %*
goto:eof


endlocal



