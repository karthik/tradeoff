setwd('~/Github/postdoc/tradeoff/td1/analysis')
source('initialize.R')
source('tfunctions.R')
library(data.table)

a <- .9
b <- -0.8
sA <- 0.8
Fec <- 2
basic_params <- param_combs(a, b, sA, Fec)
# length basic_params = 40

message("\n juvparams")
# Next, add in a range of cv values
# cv is defined as 1/sqrt(juvshape)

jps <- function(x) return((1/x)*(1/x))
juvshape <- jps(seq(0.1, 1, by = 0.1))
vd_params <- param_combs_jg(a, b, sA, Fec, juvshape)

# message("\n Finally, corr_params")
# # Now add in a correlation
# corr <- c(0.1, 0.25, 0.5, 0.75, .99)
# corr_params <- param_combs_corr(a, b, sA, Fec, juvshape, corr)
# # length corr_params:


t2_simple <- llply(basic_params, do_tradeoff, .progress = 'text')
t2_vd <- llply(basic_params, do_vd_tradeoff, .progress = 'text')
t2_juvshape <- llply(vd_params, do_vd_tradeoff, .progress = 'text')
# t2_corr <- llply(corr_params, do_vd_tradeoff, .progress = 'text')

save(t2_simple, file = "small_t2_simple.rda")
save(t2_vd, file =  "small_t2_vd.rda")
save(t2_juvshape, file =  "small_t2_juvshape.rda")
# save(t1_corr, file =  "small_t1_corr.rda")

# load('small_t1_juvshape.rda')
# load('small_t1_simple.rda')
# load('small_t1_vd.rda')
# load('small_t1_corr.rda')
# --- Now pull out the responses from the results -------- #

simple_max <- ldply(t1_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim = x$params$sim_id, type = "simple"))
	}, .progress = 'text')
simple_max$cv <- 1

# --- VD -------- #

vd_max <- ldply(t1_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim = x$params$sim_id, type = "vd"))
	}, .progress = 'text')
vd_max$cv <- 1

# --- Juvshape, scaling cv from 0 -1  -------- #

juvshape_max <- ldply(t1_juvshape, function(x) {
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = NA,  mstar = amax[[1]], amax_y = amax[[2]], sim = x$params$sim_id, type = "juvshape", cv = cv))
	}, .progress = 'text')

# --- Now adding correlation as a compelxity to this. -------- #
t1_corr <- t1_corr[-188]

corr_max <- ldply(t1_corr, function(x) {
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = x$params$corr,  mstar = amax[[1]], amax_y = amax[[2]], sim = x$params$sim_id, type = "corr", cv = cv))
	}, .progress = 'text')

# --- Now combining everything for the visualization  -------- #
all <- rbind(simple_max, vd_max, juvshape_max)

ggplot(all, aes(cv, mstar, colour = type)) + geom_point(size= 5, shape=16, alpha=0.5) + scale_colour_brewer("type",palette="Set2")
