# simple.R
source('initialize2.R')
load('basic_params2.rda')

t1_simple <- llply(basic_params, do_tradeoff, .progress = 'text')
llply(sample(basic_params, 1), do_tradeoff, .progress = 'text')

fname1 <- generate_filename("../results_td2/t2_simple")
save(t1_simple, file=fname1)
