# corr.R
unlink('.RData')
source('initialize.R')
load('corr_params.rda')
total_cores <- 12
t1_corr9 <- mclapply(corr_params[80001:90200] , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
save(t1_corr9, file= 't1_corr9.rda')

