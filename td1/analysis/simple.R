# simple.R
source('initialize.R')
load('basic_params.rda')

t1_simple <- llply(basic_params, do_tradeoff, .progress = 'text')
# llply(sample(basic_params,1), do_tradeoff, .progress = 'text')
fname1 <- generate_filename("../results/t1_simple")
save(t1_simple, file=fname1)
