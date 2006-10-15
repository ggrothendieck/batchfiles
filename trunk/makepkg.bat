setlocal

set installargs=
set buildargs=
set checkargs=
set buildargs=--no-vignettes
set checkargs=--no-vignettes

:: Usage: makepkg check mypkg
:: or   : makepgk install mypkg
::    where mypkg is path to mypkg source
:: For install, package is installed in .\library
::
:: In both cases a .tar.gz file is built first.

set pkgsrc=%2
FOR /F "tokens=1,2" %%i in (%pkgsrc:/=\%\DESCRIPTION) do (
	if /i %%i==Version: set pkgversion=%%j
	if /i %%i==Package: set pkgname=%%j
)

set pkgversion
set pkgname

set "tarfile=%pkgname%_%pkgversion%.tar.gz"

if %1x == x ( 
	echo "Usage: makepkg install mypkg or makepkg check mypkg"
	goto:eof 
)

call :%1
goto:eof

:build
	call rcmd build %pkgsrc% %buildargs%
	set r
	pause
	goto:eof

:install
	call :build
	if not exist library md library
	:loop
		set bck=%pkgname%-%random%.bck
		if exist %bck% goto :loop
	if exist "%pkgname%" move library\%pkgname% %bck%
	cd
	dir %tarfile%
	call rcmd install %tarfile% -l library %installargs%
	goto:eof

:check
	call :build
	call rcmd check %tarfile% %checkargs%
	goto:eof

endlocal
