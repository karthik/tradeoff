# juvshape.R
source('initialize3.R')
total_cores <- 60
t1_juvshape <- mclapply(vd_params, do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname3 <- generate_filename("../results_td3/t3_juv")
save(t1_juvshape, file=fname3)
 
# x= llply(sample(vd_params, 1), do_vd_tradeoff)