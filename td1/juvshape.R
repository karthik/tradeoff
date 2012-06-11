# juvshape.R
source('initialize.R')
source('tfunctions.R')
load('vd_params.rda')
total_cores <- 72
vd_sample <- sample(vd_params, 7200)
t1_juvshape1 <- mclapply(vd_sample, do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname3 <- generate_filename("results/t1_juv")
save(t1_juvshape1, file=fname3)

# 7200 too 1 hour and 5 minutes.

