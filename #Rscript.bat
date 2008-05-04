
@echo off

setlocal
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Placing this file in your path will allow rcmd to be run anywhere
:: without changing your path environment variable.  See comments
:: below on how it finds where R is.  Your path can be listed by
:: the Windows console command:  path
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem at one tine this script had only been tested on XP
rem recent tests have only been on Vista
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
 'reg query hklm\software\R-core\R /v InstallPath 2^>NUL ^| findstr InstallPath'
  ) do set R_HOME=%%~b
if not defined R_HOME echo "Error: R not found" & goto:eof

:: add R_MIKTEX to PATH if defined.  Otherwise if its not 
:: in the PATH already then check \Program Files\miktex* or \miktex* 
:: and if found add that to PATH.

:: if miktex found in PATH skip searching for it
PATH | findstr /i miktex > nul
if not errorlevel 1 goto:end_miktex

:: check for presence of %ProgramFiles%\miktex* or \miktex*

if not defined R_MIKTEX for /f "delims=" %%a in (
    'dir /b /on "%ProgramFiles%"\miktex* 2^>NUL'
) do set R_MIKTEX=%ProgramFiles%\%%a

if not defined R_MIKTEX for /f "delims=" %%a in (
    'dir /b /on %SystemDrive%:\miktex* 2^>NUL'
) do set R_MIKTEX=%SystemDrive%:\miktex\%%a

:end_miktex
if defined R_MIKTEX PATH %R_MIKTEX%\miktex\bin;%PATH%

if not defined R_TOOLS for /f "tokens=2*" %%a in (
 'reg query hklm\software\R-core\Rtools /v InstallPath 2^>NUL ^|
findstr InstallPath'
 ) do set R_TOOLS=%%~b

if defined R_TOOLS (
    PATH %R_TOOLS%\bin;%R_TOOLS%\perl\bin;%R_TOOLS%\MinGW\bin;%PATH%
)

set here=%CD%
set args=%*

:: get name by which this command was called
:: this allows same file to be used for Rgui, Rterm, etc. by just renaming it
for %%i in (%0) do set cmd=%%~ni.exe

if /i %cmd%==rtools.exe (endlocal & set path=%path%) && goto:eof

cd %R_HOME%\bin
if /i not %cmd%==rguistart.exe goto:notRguiStart
  set cmd=rgui.exe
  set firstArgument=%1
  if defined firstArgument (
    dir %1 | findstr "<DIR>" > nul
    if errorlevel 1 goto:notRguiStart
    set here=%~1
    set firstArgument=
  )
  set args=
  shift
  :startloop
  set firstArgument=%1
  if defined firstArgument (
     set args=%args% "%~1" 
     shift
     goto:startloop
  )
:notRguiStart

set st=
if /i %cmd%==rgui.exe set st=start
if /i %cmd%==#rscript.exe set cmd=rscript.exe
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

if defined st (start "" "%cmdpath%" %args%) else "%cmdpath%" %args%
goto:eof


endlocal
