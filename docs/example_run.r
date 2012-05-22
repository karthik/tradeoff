##@knitr setup
# This is to test the first tradeoff between maturation rate and juvenile survival.
rm(list=ls())
library(ggplot2)
library(plyr)
library(varDev2)
library(lubridate)
library(gridExtra)
source('../tradeoff_functions.R')


## @knitr  parameters
a <- 0.9
b <- -0.8
sA <- 0.7
Fec <- 2
parameters <- param_combs(a,b,sA, Fec)


## @knitr simple_tradeoff
t1_simple <- llply(parameters, do_tradeoff)

## @knitr simple_tradeoff_results
t1_simple

## @knitr plot
df <- data.frame(x=1:10, y=rnorm(10))
p1 <- ggplot(df, aes(x,y)) + geom_point()
plist <- list(p1,p1,p1,p1,p1,p1,p1,p1,p1)
n <- length(plist)
nCol <- floor(sqrt(n))
do.call("grid.arrange", c(plist, ncol=nCol))


