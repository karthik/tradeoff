library(ggplot2)
library(varDev)
setwd('~/Github/postdoc/lh_tradeoff/')
source('tradeoff_functions.r')

sJ <- 0.8
m <- 0.3
sA <- 0.7
F <- 2 #fecundity

A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2)
max(eigen(A)$values)


example.tradeoff <- tradeoff.curve(0.9, -0.8)
ggplot(example.tradeoff, aes(m, lambda)) + geom_point(size=2) + geom_line()
