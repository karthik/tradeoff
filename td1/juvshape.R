# juvshape.R
source('initialize.R')
source('tfunctions.R')
total_cores <- 60

t1_juvshape1 <- mclapply(new_params, do_vd_tradeoff, mc.cores = total_cores)
fname3 <- generate_filename("t1_juv")
save(t1_juvshape1, file=fname3)
