@echo off
setlocal
rem rem ver | findstr XP >NUL

for %%i in (%0) do set cmd=%%~ni
if /i "%cmd%"=="Stangle" set cmd=Stangle
if /i "%cmd%"=="Sweave" set cmd=Sweave

set scriptdir_=%~dp0
set lookin=.;%userprofile%;%scriptdir_%

if not defined R_BATCHFILES_RC (
	for %%f in ("rbatchfilesrc.bat") do set "R_BATCHFILES_RC=%%~$lookin:f"
)
if defined R_BATCHFILES_RC (
	set R_BATCHFILES_RC
	if exist "%R_BATCHFILES_RC%" call %R_BATCHFILES_RC%
)

if "%1"=="" goto:help
if "%1"=="-h" goto:help
if "%1"=="--help" goto:help
if "%1"=="/?" goto:help
if "%1"==":Rterm" (

	if not defined R_HOME if exist bin\rcmd.exe set R_HOME=%CD%
	if not defined R_HOME for /f "tokens=2*" %%a in (
	 'reg query hklm\software\r-core\r /v InstallPath 2^>NUL ^| findstr InstallPath'
	  ) do set R_HOME=%%~b
	if not defined R_HOME echo "Error: R not found" & goto:eof

	set here=%CD%
	set args=%2 %3 %4 %5 %6 %7 %8 %9

	set cmd=:Rterm

	goto:Rterm
)
goto:continue
:help
echo Usage: %0 abc.Rnw
echo    or  %0 abc
if /i "%cmd%"=="stangle" goto:eof
echo switches:
echo    -t or --tex or     produce tex file and exit
echo    -p or --pdf or     produce pdf file and exit
echo    -n or --nobck.pdf  do not create .bck.pdf; instead display pdf directly
echo Runs sweave producing a .tex file.  Then it runs pdflatex producing
echo  a .pdf file and a .bck.pdf file.  Finally the .bck.pdf file is 
echo  displayed on screen.
echo.
echo Examples:
echo.
echo 1. Run sweave, pdflatex, create backup pdf with unique name, display it
echo       sweave mydoc.Rnw
echo 2. Same
echo       sweave mydoc
echo 3. Run sweave to create tex file.  Do not run pdflatex or display.
echo       sweave mydoc --tex
echo 4. Run sweave and pdflatex creating pdf file.  Do not create .bck.pdf
echo    file and do not display file.
echo       sweave mydoc --pdf
echo 5. Run sweave and pdflatex. Do not create .bck.pdf. Display .pdf file.
echo       sweave mydoc --nobck
goto:eof
:continue

:: argument processing
:: - returns 'file' as file argument and 'switch' as switch argument

    :loop 
    (set arg=%~1) 
    shift 
    if not defined arg goto :cont 
    (set prefix1=%arg:~0,1%) 
    if "%prefix1%"=="-" goto:switch
    set file=%arg%
    goto:loop
    :switch
    :: remove dashes from switch and get first char
    set switch=%arg:-=%
    set switch=%switch:~0,1%
    goto:loop
    :cont

if errorlevel 1 echo Warning: This script has only been tested on Windows XP.
if exist "%file%.Rtex" set infile="%file%.Rtex"
if exist "%file%.Snw" set infile="%file%.Snw"
if exist "%file%.Rnw" set infile="%file%.Rnw"
if exist "%file%" set infile="%file%" 
set infilslsh=%infile:\=/%
:: call sweave
echo library('utils'); %cmd%(%infilslsh%) | %cmd%.bat :Rterm --no-restore --slave
if /i "%cmd%"=="stangle" goto:eof
:: echo on
if errorlevel 1 goto:eof
if /i "%switch%"=="t" goto:eof

:: echo %cd%
for %%a in ("%file%") do set base=%%~sdpna
if not exist "%base%.tex" goto:eof
for /f "delims=" %%a in ('dir %infile% "%base%.tex" /od/b ^| more +1'
) do set ext=%%~xa

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

if "%ext%"==".tex" (pdflatex "%base%.tex") else goto:eof
if errorlevel 1 goto:eof
if /i "%switch%"=="p" goto:eof

if not exist "%base%.pdf" goto:eof
for /f "delims=" %%a in ('dir "%base%.pdf" "%base%.tex" /od/b ^| more +1'
) do set ext=%%~xa
if not "%ext%"==".pdf" goto:eof
set pdffile=%base%.pdf
if /i "%switch%"=="n" start "" "%pdffile%" && goto:eof
set tmpfile=%date%-%time%
set tmpfile=%tmpfile: =-%
set tmpfile=%tmpfile::=.%
set tmpfile=%tmpfile:/=.%
set tmpfile=%base%-%tmpfile%.bck.pdf
copy "%pdffile%" "%tmpfile%"
start "" "%tmpfile%"
echo *** delete *.bck.pdf files when done ***
goto:eof



@echo off
setlocal
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Placing this file in your path will allow rcmd to be run anywhere
:: without changing your path environment variable.  See comments
:: below on how it finds where R is.  Your path can be listed by
:: the Windows console command:  path
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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
for %%i in (%0) do set cmd=%%~ni 

goto %cmd%
goto:eof

:: note that RguiStart sets cmd to rgui.exe and then 
:: jumps to :Rgui.exe where processing is finished
:RguiStart
:RguiStart.exe
cd %R_HOME%\bin
if /i not %cmd%==rguistart.exe goto:Rgui
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

:Rcmd2
:Rcmd2.exe
:Rcmd
:Rcmd.exe
(set cmd=rcmd.exe)&goto:main

:Rterm
:Rterm.exe
(set cmd=rterm.exe)&goto:main

:Rgui
:Rgui.exe
(set cmd=rgui.exe)&goto:main

:R
:R.exe
(set cmd=r)&goto:main

:Rjgr
:Rjgr.exe
(set cmd=rjgr)&goto:main

:#Rscript
:#Rscript.exe
:Rscript
:Rscript.exe
(set cmd=rscript.exe)&goto:main

# main portion of program
:main
set st=
if /i %cmd%==rgui.exe set st=start
:: if /i %cmd%==#rscript.exe set cmd=rscript.exe
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


endlocal



