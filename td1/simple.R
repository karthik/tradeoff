# simple.R
source('initialize.R')
source('tfunctions.R')
total_cores <- 30

t1_simple <- mclapply(parameters, do_tradeoff, mc.cores = total_cores)
fname1 <- generate_filename("t1_simple")
save(t1_simple, file=fname1)
