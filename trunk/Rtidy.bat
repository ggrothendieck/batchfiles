#Rscript %0.bat %*
# usage: Rtidy sourcefile.R > sourcefile.Rtidy.R
options(keep.source = FALSE)
source(commandArgs(TRUE))
dump(ls(all = TRUE), file = stdout())
q("no")

