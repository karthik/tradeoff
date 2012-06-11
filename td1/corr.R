# corr.R
source('initialize.R')
source('tfunctions.R')
load('corr_params.rda')
total_cores <- 84
corr_sample <- sample(corr_params, 8400)
t1_corr <- mclapply(corr_sample, do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname4 <- generate_filename("results/t1_corr")
save(t1_corr, file=fname4)

# 8400 took 56 minutes with this config.
