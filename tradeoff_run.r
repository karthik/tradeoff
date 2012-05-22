
#=========================================
rm(list=ls())
library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev2)
source('~/Github/postdoc/tradeoff/tradeoff_functions.r')

# Full example. For the time being play with something simpler.
# a <- seq(0.99,0.01, by=-0.01)
# b <- seq(-.99, -0.01, by=0.01)
# sA <- seq(0.1, 0.9, by=0.1)
# Fec <- 2
# parameters <- param_combs(a,b,sA,Fec)

a <- c(0.9,0.8, 0.6)
b <- c(-0.8, -0.7, -0.6)
sA <- 0.7
Fec <- 2
parameters  <- param_combs(a,b,sA,Fec)
# This will allow me to track which simulations come from which parameters. I could plot this on the figure.

# The basic tradooff case
result <- llply(params, do_tradeoff, .progress = "text")
# This is an example of how to push each list item through the plotting function.
xx <- llply(result, tradeoff.plot)

# Now moving to the vd tradeoff case.
vd_result <- llply(params, do_vd_tradeoff, .progress = "text")

# Now with juvgamma
a <- c(0.9,0.8, 0.6)
b <- c(-0.8, -0.7, -0.6)
sA <- 0.7
Fec <- 2
juvgamma <- 1
parameters  <- expand.grid(a,b,sA,Fec,juvgamma)
params <- mapply(list, a=parameters[,1],b=parameters[,2],sA=parameters[,3],Fec=parameters[,4], juvgamma = parameters[,5], SIMPLIFY=F)
vd_result_jg <- llply(params, do_vd_tradeoff, .progress = "text")





