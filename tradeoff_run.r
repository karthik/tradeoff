rm(list=ls())
library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev2)
source('~/Github/postdoc/tradeoff/tradeoff_functions.r')


simple <- tradeoff(a, b, sA)
tradeoff(.9, -.8, sA)
tradeoff(.8,-.7, sA)
tradeoff(.7, -.7, sA)
tradeoff(.6, -.7, sA)
tradeoff(.5, -.7, sA)
vd_test <- vd_tradeoff(a, b, sA)
# Plot both tradeoff together
tradeoff.plot(rbind(simple,vd_test))


# Now with a variation in juvenile development
with_juvgamma <- vd_tradeoff(a, b, sA, juvshape =1)
with_juvgamma2 <- vd_tradeoff(a, b, sA, juvshape = 1/(0.5^2))
plot2 <- tradeoff.plot(rbind(simple,with_juvgamma))
plot3 <- tradeoff.plot(rbind(simple,with_juvgamma2))
# plot these data
grid.arrange(plot2,plot3)


# with correlation between juveline and adult development
with_cor <- vd_tradeoff(a, b, sA, corr=.99)
with_cor2 <- vd_tradeoff(a, b, sA,corr=0.7)
plot4 <- tradeoff.plot(rbind(simple,with_cor))
plot5 <- tradeoff.plot(rbind(simple,with_cor2))
grid.arrange(plot4,plot5)



do_tradeoff <- function(tlist) {
	tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, m = NULL)
}

do_vd_tradeoff <- function(tlist) {
	# if others are specified, do those functions.
	tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, m = NULL)
}

#=========================================
rm(list=ls())
library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev2)
source('~/Github/postdoc/tradeoff/tfunctions2.r')


tradeoff(0.9, -0.8, 2, 0.7)
vd_tradeoff(0.9, -0.8, 2, 0.7)
vd_tradeoff(0.9, -0.8, 2, 0.7, juvshape = 1)
vd_tradeoff(0.9, -0.8, 2, 0.7, corr = 0.3)


a <- c(0.8, 0.6, 0.4, 0.2)
b <- c(-0.8, -0.6, -0.4, -0.2)
sA <- (0.7)
Fec <- 2
params <- mapply(list, a=a,b=b,sA=sA,Fec=Fec, SIMPLIFY=F)
result <- llply(params, do_tradeoff, .progress = "text")





