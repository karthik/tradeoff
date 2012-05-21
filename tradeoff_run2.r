library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev)
source('tradeoff_functions.r')


## @knitr setting_up_parameters
a <- 0.9
b <- -0.8
sA <- 0.7 # adult mortality
Fec <- 2 #fecundity

## @knitr basic_tradeoff
simple <- tradeoff(a, b, sA)
vd_test <- vd_tradeoff(a, b, sA)
simple
vd_test


## @knitr plot-1
tradeoff.plot(rbind(simple,vd_test))

fecudity versus survival.
4 trajectories for each level.
