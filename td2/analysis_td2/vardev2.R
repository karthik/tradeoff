# vardev.R
source('initialize2.R')
load('basic_params2.rda')

t1_vd <- mclapply(basic_params, do_vd_tradeoff, mc.cores=12, mc.preschedule=TRUE)
fname2 <- generate_filename("results_td2/t2_vd")
save(t1_vd, file=fname2)

