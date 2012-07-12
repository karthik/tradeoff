# corr.R
unlink('.RData')
source('initialize.R')
load('corr_params.rda')
total_cores <- 12
t1_corr4 <- mclapply(corr_params[30001:40000] , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
save(t1_corr4, file='t1_corr4.rda')

