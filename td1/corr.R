# corr.R
source('initialize.R')
source('tfunctions.R')
total_cores <- 60

t1_corr <- mclapply(corr_params, do_vd_tradeoff, mc.cores = total_cores)
fname4 <- generate_filename("t1_corr")
save(t1_corr, file=fname4)
