# This is to test the first tradeoff between maturation rate and juvenile survival.

library(ggplot2)
library(plyr)
library(gridExtra)
source('tfunctions2.R')


# Set up parameters
a <- seq(0.01, 0.99, by=0.01)
b <- seq(-.99, -.01, by = 0.01)
sA <- 0.7
Fec <- 2
parameters <- param_combs(a,b,sA, Fec)

# run tradeoffs

# calculate max(lambda) from a spline function

# plot results.
