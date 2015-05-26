**Note: Discussion of batchfiles is now available in the [sqldf discussion group](https://groups.google.com/forum/?fromgroups#!forum/sqldf) .**

[batchfiles](http://cran.r-project.org/contrib/extra/batchfiles/) contains batch ([.bat](http://en.wikipedia.org/wiki/Batch_file)) and javascript  ([.hta](http://en.wikipedia.org/wiki/HTML_Application) and [.js](http://en.wikipedia.org/wiki/Javascript)) files useful in conjuction with [R](http://www.r-project.org) and R packages on Microsoft Windows. There is no formal installation, each consists of a single file and is independent of the others so just place any or all of them anywhere in your [Windows path](http://code.google.com/p/batchfiles/#HOWTO) and you will be able to access them in any Windows console session.  **A [list](#PROGRAM_LIST.md) of the utilities is given [below](#PROGRAM_LIST.md).**

**Summary:**

The main utility `R.bat` installing and starting R from the Windows cmd line. It eliminates the need to set the Windows PATH, to set environment variables or to set registry entries.  It automatically locates R and associated software using environment variables or registry entries if set and looks in standard locations if not.  This also eliminates the need to reconfigure each time you install a new version of R and simplifies the use of multiple versions of R at the same time.   Its a single file with no dependencies. Just download it, place it on your Windows path and enter `R help` and/or read the `batchfiles.pdf` document.

`Rpathset.bat` is an alternative to `R.bat` that is also included.  It takes a different approach.  Unlike `R.bat` it is not automatic but in exchange for that it is very simple internally - mostly just a bunch of SET statements that the user can manually set.  This make it easy to modify for the set up of custom non-standard installations.  Other included utilities are listed below.

**Latest News:**

  * A new batch script [#Rscript2.bat](https://batchfiles.googlecode.com/svn/trunk/%23Rscript2.bat) has been added.  It is a simpler version of of #Rscript.bat so if anything goes wrong it will be easier to fix; however, there is an additional installation step which involves editing the batch file to specify the location of R.  See the relevant section in the documentation: [batchfiles.md](https://batchfiles.googlecode.com/svn/trunk/batchfiles.md) .

  * Discussion of batchfiles is now available in the [sqldf discussion group](https://groups.google.com/forum/?fromgroups#!forum/sqldf)

  * [batchfiles 0-7.1](http://cran.r-project.org/contrib/extra/batchfiles/) has been released.  Key new items are:
    * [R.bat](https://batchfiles.googlecode.com/svn/trunk/R.bat) - configuration-free (i.e. no need to set environment variables, PATH or registry entries) way to run R. Just download, place on the Windows path and try `R.bat help`. (This utility incorporates and consolidates many of the prior utilities which are therefore omitted.)
    * [Rpathset.bat](https://batchfiles.googlecode.com/svn/trunk/Rpathset.bat) - simple alternative to `R.bat path` .  Unlike  `R.bat`, which is configuration-free this, is manually set up through SET statements.  The advantage is that it is very simple.  Just download it, modify the `SET` statements in it  (if need be), place it on the Windows path and run it as `Rpathset.bat` and it will add the directories you need to your path for the current cmd session.
    * [batchfiles.md](https://batchfiles.googlecode.com/svn/trunk/batchfiles.md) - detailed documentation. Also available as a PDF file in the [batchfiles distribution](http://cran.r-project.org/contrib/extra/batchfiles/).

**Contents:** Below on this page are sections on:


## Download ##

The latest release is available [on CRAN](http://cran.r-project.org/contrib/extra/batchfiles/).

An even more recent development version is available in the [Source tab](http://code.google.com/p/batchfiles/source/checkout) above.  The entire development version can be checked out using svn using the instruction there.  Individual batch files can be downloaded from the repo without the need to use svn.  To do that, from the Source tab above click on Browse and then click on trunk and then click on the file you wish to view.  To download the file click on View raw file to the right to see the file without annotation.  In your browser right click Save As will save it to your machine.  (Note tha the pdf file is provided in the CRAN release but is not stored in the repo.  The [batchfiles.md](https://batchfiles.googlecode.com/svn/trunk/batchfiles.md) file from which the pdf is generated is actually quite readable so just read it directly or if you want to convert it to pdf anyways install [pandoc](http://johnmacfarlane.net/pandoc/installing.html), download [batchfiles.md](https://batchfiles.googlecode.com/svn/trunk/batchfiles.md) and [make-batchfiles-pdf.bat](https://batchfiles.googlecode.com/svn/trunk/make-batchfiles-pdf.bat) and run the last one without arguments.)

## PROGRAM LIST ##
For more information on these commands see [batchfiles.md](https://batchfiles.googlecode.com/svn/trunk/batchfiles.md).  Also those marked with (h) after them give help if run without arguments which is an easy way to get info on those.  The scripts marked with (0) after them are normally used without arguments so you can just run it that way to see what it does.
```
Legend:
d = in development version of batchfiles only
h = no args gives help
0 = common usage is to enter command name without arguments

batchfiles.pdf - documentation
clip2r.js - pastes clipboard into `Rgui`.  See comments in file for use from vim. (0)
copydir.bat - copy a library from one version of R to another (h)
el.js - run elevated - Vista and up
find-miktex.hta - GUI to find MiKTeX (0)
movedir.bat - move library from one version of R to another (h) 
R.bat - run `R`, `Rgui`, `Rcmd`, `RSetReg` plus other functions.  `R help` for more info.
#Rscript2.bat - simpler version of #Rscript.bat - must edit it to specify path to R. (d)
Rpathset.bat - sets path so that `R`, `Rgui`, etc. and `Rtools` can be used.  Modify SET statements in it as needed.
```

## NEWS (older) ##

More recent news in Latest News section above.

Jan 4, 2013. Many of the batch files are incompatible with the most recent versions of R and Rtools.  Until this is addressed a new tool has been added, `Rpathset.bat` .  Run it prior to using R or Rtools in any cmd line session and it will add the appropriate directories to the PATH so that R, Rgui, etc. and Rtools can be used.  It does not read or write the registry and makes no permanent changes to your system.  Note that unlike the other utilities several environment variables in `Rpathset.bat` may need to be changed to use this utility.   See the comments in that batch file.

Sep 3/11.   batchfiles 0.6-6 has been uploaded to CRAN.  It is a bug fix release.

May 3/11.  Added the cmd package to the downloads area.  It has commands `cmd32()` and `cmd64()` which will spawn a Windows console session with `bin\i386` or `bin\x64` first in the path.   In most cases we recommend users use the batch files here rather than the cmd package.

April 9/11.  New batch file `RtoolsVersion.bat` displays Rtools version.

Jan 30/11.  A bug fix version batchfiles\_0.6-4.zip has been uploaded to [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/) .

Jan 21/11.  A bug fix version batchfiles\_0.6-3.zip has been uploaded to [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/) .

Jan 20/11.  Added Q9 to [Troubleshooting FAQ](#TROUBLESHOOTING_FAQ.md).

Jan 18/11.  A bug in Sweave.bat/Stangle.bat in which it was ignoring switches was fixed.  This must have been introduced in some recent version of these scripts since older versions seem not to have this problem.  Sweave.bat and Stangle.bat can be obtained from http://batchfiles.googlecode.com/svn/trunk/Sweave.bat and http://batchfiles.googlecode.com/svn/trunk/Stangle.bat

Jan 17/11.  A bug in Sweave.bat/Stangle.bat that affected 64 bit systems was fixed. They are in the svn repository and can be found here: http://batchfiles.googlecode.com/svn/trunk/Sweave.bat and http://batchfiles.googlecode.com/svn/trunk/Stangle.bat

Dec 20/10. Additional bug fixes were committed to the [development repository](http://code.google.com/p/batchfiles/source/checkout) today.

Dec 19/10.  Version 0.6-1 for R 2.12.0 and later has uploaded to [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/) (and can also be accessed from the  [development repository](http://code.google.com/p/batchfiles/source/checkout)).  This is a bug fix release.  The R\_ARCH environmental variable, if set, can now be any of 32, i386, /i386, 64, x64, /x64.  (Its available from the main CRAN site and the development repository and will be available shortly from the CRAN mirrors.)

The main changes is that they handle the new architecture-specific directory structure required in R 2.12.0 .   Several lesser used commands were dropped.


Dec 12/10.  Version 0.6-0 for R 2.12.0 has uploaded to [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/) (and can also be accessed from the  [development repository](http://code.google.com/p/batchfiles/source/checkout)).  The main changes is that they handle the new architecture-specific directory structure required in R 2.12.0 .   Several lesser used commands were dropped.

May 31/09.  clip2r.js added to [development area](http://code.google.com/p/batchfiles/source/checkout).  This utility is typically called from a vim macro which places the buffer into the clipboard and then launches clip2r.js.   It then pastes the clipboard into R.   See comments in file for using it from vim.

May 26/09.  #Rscript.bat with bug fixes was uploaded to the [development area](http://code.google.com/p/batchfiles/source/checkout).  If `test.bat` is an R file with `#Rscript.bat $0 $*` as the first line it can be run from the Windows cmd console as `test`, as `test.bat` or can be double clicked from Windows Explorer whereas previously some but not all of these worked and which ones worked varied.  Thanks to Nicholas Hirschey for pointing this out and testing.

May 25/09.  batchfiles\_0.5-0.zip is now on [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/) and should appear on the mirrors shortly.  The new features are listed [here](http://batchfiles.googlecode.com/svn/trunk/NEWS), a list of included programs is shown [here](http://code.google.com/p/batchfiles/#PROGRAM_LIST) and further documentation can be found in the README [here](http://batchfiles.googlecode.com/svn/trunk/README).

May 23/09.  Batch files in [devel version](http://code.google.com/p/batchfiles/source/checkout) now work with Windows XP, Vista, Windows 7 and both 32 and 64 bit Windows.  Thanks to Nicholas Hirschey for testing and contributions.

May 23/09. In the [devel version](http://code.google.com/p/batchfiles/source/checkout) [jgr.bat](http://code.google.com/p/batchfiles/source/browse/trunk/jgr.bat) automatically locates both R and that R library holding the JGR package and passes their paths to jgr.exe.  Thus [jgr installation](http://jgr.markushelbig.org/JGR_Installation.html) only involves placing [jgr.exe](http://jgr.markushelbig.org/JGR_Installation.html) anywhere on the Windows PATH and installing the [JGR R package](http://cran.r-project.org/web/packages/JGR) (and optionally setting the version of java using [jselect.exe](http://jgr.markushelbig.org/JGR_Installation.html)).  Note that jgr.bat is still in development and is not currently recommended for use.

May 7/09.  Added Q8 to [Troubleshooting FAQ](#TROUBLESHOOTING_FAQ.md) below.

Jan 22/09.  [Rversions.hta](http://code.google.com/p/batchfiles/source/browse/trunk/Rversions.hta) now sets the `.RData` association as well.  Also [RExcelVersion.hta](http://code.google.com/p/batchfiles/source/browse/trunk/RExcelVersion.hta) is like `Rversions.hta` but has some visual enhancements and testing so it works on XP as well (both thanks to Erich Neuwirth).  `RExcelVersion.hta` is intended for use with the [RExcel Excel addin](http://sunsite.univie.ac.at/rcom/excel/index.html) but there is nothing specific to RExcel so it can be used apart from it as well.  `RExcelVersion.hta` may eventually replace `Rversions.hta`; however, there may still be some development on it prior to that so for the moment its being kept separate.

Dec 12/08.  New command [find-miktex.hta](http://code.google.com/p/batchfiles/source/browse/trunk/find-miktex.hta) to display path of the MiKTeX bin directory.  Call from Windows console with no arguments or double click from Windows explorer and it will display the path to the MiKTeX executables in a browser-like window.  (Internally this command uses the MiKTeX SDK to find MiKTeX.   This is in contrast to the other utilities in this collection that use a heuristic.)

Dec 6/08.  In the _Modifying Path_ HOWTO we added information on setenv.exe, a free setx clone.

Nov 26/08.  Added information on Windows 7 in the HOWTO section.

Oct 29/08.  Added Q6 and Q7 to troubleshooting section.

Sep 27/08.  Added information on Vista Run Commands (most work in XP too) in the HOWTO section.

August 2/08.  Added information on Vista SP1 Performance Tuning in the HOWTO section below.

July 18/08. This [message](https://stat.ethz.ch/pipermail/r-devel/2008-July/050207.html) on [r-devel](https://stat.ethz.ch/pipermail/r-devel/) discusses a number of reasons not to set PATH yourself but, instead, use batch files.

July 10/08.  New file, [show-svn-info.hta](http://code.google.com/p/batchfiles/source/browse/trunk/show-svn-info.hta) added.   When run from a Tortoise SVN folder (version 1.5 or higher) it shows some information about it.

July 5/08. batchfiles 0.4-3 is now on [CRAN](http://probability.ca/cran/contrib/extra/batchfiles/). It fixes a bug in [Sweave.bat](http://code.google.com/p/batchfiles/source/browse/trunk/Sweave.bat) and [Stangle.bat](http://code.google.com/p/batchfiles/source/browse/trunk/Stangle.bat) .

June 25/08. Came across (1) this [presentation](http://ablejec.nib.si/R/Blejec-Sweave-080519.pdf) by Andrej Blejec (in Slovenian), (2) this  [Sweave guide](http://www.tug.org/pracjourn/2008-1/zahn/zahn.pdf) by Ista Zahn on the [TeX User Group site](http://www.tug.org) and (3) these [Lyx support files](http://cran.r-project.org/contrib/extra/lyx/) in the [CRAN Other Software](http://cran.r-project.org/other-software.html) section that all mention [Sweave.bat](http://code.google.com/p/batchfiles/source/browse/trunk/Sweave.bat) .

June 23/08.  As toggleDoc was the only perl program in batchfiles it has been removed from the development source to maintain the integrity of the collection.  After batchfiles 0.4-2 it will no longer be distributed with batchfiles; however, it can still be found in [batchfiles\_0.4-2.zip](http://cran.r-project.org/contrib/extra/batchfiles/batchfiles_0.4-2.zip) as it and all past versions of batchfiles are archived on [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/).

June 15/08.  [batchfiles\_0.4-2.zip](http://cran.r-project.org/contrib/extra/batchfiles/batchfiles_0.4-2.zip) has been uploaded to [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/).  Details in [ANNOUNCE](http://batchfiles.googlecode.com/svn/trunk/ANNOUNCE) and [README](http://batchfiles.googlecode.com/svn/trunk/README).

June 13/08.  [Stangle.bat](http://code.google.com/p/batchfiles/source/browse/trunk/Stangle.bat) and [Sweave.bat](http://code.google.com/p/batchfiles/source/browse/trunk/Sweave.bat) have been made to be the same file.  Each queries the name it was called by to determine which to run.

June 9/08.  [Stangle.bat](http://code.google.com/p/batchfiles/source/browse/trunk/Stangle.bat) added.  Like [Sweave.bat](http://code.google.com/p/batchfiles/source/browse/trunk/Sweave.bat) (version 0.3-2 and later), Stangle.bat does _not_ depend on rtools/cygwin/sh.exe .

June 9/08.  sweave.bat is now Sweave.bat in the svn.  This should not make any difference as Windows is case insensitive to file names.

May 20/08.  New facility in the [development Source](http://code.google.com/p/batchfiles/source) in which the various batchfiles first search for `rbatchfilesrc.bat` in current directory and then in `%userprofile%` and then in same directory as the batchfile itself and use first one found, if any.  If one is found then it may contain set statements for `R_HOME`, `R_TOOLS` and `R_MIKTEX` (or a subset of those) and it will use those in place of the registry and its MiKTeX heuristic.  That will allow use of batchfiles without setting any environment variables outside of the batchfiles and without registry access.  It also allows different directories to easily and automatically use different versions of R.  More info is available in the [NEWS](http://batchfiles.googlecode.com/svn/trunk/NEWS) file.  It is anticipated that most users will **not** use this facility nor the closely related environment variable facility since its easier just to let the batchfiles automatically determine the various paths by allowing it to access the registry but for some users who wish to set up certain custom installations this may be a useful alternative.  Note that if one does not use this facility or the environment variables provided then the registry is only read, not written with one exception:  That one exception is [Rversions.hta](http://batchfiles.googlecode.com/svn/trunk/Rversions.hta) (and in batchfiles 0.3-2 also rversions.bat) which can set in the registry which version of R is the current one. It does that by calling RSetReg.exe which is a program that is included with every version of R.

May 19/08.  Added a new question to the `Troubleshooting Section` below.

May 15/08. Added a workaround for a bug in R in which Sweave.sty is not found when sweaving a file.

Mar 5/08.  Added a _Troubleshooting_ section below.

May 4/08. batchfiles 0.4-1 has been uploaded to [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/).  It eliminates the need to set the PATH when building R packaes -- previous versions of batchfiles eliminated it only for running R but not building packages.  Also new [rtools.bat](http://code.google.com/p/batchfiles/source/browse/trunk/rtools.bat) and [el.js](http://code.google.com/p/batchfiles/source/browse/trunk/el.js) utilities.  Details in [NEWS](http://batchfiles.googlecode.com/svn/trunk/NEWS), [ANNOUNCE](http://batchfiles.googlecode.com/svn/trunk/ANNOUNCE) and [README](http://batchfiles.googlecode.com/svn/trunk/README).

Apr 30/08.  The development source for Rcmd.bat and similar batch files now automatically find http://www.murdoch-sutherland.com/Rtools in the registry (and they look for MiKTeX heuristically in a few places) so not only does one not have to set the PATH variable for running R but one does not have to set it for building R packages either.

Apr 30/08.  The XP HowTo's are being moved from the box to the right to their own section on this page below. A new one on a free utility, SetEnv, is added too.

Mar 20/08.  Added two new Vista HowTo's. The Vista HowTo's are now below in the HowTo section while the XP HowTo's (some of which apply to Vista too) are in the Links box to the right.

Jan 16/08.  batchfiles version 0.4-0 is now on [CRAN](http://cran.r-project.org/contrib/extra/batchfiles/).  (Version 0.4-0 and all future versions will be tested on Vista. Reports from XP users using it are welcome.  Version 0.3-2 was tested on XP so XP users can use that.)

Jan 12/08.  [sweave.bat](http://batchfiles.googlecode.com/svn/trunk/sweave.bat) has been made independent of [Rterm.bat](http://batchfiles.googlecode.com/svn/trunk/Rterm.bat) so now all batch and javascript files are standalone and do not depend on each other or on other external programs other than possibly R in some cases.  ([toggleDoc.pl](http://batchfiles.googlecode.com/svn/trunk/toggleDoc.pl) that was just contributed does depend on perl and on [toggleDoc.js](http://batchfiles.googlecode.com/svn/trunk/toggleDoc.js) so it is the only utility with non-R dependencies.)

Jan 12/08. Removed find-miktex.bat, Rfind.bat, makepkg.bat and withgs.bat from the development [Source](http://code.google.com/p/batchfiles/source) -- they are still available in [batchfiles version 0.3-2](http://cran.r-project.org/contrib/extra/batchfiles/batchfiles_0.3-2.zip).

Jan 12/08. Added [toggleDoc.pl](http://batchfiles.googlecode.com/svn/trunk/toggleDoc.pl)/[toggleDoc.js](http://batchfiles.googlecode.com/svn/trunk/toggleDoc.js), a perl program and associated file, that adds a toggle box to the 00Index.html file in each package in your library.  When the toggle box is checked, it collapses similar HTML help lines into one.   Try checking and unchecking the toggle box labeled Show All at [this page](http://www.menne-biomed.de/download/toggleDoc/00Index.html) to get the idea.  Contributed by [Dieter Menne](http://www.menne-biomed.de/).

Jan 2/08.  There is a new file, [RguiStart.bat](http://batchfiles.googlecode.com/svn/trunk/RguiStart.bat), in the development [Source](http://code.google.com/p/batchfiles/source) that starts up Rgui.exe in the directory specified by its first argument.  On Vista put RGuiStart.bat in the %APPDATA%\Microsoft\Windows\SendTo folder and then in Windows Explorer you can right click any folder > SendTo > RGuiStart.bat to start R in that folder.  See comments in these r-help posts:
https://stat.ethz.ch/pipermail/r-help/2008-January/149455.html and
https://stat.ethz.ch/pipermail/r-help/2008-January/149458.html
RGuiStart.bat is actually the same file as Rgui.bat, Rcmd.bat, R.bat, Rterm.bat, Rscript.bat, #Rscript.bat and Rjgr.bat.  The common script queries what name it was called by to determine what to do.

Sep 9/07.  In the development version of batchfiles there is a new [Rversions.hta](http://batchfiles.googlecode.com/svn/trunk/Rversions.hta) for Vista with some code cleanup and improved heuristic for locating R.

## NOTES ##

**Modifying PATH**
Users of the batchfiles presented here are largely freed from having to modify the path in the first place; however, if you do need to do it then this is how.  The PATH command from the Windows console will change the PATH for that cmd session.  See `PATH /?` for more info.

Here is an example of adding C:\ to the start of your path (for the remainder of the current cmd session only):
```
path C:\;%path%
```
To permanently change the path (1) [these instructions](http://banagale.com/changing-your-system-path-in-windows-vista.htm) describe how to do it through the control panel or (2) one can use the setx command available in Vista and Windows 7 (or at extra cost from the Windows resource kit for XP; however, there is a free clone called [setenv.exe](http://barnyard.syr.edu/~vefatica/#SETENV)) or (3) the free [Redmond Path utility](http://download.cnet.com/Redmond-Path/3000-2094_4-10811594.html)  or [Path Manager](http://www.softpedia.com/get/System/System-Miscellaneous/Path-Manager.shtml) which makes it particularly easy to set your path by providing a gui editor into which it dumps your path, one component per line, so you can visually edit it and save it back.

**Set Environment Variables Permanently through batch**  [SetEnv](http://www.codeproject.com/KB/applications/SetEnv.aspx?fid=230498&df=90&mpp=25&noise=3&sort=Position&view=Quick&select=1531752&fr=48)

**Create Shortcut from cmd line**
See [xxmklink](http://www.xxcopy.com/xxcopy38.htm).

**Install package from CRAN**
Ordinarily you simply start R and choose the _Packages | Install_ menu (or else use the R `install.packages` command):
```
install.packages("zoo")
```
If the package is one that comes with R itself, such as _lattice_, then you need to run R in elevated mode.  (For ordinary packages this is not needed.)  To run R in elevated mode, on your Windows Desktop, right click on R and choose _Run As Administaror_ .   Then when R starts choose the _Packages | Install Package(s)_ menu item.  Alternately, from the Windows command line use the el.js and Rgui.bat batchfiles like this to start R as shown below and then proceed to _Packages_ menu, as before:
```
el R gui
```
Another way to run R elevated is to click the Windows Start button in the lower left of the screen  and enter `cmd.exe` into the Search box terminating it not with Enter but with Shift-Ctrl-Enter.  That will give a command line which is elevated.  Then run R from the command line using the batchfiles' Rgui command.

(If despite doing the above that you get a message about packages.html not being writable then find the offending file in Windows Explorer and right-click that file's name choosing Properties > Security tab and reset the permissions appropriately.  You may or may not also need to do the same thing on that file's folder.)

**Run Commands**
A long list of commands that can be entered in a Windows console: [Run Commands](http://www.ontechnews.com/computer-tips/shortcuts/useful-run-commands-for-windows-vista-and-xp/)

**Simple command line utilties for Windows**
Microsoft has a collection http://technet.microsoft.com/en-us/sysinternals and there is a collection of UNIX-like tools put together by Duncan Murdoch with a professional R-style installer http://www.murdoch-sutherland.com/Rtools .  Several other collections are Bill Stewart's tools http://www.westmesatech.com/index.html and the Optimum X collection http://www.optimumx.com/downloads.html.  Timo Salmi's cmd.exe script tricks http://www.netikka.net/tsneti/info/tscmd.php may let you write your own in certain cases.

**File Associations**
File associations are performed from the command line using the `assoc` and `ftype` commands in Windows.  From the Windows console try `help assoc` and `help ftype` and also try issuing the two commands without arguments to view the present associations.

**AutoHotKey Scripts**
There are [AutoHotKey](http://www.autohotkey.com) scripts by [Jose Quesada](http://www.josequesada.name/) to [send code from the vim editor to R](https://stat.ethz.ch/pipermail/r-help/2009-May/199994.html), to [start R](http://tolstoy.newcastle.edu.au/R/e4/help/08/01/0145.html) and to [autoclose parentheses](https://stat.ethz.ch/pipermail/r-help/2009-May/199629.html).

**Suspending a Task**
[DTaskManager](http://dimio.altervista.org/eng/) is a free 2000/XP/Vista Windows utility that can be used to suspend tasks.

**Reg String to Start Rgui**
See https://stat.ethz.ch/pipermail/r-help/2010-January/224444.html.  It does not start up a separate cmd window and works on Windows 7 too.

**Ready Boost**
Windows Vista and higher allow one to use the storage on a USB key for extra cache space.  This will improve performance, particularly if there was only a single hard drive and small main memory. Only USB keys with sufficiently fast storage will work.  More information on this feature is available from:[Tom Archer's MSDN blog](http://blogs.msdn.com/tomarcher/archive/2006/04/14/576548.aspx) and [Tom Archer's FAQ](http://blogs.msdn.com/tomarcher/archive/2006/04/14/576548.aspx).