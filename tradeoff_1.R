# This is to test the first tradeoff between maturation rate and juvenile survival.

rm(list=ls())
library(ggplot2)
library(plyr)
library(varDev2)
library(lubridate)
library(gridExtra)
source('tradeoff_functions.R')


# Set up parameters
# ------------------------------------------------------------------
a <- seq(0.01, 0.99, by=0.01)
b <- seq(-0.99, -0.01, by = 0.01)
sA <- 0.7
Fec <- 2
parameters <- param_combs(a,b,sA, Fec)


# run tradeoffs
# ------------------------------------------------------------------
t1_simple <- llply(parameters, do_tradeoff, .progress = "text")
t1_vd <- llply(parameters, do_vd_tradeoff, .progress = "text")


# tradeoffs with variable development
# ------------------------------------------------------------------
a <- 0.9
b <- -0.8
sA <- 0.7
Fec <- 2
juvshape <- 1
new_params <- param_combs_jg(a,b,sA,Fec,juvshape)
t1_juvshape <- llply(new_params, do_vd_tradeoff, .progress = "text")

# tradeoffs with correlation among stages.
# ------------------------------------------------------------------
corr <- 0.3
corr_params <- param_combs_corr(a,b,sA,Fec,corr)
t1_corr <- llply(corr_params, do_vd_tradeoff, .progress = "text")

# calculate max(lambda) from a spline function
# ------------------------------------------------------------------


# plot results.
# ------------------------------------------------------------------

