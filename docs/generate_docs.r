setwd('~/Github/postdoc/tradeoff/docs')
knit('plots_knit_.md')
system('pandoc plots.md -o plots.pdf')
system('open -a Preview plots.pdf')
