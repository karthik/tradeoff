# simple.R
source('initialize3.R')
num.cores <- 48
t1_simple <- mclapply(basic_params, do_tradeoff, mc.cores= num.cores, mc.preschedule=TRUE)
fname1 <- generate_filename("../results_td3/t1_simple")
save(t1_simple, file=fname1)
