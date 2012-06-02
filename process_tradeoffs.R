rm(list=ls())
setwd('~/Github/postdoc/tradeoff/')
source('tradeoff_functions.R')


# Read the .rdata files first.
load('wedmay30_results/t1_simple.rdata')
load('wedmay30_results/t1_vd.rdata')
load('wedmay30_results/t1_juvshape.rdata')
load('wedmay30_results/t1_corr.rdata')


# Next, write a function to read each list item, calcualate the max arg, then get the params and make a data.frame from it. So basically a ldply on a custom function.

simple_max <- ldply(t1_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, m =amax[[1]], amax_y = amax[[2]], type = "simple"))
	}, .progress = 'text')


vd_max <- ldply(t1_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, m =amax[[1]], amax_y = amax[[2]], type = "vd"))
	}, .progress = 'text')


juvshape_max <- ldply(t1_juvshape, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = NA,  m =amax[[1]], amax_y = amax[[2]], type = "juvshape"))
	}, .progress = 'text')


corr_max <- ldply(t1_corr, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = x$params$corr,  m =amax[[1]], amax_y = amax[[2]], type = "corr"))
	}, .progress = 'text')

all <- rbind(vd_max, juvshape_max, corr_max)
all$slope <- abs(all$b)/all$a

all[all$slope==1.00,]$strength="1"
all[all$slope==0.89,]$strength="2"
all[all$slope==0.87,]$strength="3"
all[all$slope==0.78,]$strength="4"
all[all$slope==0.75,]$strength="5"
# Splitting by adult survival
# -------------------------------
plot_panels <- function(all) {
	tt <- sprintf("strength %s", unique(all$strength))
	return(ggplot(all, aes(m, amax_y, colour=type)) + geom_point(size=3) + facet_wrap(~ sA, scales = "free")) + opts(title=tt)
}


plots <- dlply(all, .(strength), plot_panels)


