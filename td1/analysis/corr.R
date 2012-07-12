# corr.R
source('initialize.R')
load('corr_params.rda')
total_cores <- 60
t1_corr1 <- mclapply(corr_params , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname4 <- generate_filename("results/t1_corr1")
save(t1_corr1, file=fname4)

# 8400 took 56 minutes with this config.
