@echo off
:: Usage: sweave abc.Rnw
::     or sweave abc
:: run sweave, pdflatex and display pdf
setlocal
ver | findstr XP >NUL
if errorlevel 1 echo Warning: This script has only been tested on Windows XP.
if exist "%1.Rtex" set infile="%1.Rtex"
if exist "%1.Snw" set infile="%1.Snw"
if exist "%1.Rnw" set infile="%1.Rnw"
if exist "%1" set infile="%1" 
set infileslash=%infile:\=/%
call Rcmd Sweave %infileslash%
if errorlevel 1 goto:eof

set base=%~sdpn1
if not exist "%base%.tex" goto:eof
for /f "delims=" %%a in ('dir %infile% "%base%.tex" /od/b ^| more +1'
) do set ext=%%~xa
if "%ext%"==".tex" (pdflatex "%base%.tex") else goto:eof
if errorlevel 1 goto:eof

if not exist "%base%.pdf" goto:eof
for /f "delims=" %%a in ('dir "%base%.pdf" "%base%.tex" /od/b ^| more +1'
) do set ext=%%~xa
if "%ext%"==".pdf" start "" "%base%.pdf"

endlocal

