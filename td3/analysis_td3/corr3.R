# corr.R
source('initialize3.R')
load('params/corr_params3.rda')
total_cores <- 60
t1_corr1 <- mclapply(corr_params , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname4 <- generate_filename("../results_td3/t3_corr")
save(t1_corr1, file=fname4)
# x=llply(sample(corr_params, 1), do_vd_tradeoff)