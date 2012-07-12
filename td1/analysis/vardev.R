# vardev.R
source('initialize.R')
load('basic_params.rda')

t1_vd <- llply(basic_params, do_vd_tradeoff, .progress = 'text')
fname2 <- generate_filename("../results/t1_vd")
save(t1_vd, file=fname2)

