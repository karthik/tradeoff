# vardev.R
source('initialize.R')
source('tfunctions.R')
load('basic_params.rda')
total_cores <- 72
# takes about 18 minutes

t1_vd <- mclapply(basic_params, do_vd_tradeoff, mc.cores = total_cores)
fname2 <- generate_filename("results/t1_vd")
save(t1_vd, file=fname2)
