@echo off
setlocal

:: CONFIGURATION: Specify the root R directory path here
set "R_HOME=C:\Program Files\R\R-4.5"
set "R_BIN=%R_HOME%\bin\x64"

:: Capture the script's file name without its extension BEFORE shifting arguments
set "SCRIPT_NAME=%~n0"

:: Get the parent directory of R_HOME (Goes up 1 level to C:\Program Files\R)
for %%I in ("%R_HOME%") do set "PARENT_DIR=%%~dpI"
if "%PARENT_DIR:~-1%"=="\" set "PARENT_DIR=%PARENT_DIR:~0,-1%"

:: Extract the first argument, shift the rest down for passing to binaries
set "ACTION=%~1"
if "%ACTION%"=="" set "ACTION=r"
shift

:: Utilities & Actions
if /i "%ACTION%"=="cd"   goto :do_cd
if /i "%ACTION%"=="dir"  goto :do_dir
if /i "%ACTION%"=="show" goto :do_show
if /i "%ACTION%"=="help" goto :do_help

:: R Core Executables
if /i "%ACTION%"=="r"      goto :do_r
if /i "%ACTION%"=="gui"    goto :do_gui
if /i "%ACTION%"=="cmd"    goto :do_cmd
if /i "%ACTION%"=="term"   goto :do_term
if /i "%ACTION%"=="script" goto :do_script
if /i "%ACTION%"=="setreg" goto :do_setreg

:: Dynamic Tcl Lookups
if /i "%ACTION%"=="tclsh"  goto :do_tclsh
if /i "%ACTION%"=="wish"   goto :do_wish

:: If argument doesn't match anything, assume error and show help
echo Error: Unknown action "%ACTION%"
echo.
goto :do_help

:do_r
"%R_BIN%\R.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :end

:do_gui
start "" "%R_BIN%\Rgui.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :end

:do_cmd
"%R_BIN%\Rcmd.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :end

:do_term
"%R_BIN%\Rterm.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :end

:do_script
"%R_BIN%\Rscript.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :end

:do_setreg
"%R_BIN%\RSetReg.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :end

:do_tclsh
for /r "%R_HOME%\Tcl" %%I in (tclsh*.exe) do set "TCLSH_PATH=%%I"
if defined TCLSH_PATH (
    "%TCLSH_PATH%" %1 %2 %3 %4 %5 %6 %7 %8 %9
) else (echo Error: tclsh*.exe not found under %R_HOME%\Tcl)
goto :end

:do_wish
for /r "%R_HOME%\Tcl" %%I in (wish*.exe) do set "WISH_PATH=%%I"
if defined WISH_PATH (
    start "" "%WISH_PATH%" %1 %2 %3 %4 %5 %6 %7 %8 %9
) else (echo Error: wish*.exe not found under %R_HOME%\Tcl)
goto :end

:do_cd
echo Changing directory to: %PARENT_DIR%
start cmd.exe /k cd /d "%PARENT_DIR%"
goto :end

:do_dir
:: dir "%PARENT_DIR%"
:: for /d %%i in ("%PARENT_DIR%\*") do echo %%~fxi
for /f "delims=" %%i in ('dir "%PARENT_DIR%" /ad /b /od') do echo %PARENT_DIR%\%%i
goto :end

:do_show
set R
goto :end

:do_help
echo Usage: %SCRIPT_NAME% [command] [args...]
echo.
echo Core R Executables (Default is 'r'):
echo   r       - Runs R.exe console
echo   gui     - Spawns Rgui.exe
echo   cmd     - Runs Rcmd.exe
echo   term    - Runs Rterm.exe
echo   script  - Runs Rscript.exe
echo   setreg  - Runs RSetReg.exe
echo.
echo Tcl/Tk Shells (Dynamic Version Discovery):
echo   tclsh   - Runs internal tclsh*.exe
echo   wish    - Spawns internal wish*.exe GUI
echo.
echo Utilities:
echo   cd      - Opens a command prompt at the parent directory (%PARENT_DIR%)
echo   dir     - Lists paths to files in parent directory in date order
echo   show    - Displays active environment variables starting with 'R'
echo   help    - Displays this help details
goto :end

:end
endlocal
