source('initialize.R')
source('tfunctions.R')
load('basic_params.rda')
load('vd_params.rda')
load('corr_params.rda')


t1_simple <- llply(basic_params, do_tradeoff, .progress = 'text')
t1_vd <- llply(basic_params, do_vd_tradeoff, .progress = 'text')
t1_juvshape <- llply(vd_params, do_vd_tradeoff, .progress = 'text')
t1_corr <- llply(corr_params, do_vd_tradeoff, .progress = 'text')

save(t1_simple, file = "small_t1_simple.rda")
save(t1_vd, file =  "small_t1_vd.rda")
save(t1_juvshape, file =  "small_t1_juvshape.rda")
save(t1_corr, file =  "small_t1_corr.rda")

# --- Now pull out the responses from the model -------- #

simple_max <- ldply(t1_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], type = "simple"))
	}, .progress = 'text')
simple_max$cv <- 1

# --- VD -------- #

vd_max <- ldply(t1_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], type = "vd"))
	}, .progress = 'text')
vd_max$cv <- 1

# --- Juvshape, scaling cv from 0 -1  -------- #

juvshape_max <- ldply(t1_juvshape, function(x) {
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = NA,  mstar = amax[[1]], amax_y = amax[[2]], type = "juvshape", cv = cv))
	}, .progress = 'text')

# --- Now adding correlation as a compelxity to this. -------- #

corr_max <- ldply(t1_corr, function(x) {
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = x$params$corr,  mstar = amax[[1]], amax_y = amax[[2]], type = "corr", cv = cv))
	}, .progress = 'text')

# --- Now combining everything for the visualization  -------- #
all <- rbind(simple_max, vd_max, juvshape_max, corr_max)


ggplot(all, aes(cv, mstar, colour = type)) + geom_point(size= 5, shape=16, alpha=1/5) + scale_colour_brewer("type",palette="Set2")



