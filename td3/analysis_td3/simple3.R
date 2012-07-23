# simple.R
source('initialize3.R')
load('basic_params3.rda')

t1_simple <- llply(basic_params, do_tradeoff, .progress = 'text')
fname1 <- generate_filename("../results_td3/t1_simple")
save(t1_simple, file=fname1)
