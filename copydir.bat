setlocal
:: Usage:
::   If arg1 and arg2 are the library subdirectories of two R distributions
::   then all libraries in arg1 that are not already in arg2 are copied to 
::   arg2.  Note that this is a fast way of upgrading to a new version of
::   R but won't work if the versions of R have different library formats.
::   I believe this will work for upgrading 2.x.x to a higher 2.x.x and
::   I personally upgraded my 2.1.0 to 2.2.0 this way so it seems ok until
::   R replaces this with something better which is expected for 2.3.0.
:: Example:
::   cd \Program Files\R
::   copydir rw2011pat\library R-2.2.0\library
::
:: Notes on code:
:: on xcopy command /e copies subdir/files incl empty ones
:: on xcopy command /i causes target to be created
for /D  %%a in ("%~1\*") do if not exist %2\%%~na xcopy /e/i "%%a" "%~2\%%~nxa"
endlocal
