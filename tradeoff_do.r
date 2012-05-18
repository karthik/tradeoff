library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev2)
setwd('~/Github/postdoc/lh_tradeoff/')
source('tradeoff_functions.r')


## @knitr setting_up_parameters
sJ <- 0.8 # juvenile mortality sJ <- seq(0.1,.9,.1)
m <- 0.3 # maturation
sA <- 0.7 # adult mortality
F <- 2 #fecundity
A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2)
max(eigen(A)$values)

## @knitr basic-tradeoff
example.tradeoff <- tradeoff.curve(0.9, -0.8)
example.tradeoff$type <- "Simple_Example"
## There is a nice optimum there.
plot1 <- ggplot(example.tradeoff, aes(m, lambda)) + geom_point(size=2) + geom_line() + opts(title="An example tradeoff")

## @knitr combined-plot-1
plot1
