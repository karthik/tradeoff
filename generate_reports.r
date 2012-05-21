
system("Rscript -e \"library(knitr); suppressMessages(knit('results.Rmd'))\"")
system("pandoc -s results.md -t latex -o results.pdf")
