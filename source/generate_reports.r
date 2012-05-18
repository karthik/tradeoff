setwd('~/Github/postdoc/lh_tradeoff')
suppressMessages(knit('results.Rmd'))
system("Rscript -e \"library(knitr); knit('results.rmd')\"")
system("pandoc -s results.md -t latex -o results.pdf")
