# corr.R
unlink('.RData')
source('initialize.R')
load('corr_params.rda')
total_cores <- 12
t1_corr5 <- mclapply(corr_params[40001:50000] , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
save(t1_corr5, file='t1_corr5.rda')


