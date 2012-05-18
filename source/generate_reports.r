
system("Rscript -e \"library(knitr); suppressMessages(knit('source/results.rmd'))\"")
system("pandoc -s results.md -t latex -o results.pdf")
