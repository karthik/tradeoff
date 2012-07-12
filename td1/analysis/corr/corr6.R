# corr.R
unlink('.RData')
source('initialize.R')
load('corr_params.rda')
total_cores <- 12
t1_corr6 <- mclapply(corr_params[50001:60000] , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
save(t1_corr6, file='t1_corr6.rda')

