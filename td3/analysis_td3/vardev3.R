# vardev.R
source('initialize3.R')
load('basic_params3.rda')

t1_vd <- mclapply(basic_params, do_vd_tradeoff, mc.cores=12, mc.preschedule=TRUE)
fname2 <- generate_filename("results_td3/t3_vd")
save(t1_vd, file=fname2)

