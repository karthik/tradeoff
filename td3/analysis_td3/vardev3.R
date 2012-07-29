# vardev.R
source('initialize3.R')
num.cores <- 48
t1_vd <- mclapply(basic_params, do_vd_tradeoff, mc.cores= num.cores, mc.preschedule=TRUE)
fname2 <- generate_filename("../results_td3/t3_vd")
save(t1_vd, file=fname2)

# x=llply(sample(basic_params, 1), do_vd_tradeoff)