# corr.R
unlink('.RData')
source('initialize.R')
load('corr_params.rda')
total_cores <- 12
t1_corr8 <- mclapply(corr_params[70001:80000] , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
save(t1_corr8, file='t1_corr8.rda')

