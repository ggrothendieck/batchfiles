setlocal
:: Usage:
::   If arg1 and arg2 are the library subdirectories of two R distributions
::   then all libraries in arg1 that are not already in arg2 are moved to 
::   arg2.  Note that this is a fast way of upgrading to a new version of
::   R but won't work if the versions of R have different library formats.
:: Example:
::   cd \Program Files\R
::   movedir R-2.2.0\library R-2.2.0pat\library
::
for /D  %%a in ("%~1\*") do if not exist %2\%%~na move "%%a" "%~2\%%~nxa"
endlocal
