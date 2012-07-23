# juvshape.R
source('initialize3.R')
load('vd_params3.rda')
total_cores <- 60
t1_juvshape <- mclapply(vd_params, do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname3 <- generate_filename("results_td3/t3_juv")
save(t1_juvshape, file=fname3)

# 7200 too 1 hour and 5 minutes.

