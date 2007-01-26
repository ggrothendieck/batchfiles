#Rscript.bat %0 %*
# usage: tidy sourcefile.R > sourcefile.tidy.R
options(keep.source = FALSE)
source(commandArgs(TRUE))
dump(ls(all = TRUE), file = stdout())
q("no")

