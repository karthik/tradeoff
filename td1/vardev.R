# vardev.R
source('initialize.R')
source('tfunctions.R')
total_cores <- 60

t1_vd <- mclapply(parameters, do_vd_tradeoff, mc.cores = total_cores)
fname2 <- generate_filename("t1_vd")
save(t1_vd, file=fname2)
