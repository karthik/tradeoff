# This is to test the first tradeoff between maturation rate and juvenile survival.
rm(list = ls())
library(ggplot2)
library(plyr)
library(varDev2)
library(lubridate)
library(stringr)
library(gridExtra)
library(multicore)
library(data.table)
library(R.utils)
source("tradeoff_functions2.R")
# Set up parameters
# ------------------------------------------------------------------

a <- seq(0.9, 0.1, by = -0.1)
b <- seq(-0.9, -0.1, by = 0.1)
sA <- seq(0.1, 0.9, by = 0.1)
Fec <- 1:10
parameters <- param_combs(a, b, sA, Fec)

# # run tradeoffs
# ```````````````````````````````````````````````````````````````
t1_simple <- mclapply(parameters, do_tradeoff, mc.cores = 72)
fname1 <- generate_filename("t1_simple")
save(t1_simple, file=fname1)


t1_vd <- mclapply(parameters, do_vd_tradeoff, mc.cores = 72)
fname2 <- generate_filename("t1_vd")
save(t1_vd, file=fname2)

# # tradeoffs with variable development
# ```````````````````````````````````````````````````````````````
juvshape <- seq(1, 2, 4)
# This needs to be turned into a CV
new_params <- param_combs_jg(a, b, sA, Fec, juvshape)

# new_params is 44550 long.

t1_juvshape1 <- mclapply(new_params, do_vd_tradeoff, mc.cores = 72)
fname3 <- generate_filename("t1_juv")
save(t1_juvshape1, file=fname3)


# # tradeoffs with correlation among stages.
# # ```````````````````````````````````````````````````````````````
corr <- seq(0.1, 0.9, by = 0.1)
corr_params <- param_combs_corr(a, b, sA, Fec, corr)
t1_corr <- mclapply(corr_params, do_vd_tradeoff, mc.cores = 72)
fname4 <- generate_filename("t1_corr")
save(t1_corr, file=fname4)




