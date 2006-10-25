@echo off
:: Usage: sweave abc.Rnw
::     or sweave abc
:: run sweave, pdflatex and display pdf
setlocal
ver | findstr XP >NUL

if "%1"=="" goto:help
if "%1"=="-h" goto:help
if "%1"=="--help" goto:help
if "%1"=="/?" goto:help
goto:continue
:help
	echo Run sweave and pdflatex on input file.  Then view file.
	echo Syntax:
	echo    sweave filename
	echo If extension is .Rnw, .Snw or .Rtex it can 
	echo optionally be omitted.
	echo e.g. 
	echo    sweave mydoc.Rnw
	echo    sweave mydoc
	goto:eof
:continue



if errorlevel 1 echo Warning: This script has only been tested on Windows XP.
if exist "%1.Rtex" set infile="%1.Rtex"
if exist "%1.Snw" set infile="%1.Snw"
if exist "%1.Rnw" set infile="%1.Rnw"
if exist "%1" set infile="%1" 
set infileslash=%infile:\=/%
call Rcmd Sweave %infileslash%
if errorlevel 1 goto:eof

echo %cd%
set base=%~sdpn1
if not exist "%base%.tex" goto:eof
for /f "delims=" %%a in ('dir %infile% "%base%.tex" /od/b ^| more +1'
) do set ext=%%~xa
if "%ext%"==".tex" (pdflatex "%base%.tex") else goto:eof
if errorlevel 1 goto:eof

if not exist "%base%.pdf" goto:eof
for /f "delims=" %%a in ('dir "%base%.pdf" "%base%.tex" /od/b ^| more +1'
) do set ext=%%~xa
if not "%ext%"==".pdf" goto:eof
set pdffile=%base%.pdf
set tmpfile=%date%-%time%
set tmpfile=%tmpfile: =-%
set tmpfile=%tmpfile::=.%
set tmpfile=%tmpfile:/=.%
set tmpfile=%base%-%tmpfile%.bck.pdf
echo on
copy "%base%.pdf" "%tmpfile%"
start "" "%tmpfile%"
echo *** delete *.bck.pdf files when done ***

endlocal


