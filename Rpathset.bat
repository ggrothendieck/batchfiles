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
:: Normally only R_HOME (and possibly R_ARCH) need be set (as per comments).
:: If you upgrade R then R_HOME must be changed accordingly.
:: If in future Rtools changes path it uses then R_TOOLS_PATH must be changed.
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

:: From within R the HOME directory is the ~ directory:
::    normalizePath("~")
:: It contains your .Rprofile, if any, and unless set otherwise 
:: %R_HOME%\R\win-library contains your personal R library of packages 
:: (from CRAN and elsewhere), if any.  This is also used by some Cygwin tools.
set HOME=%userprofile%\Documents

:: This is needed for some of the Cygwin tools
set cygwin=nodosfilewarning

type %R_TOOLS%\version.txt

:: add Rtools and R to PATH
path %R_TOOLS_PATH%;%R_PATH%;%PATH%

