@echo off

rem Display the key directories required by R to build packages.  
rem
rem - PerlDir is set to ActivePerl bin directory using the registry
rem - TexDir is set to MikTex or fptex bin directory searching common locations
rem - HTMLHelpDir is set to Microsoft HTML Help main directory using registry
rem - R_HOME is set to the rw.... directory of R checking 1. current directory
rem   2. registry and 3. list of common locations
rem - Rbin is set to the bin directory in R_HOME
rem - R_ROOT is set to the parent of R_HOME
rem - RtoolsDir is set to the UNIX-like tools directory searching
rem   through common directories as defined in RtoolsPath
rem - RPATH is a possible PATH variable that is generated that can be used 
rem   when building packages
rem
rem The user can override any of the variables by setting them as environment
rem variables.
rem
rem NOTES:
rem
rem - No environment variables are actually set by this batch file.  It is
rem   display only so nothing is changed and its always safe to run this.
rem - Only tested on XP.
rem 

setlocal

rem ver | findstr XP >NUL
rem if errorlevel 1 echo Warning: This script has only been tested on Windows XP.

rem ------------------------------------------------------------------------
rem Perl
rem ------------------------------------------------------------------------
rem set Perl main directory 
rem If not set, it will be looked up in the registry.
rem http://www.activestate.com/Products/ActivePerl/Download.htm
rem

set PerlDir=
rem note that the key name depends on the perl version so we need to look up the
rem perl version first to form the key name
if not defined PerlDir (
   call :getreg PerlVer HKEY_LOCAL_MACHINE\SOFTWARE\ActiveState\ActivePerl /v CurrentVersion
)
if defined PerlVer (
   call :getreg PerlDir HKEY_LOCAL_MACHINE\SOFTWARE\ActiveState\ActivePerl\%PerlVer% /ve
) 
rem check if perl.exe is in PerlDir and if not check bin subdirectory
set PerlPath=%PerlDir%;%PerlDir%\bin
if defined PerlDir for %%a in ("perl.exe") do set PerlDir=%%~p$PerlPath:a
if not defined PerlDir echo Perl not found & goto:eof

rem ------------------------------------------------------------------------
rem TeX 
rem ------------------------------------------------------------------------
rem Look up MiKTeX directory
rem

set TeXDir=
if not defined TeXDir (
   call :getreg TeXDir "HKEY_LOCAL_MACHINE\SOFTWARE\MiK\MiKTeX\CurrentVersion\MiKTeX" /v "Install Root"
) 
set TeXDir=%TeXDir%\miktex\bin
if not defined TeXDir echo MiKTeX not found & goto:eof

rem ------------------------------------------------------------------------
rem Microsoft HTML Help
rem ------------------------------------------------------------------------
rem set the main Microsoft HTML Help directory
rem If not set, it will be looked up in the registry.
rem http://msdn.microsoft.com/library/tools/htmlhelp/chm/HH1Start.htm
rem

set HTMLHelpDir=
if not defined HTMLHelpDir (
   call :getreg HTMLHelpDir "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\hhw.exe" /v Path
)
if not defined HTMLHelpDir echo Microsoft HTML Help directory not found & goto:eof

rem ------------------------------------------------------------------------
rem R_HOME rw.... Folder, Rbin and R_ROOT
rem ------------------------------------------------------------------------
rem set the R_HOME directory
rem If not set, it will check 
rem - current directory
rem - registry
rem - list of common locations as defined in RSearchPath
rem

set R_HOME=
if not defined R_HOME if exist bin\R.exe set R_HOME=%CD%
if not defined R_HOME (
	call :getreg R_HOME hklm\software\r-core\r /v InstallPath
)
if not defined R_HOME (
	for /d %%a in ("\R\rw*" "\Program Files\R\rw*" .) do (
		if exist %%a\bin\R.exe set R_HOME=%%a\bin
	)
)
if not defined R_HOME echo R directory not found & goto:eof

setlocal
cd %R_HOME%
cd bin
endlocal & set Rbin=%CD%

setlocal
cd %R_HOME%
cd ..
endlocal & set R_ROOT=%CD%

rem ------------------------------------------------------------------------
rem Rtools
rem ------------------------------------------------------------------------
rem set the Rools directory
rem If not set search the RtoolsPath
rem http://www.murdoch-sutherland.com/Rtools
rem

set RtoolsDir=

if not defined RtoolsDir (
  set RtoolsPath=.;\bin;\Rtools;%R_ROOT%\Rtools;%R_ROOT\bin%;%R_HOME%\bin;%PATH%
  for /d %%a in ("md5sum.exe") do set RtoolsDir=%%~p$RtoolsPath:a
)
if not defined RtoolsDir echo Rtools directory not found & goto:eof


rem ----------------------------------------------
rem Display directories

set PerlDir
set TexDir
set HTMLHelpDir
set R_HOME
set Rbin
set R_ROOT
set RtoolsDir

rem Set path to rpath
set RPATH=%Rbin%;%RtoolsDir%;%PerlDir%;%HTMLHelpDir%;%LatexDir%;%PATH%
set RPATH
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

