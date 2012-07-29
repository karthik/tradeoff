# adshape.R
source('initialize2.R')

total_cores <- 60
t1_adshape <- mclapply(vd_params, do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname3 <- generate_filename("results_td2/t2_juv")
save(t1_adshape, file=fname3)

# llply(sample(vd_params,1), do_vd_tradeoff)

