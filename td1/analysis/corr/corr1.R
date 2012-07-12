# corr.R
unlink('.RData')
source('initialize.R')
load('corr_params.rda')
total_cores <- 12
t1_corr1 <- mclapply(corr_params[1:10000] , do_vd_tradeoff, mc.cores = total_cores)
save(t1_corr1, file="t1_corr1.rda")

