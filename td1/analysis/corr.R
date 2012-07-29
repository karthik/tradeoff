# corr.R
source('initialize.R')
total_cores <- 96
t1_corr <- mclapply(corr_params , do_vd_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
fname4 <- generate_filename("../results/t1_corr")
save(t1_corr, file=fname4)

# with 60 cores
# 3600 corr params took 5.37 minutes on the cluster.
#      user    system   elapsed 
# 54660.235   322.604  1543.220 