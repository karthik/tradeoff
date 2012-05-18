library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev2)
setwd('~/Github/postdoc/lh_tradeoff/')
source('tradeoff_functions.r')


## @knitr setting_up_parameters
a <- matrix(rnorm(100), nrow=10)
# Juvenile mortality
sJ <- seq(0.1,0.9,0.1)
# Maturation
m <- seq(0.1,0.3,0.1)
# Adult mortality
sA <- 0.7
# Fecundity
F <- 2
# Make the below to be vectors......
sJ <- 0.8
# juvenile mortality sJ <- seq(0.1,.9,.1)
m <- 0.3
# maturation
sA <- 0.7
# adult mortality
F <- 2
#fecundity
A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2)

## @knitr plot-1
image(a)
