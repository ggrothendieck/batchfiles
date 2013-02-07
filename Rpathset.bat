:: Purpose: setup path to use R and Rtools from cmd line.
:: Makes no permanent system changes.  Does not read or write registry.
:: Temporarily prepends to PATH and sets environment variables for current 
:: Windows cmd line session only.
::
:: Use: Run this each time you launch cmd.exe and want to use R or Rtools.
::
:: Install: Modify set statements appropriately for your installation.
:: and then place this batch script anywhre on your existing path.
:: (The Windows commandline command PATH shows the current PATH.)
:: 
:: In many cases no changes are needed at all in this file.
:: R_HOME and R_ARCH are the most likely that may need to be changed.
::
:: Report bugs to:
:: ggrothendieck at gmail.com
:: 
:: License: GPL 2.0

:: Go into R and issue this command: normalizePath(R.home())
:: and use its output as the value here
set R_HOME=C:\Program Files\R\R-2.15.2patched

:: 32 or 64 bit version of R.  
:: (If you wish to use both versions of R make two versions of this file.)
:: set R_ARCH=i386
set R_ARCH=x64

:: If in future R changes where it puts its executables then change accordingly
set R_PATH=%R_HOME%\bin\%R_ARCH%

:: directory path where Rtools was installed.  Usually best to use default
:: which is the one shown below.
set R_TOOLS=C:\Rtools

:: If in future Rtools itself changes then change accordingly
set R_TOOLS_PATH=%R_TOOLS%\bin;%R_TOOLS%\gcc-4.6.3\bin

:: From within R, the R_USER directory path can be viewed like this:
::    cat(normalizePath("~"), "\n")
:: It contains your personal .Rprofile, if any, and unless set otherwise 
:: %R_USER%\R\win-library contains your personal R library of packages 
:: (from CRAN and elsewhere).
set R_USER=%userprofile%\Documents

:: This reduces the verbosity of certain Cygwin tools
:: (It it seems to have no effect on some systems.)
set cygwin=nodosfilewarning

:: Displays Rtools version in use
type %R_TOOLS%\version.txt

:: MiKTeX path.  Used to build R packages from source.
:: This is the directory containing pdflatex.exe
set R_MIKTEX_PATH=C:\Program Files (x86)\MiKTeX 2.9\miktex\bin

:: This is only needed when building RMySQL package from source
:: It is not needed to run RMySQL once its built.
:: set MYSQL_HOME=C:\Program Files\MySQL\MySQL Server 5.1

:: This is needed to run JGR and Deducer.
:: R_LIBS is the system library.
:: If you have installed at least one package (at which point R will ask to 
::  set up a personal library -- which you should allow) then R_LIBS_USER
::  is similar to output of .libPaths() with first comnponent being your
::  personal library and second compnent being R_LIBS .
:: set R_LIBS=%R_USER%\R\win-library\2.15
:: set R_LIBS_USER=%R_LIBS%;%R_HOME%\library

:: add Rtools and R to PATH for remainder of current cmd line session
path %R_TOOLS_PATH%;%R_PATH%;%R_MIKTEX_PATH%;%PATH%

if "%1"=="" goto:eof
%*
