# This is to test the first tradeoff between maturation rate and juvenile survival.
rm(list = ls())
library(ggplot2)
library(plyr)
library(varDev2)
library(lubridate)
library(gridExtra)
library(data.table)
source("tradeoff_functions.R")
# Set up parameters
# ------------------------------------------------------------------
# a <- c(0.9, 0.8, 0.6)
a <- seq(0.9, 0.1, by = -0.1)
# b <- c(-0.8, -0.7, -0.6)
b <- seq(-0.9, -0.1, by = 0.1)
# sA <- seq(0.3, 0.9, by = 0.1)
sA <- seq(0.1, 0.9, by = 0.1)
# Fec <- c(2, 4, 8, 10)
Fec <- 1:10
parameters <- param_combs(a, b, sA, Fec)


# # run tradeoffs
# # ------------------------------------------------------------------
t1_simple <- llply(sample(parameters,1), do_tradeoff, .progress = 'text')
tradeoff.plot(t1_simple[[1]]$data)

# save(t1_simple, file='t1_simple.rdata')
t1_vd <- llply(sample(parameters,1), do_vd_tradeoff, .progress = 'text')
# save(t1_vd, file='t1_vd.rdata')

# # tradeoffs with variable development
# # ------------------------------------------------------------------
juvshape <- c(1, 0.5, 0.25)
new_params <- param_combs_jg(a, b, sA, Fec, juvshape)
t1_juvshape <- llply(sample(new_params,1), do_vd_tradeoff, .progress = 'text')
# save(t1_juvshape, file = "t1_juvshape.rdata")


# tradeoffs with correlation among stages.
# # ------------------------------------------------------------------
corr <- seq(0.1, 0.9, by = 0.1)
corr_params <- param_combs_corr(a,b,sA,Fec,corr)
t1_corr <- llply(sample(corr_params,1), do_vd_tradeoff, .progress = 'text')
# save(t1_corr, file='t1_corr.rdata')
# calculate max(lambda) from a spline function
# ------------------------------------------------------------------
# plot results.
# ------------------------------------------------------------------
