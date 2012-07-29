# simple.R
source('initialize2.R')

total_cores <- 60
t1_simple <- mclapply(basic_params, do_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname1 <- generate_filename("../results_td2/t2_simple")
save(t1_simple, file=fname1)

# llply(sample(basic_params, 1), do_tradeoff)