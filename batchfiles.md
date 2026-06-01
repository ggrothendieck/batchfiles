# Windows Batch Files for R #

G. Grothendieck

Software and documentation is (c) 2013 and (c) 2026 GKX Associates Inc. and licensed under [GPL 2.0](http://www.gnu.org/licenses/gpl-2.0.html).

## Introduction ##

This document describes a number of Windows batch, javascript and `.hta` files
that may be used in conjunction with R.  Each is self contained and independent
of the others.  None requires installation - just place on the Windows path or
in current directory.  ^[To display the Windows path enter `path` without
arguments at the Windows `cmd` line.  To display the path to the current
directory enter `cd` without arguments at the Windows `cmd` line.]

`R.bat` is used to run R without permanently modifying the Windows
registry.   It can also be useful on systems with
restricted access to the registry.  To configure it simply modify the 
`set R_HOME` line near the top to point to the current version of R
you wish to use.

`movedir.bat` and `copydir.bat` are used for moving or copying packages from
one library to another such as when R is upgraded to a new version.  Thre is
nothing specific to R in these.  They simply move or copy the files from one
directory to another. I don't use these any more since I find that I collect
numerous packages that I no longer use and prefer to start with a fresh slate
on each new version of R.

`el.js` runs its arguments in elevated mode (i.e. with Administrator
privileges).

`clip2r.js` copies the current clipboard into a running R instance. It can be
used with `vim` or other text editor.

## R.bat ##

### Purpose ###

The purpose of `R.bat` is to run R from the Windows `cmd` 
line while eliminating the need to make any registry changes.

### Typical Usage ###

Typical usage of `R.bat` to launch R gui is the following ^[
If `R.exe` were on the Windows path and before `R.bat` then it would
have to be written as follows: `R.bat gui`]:

	R gui


This runs `Rgui.exe`.  If further arguments are specified they are passed on to
`Rgui.exe`.  For example,

	R gui --help

will run: 

	Rgui.exe --help

### Subcommands ###

Running

    R help 

will show usage information.  The first argument is a subcommand so `R gui`
starts the R gui, `R dir` lists the directories in the R directory (one for
each version of R you have installed), `R cd` changes to the R directory,
`R show` shows the environment variable blues that R.bat is using (as well
as any other environment variables that begin with R).

```
> R help
Usage: R [command] [args...]

Core R Executables (Default is 'r'):
  r       - Runs R.exe console
  gui     - Spawns Rgui.exe
  cmd     - Runs Rcmd.exe
  term    - Runs Rterm.exe
  script  - Runs Rscript.exe
  setreg  - Runs RSetReg.exe

Tcl/Tk Shells (Dynamic Version Discovery):
  tclsh   - Runs internal tclsh*.exe
  wish    - Spawns internal wish*.exe GUI

Utilities:
  cd      - Opens a command prompt at the parent directory (C:\Program Files\R)
  dir     - Lists files in the parent directory
  show    - Displays active environment variables starting with 'R'
  help    - Displays this help details
```

### Selecting R Version ###

To configure the R.bat edit it with a text editor and change the value
of R_HOME to point to the root of the tree of the version of R you want it 
to invoke. For example:
```
set "R_HOME=C:\Program Files\R\R-4.5"
```
If you have multiple versions of R that you want to access at the same time
make a copy of R.bat with a new name and set the `set R_HOME` line to the
relevant version of R in each.

## el.js ##

`el.js` runs its arguments elevated (i.e. with Adminstrator privileges).  For example, if you have Rtools installed and on your PATH then:

	el touch "C:\Program Files\R\R-4.5"

The user will be prompted to allow elevation to proceed.

## clip2r.js ##

This program writes the clipboard into the running Rgui session.  It can be 
used with `vim` or other text editor.

Here is the exact keystroke breakdown:

Set the focus to Rgui and then send these keys to it:

%  (Alt + Space): Opens the native Windows system menu (the window management menu in the top-left corner of the window frame).

x: Selects Maximize from that menu to force the window into full screen.

%{w} (Alt + W): Opens the Rgui Windows menu.

1 Types the literal number 1 selecting R Console from the Windows menu.

^{v} (Ctrl + V): Executes a standard Paste command, dumping whatever text payload is currently sitting in your Windows clipboard straight into the active input line.

See the source for additional instructions.

## make-batchfiles-pdf.bat ##

This batch file, which is mainly for my own use, creates `batchfiles.pdf` from
the markdown file `batchfiles.md` .  `pandoc` must be installed for this to
run.  It is run without arguments:

	make-batchfiles-pdf

