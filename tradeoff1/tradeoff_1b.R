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
# t1_simple <- mclapply(parameters, do_tradeoff, mc.cores = 72)
# fname1 <- generate_filename("t1_simple")
# save(t1_simple, file=fname1)


# t1_vd <- mclapply(parameters, do_vd_tradeoff, mc.cores = 72)
# fname2 <- generate_filename("t1_vd")
# save(t1_vd, file=fname2)

# # tradeoffs with variable development
# ```````````````````````````````````````````````````````````````
juvshape <- seq(1, 3, by=0.25)
# This needs to be turned into a CV
new_params <- param_combs_jg(a, b, sA, Fec, juvshape)

# new_params is 44550 long.
# t1_juvshape1 <- llply (sample(new_params, 500), do_vd_tradeoff, .progress = 'text')

t1_juvshape1 <- mclapply(new_params[1:5000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape1, file="t1_juvshape1.rdata")
rm(t1_juvshape1)

t1_juvshape2 <- mclapply(new_params[5001:10000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape2, file="t1_juvshape2.rdata")
rm(t1_juvshape2)


t1_juvshape3 <- mclapply(new_params[10001:5000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape3, file="t1_juvshape3.rdata")
rm(t1_juvshape3)

t1_juvshape4 <- mclapply(new_params[5001:15000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape4, file="t1_juvshape4.rdata")
rm(t1_juvshape4)

t1_juvshape5 <- mclapply(new_params[15001:20000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape5, file="t1_juvshape5.rdata")
rm(t1_juvshape5)

t1_juvshape6 <- mclapply(new_params[20001:25000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape6, file="t1_juvshape6.rdata")
rm(t1_juvshape6)

t1_juvshape7 <- mclapply(new_params[25001:30000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape7, file="t1_juvshape7.rdata")
rm(t1_juvshape7)

t1_juvshape8 <- mclapply(new_params[30001:35000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape8, file="t1_juvshape8.rdata")
rm(t1_juvshape8)

t1_juvshape9 <- mclapply(new_params[35001:40000], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape9, file="t1_juvshape9.rdata")
rm(t1_juvshape9)

t1_juvshape10 <- mclapply(new_params[40001:44550], do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape10, file="t1_juvshape10.rdata")
rm(t1_juvshape10)






# #-------------------------------

# test <- suppressMessages(llply(sample(new_params, 1), safe_tradeoff, .progress = 'text'))

# system.time(llply(sample(new_params, 1), safe_tradeoff, .progress = 'text'))

# # tradeoffs with correlation among stages.
# # ```````````````````````````````````````````````````````````````
# corr <- seq(0.1, 0.9, by = 0.1)
# corr_params <- param_combs_corr(a, b, sA, Fec, corr)
# t1_corr <- mclapply(corr_params, do_vd_tradeoff, mc.cores = 72)
# fname4 <- generate_filename("t1_corr")
# save(t1_corr, file=fname4)




