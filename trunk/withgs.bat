:: @echo off
setlocal
if "%1"=="" goto:help
if "%1"=="-h" goto:help
if "%1"=="--help" goto:help
if "%1"=="/?" goto:help
goto:continue
:help
	echo Execute arguments as a command such that ghostscript is
	echo placed in the path even if its not normally there.
	echo Syntax:
	echo    withgs ...some command...
	echo e.g. withgs fig2dev -L tiff myfile.fig > myfile.tiff
	goto:eof
:continue
for /f "delims=" %%s in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\AFPL Ghostscript"') do set KEY=%%s 
call :trim key
call :getreg result "%KEY%" /v GS_DLL
if "%result%"=="" (
	echo Error: ghostscript not found.  Install ghostscript and rerun.
	goto:eof
)
for /f "delims=" %%a in ("%result%") do (set bin=%%~dpa)
:: next line not used but maybe in the future it will be needed
for /f "delims=" %%a in ("%result%") do (set lib=%%~a)
append %bin%
%*

goto:eof


rem ------------------------------------------------------------------------
rem SUBROUTINES 
rem - :getreg - get path from registry
rem - :trim - trim leading and trailing space
rem ------------------------------------------------------------------------

rem ------------------------------------------------------------------------
rem :getreg
rem ------------------------------------------------------------------------
rem Usage:  call :getreg varname regargs
rem varname is the name of a variable that is to be set to the desired path.
rem regargs are the arguments to the REQ QUERY command that fetches the appropriate
rem entry from the registry.  Be sure to double quote the Key name if it has
rem spaces.
rem
rem This routine
rem - finds the entry using the reg command
rem - extracts out the path removing spaces, quotes, trailing backslashes and 
rem   filenames as necessary.  (It assumes that if the registry entry has
rem   quotes in the first argument that the first argument holds the path.
rem   Otherwise, it assumes that the entire key value should be returned.)
rem - returns it in varname.  If it cannot be found the variable is undefined.
rem
rem e.g.
rem call :getreg PerlVer HKEY_LOCAL_MACHINE\SOFTWARE\ActiveState\ActivePerl /v CurrentVersion
rem Issue the command   reg /?   for more info on arguments.

:getreg
   setlocal
   rem set variable var to first arg and variable args to rest
   set var=%1

   set args=%*
   call set args=%%args:*%1=%%

   rem query registry and put result in variable reg
   for /f "delims=" %%a in ('reg query %args% 2^>NUL ^| findstr REG_SZ')do (
	set reg=%%a
   )

   rem remove up to and including REG_SZ
   set reg=%reg:*REG_SZ=%

   rem Trim whitespace from both ends of variable reg.
   call :trim reg

   endlocal & set %var%=%reg%
   goto:eof


rem ------------------------------------------------------------------------
rem :trim
rem ------------------------------------------------------------------------
rem Trim space from beginning and end of named variable
rem Usage:    call :trim argument
rem On return the variable has been trimmed.
rem e.g.     set "val=  string   "
rem          echo [%val%]
rem          call :trim val
rem          echo [%val%]

:trim
   setlocal
   call :trim_ %%%1%%
   endlocal & set %1=%value%
   :gotoend

   :trim_
      setlocal
      set value=%*
      endlocal & set value=%value%
      goto:eof

endlocal


