library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev)
source('~/Github/postdoc/tradeoff/tradeoff_functions.r')


## @knitr setting_up_parameters
a <- 0.9
b <- -0.8
sA <- 0.7 # adult mortality
Fec <- 2 #fecundity

## @knitr basic-tradeoff
simple <- tradeoff(a, b, sA)
vd_test <- vd_tradeoff(a, b, sA)
simple
vd_test


## @knitr plot-1
tradeoff.plot(rbind(simple,vd_test))

## @knitr with_juvgamma
with_juvgamma <- vd_tradeoff(a, b, sA, juvshape =1)
with_juvgamma2 <- vd_tradeoff(a, b, sA, juvshape = 1/(0.5^2))
with_juvgamma
with_juvgamma2

## @knitr plot-2
plot2 <- tradeoff.plot(rbind(simple,with_juvgamma))
plot3 <- tradeoff.plot(rbind(simple,with_juvgamma2))
grid.arrange(plot2,plot3)

## @knitr with_correlation
with_cor <- vd_tradeoff(a, b, sA, corr=.99)
with_cor2 <- vd_tradeoff(a, b, sA,corr=0.7)
with_cor
with_cor2

## @knitr plot-3
plot4 <- tradeoff.plot(rbind(simple,with_cor))
plot5 <- tradeoff.plot(rbind(simple,with_cor2))
grid.arrange(plot4,plot5)



## @knitr com
a <- rep(0.9, 5)
b <- rep(-0.8, 5)
sAl <- rep(sA, 5)
Fec <- rep(2,5)
params <- list(0.9, -0.8, 0.7, 2)
trial <- mapply(list, a=a, b=b, sA=sAl, Fec = Fec, SIMPLIFY=FALSE)
params <- llply(trial, do_tradeoff)

do_tradeoff <- function(tlist) {
	browser()
	tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, m.grid = NULL)
}
