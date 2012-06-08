rm(list=ls())
setwd('~/Github/postdoc/tradeoff/tradeoff1')
source('tradeoff_functions.R')

# background #f8f6f7
# red #fc2a45
# light blue #75c5ce a darker version for maybe VD: #4887a6
# third color for correlation: #f0c74b
# for the lines:

# Read the .rdata files first.
load('results/t1_simple_2012-06-05_23_14_53.rdata')
load('results/t1_vd_2012-06-05_23_19_39.rdata')
load('results/t1_juvshape_2012-06-05_23_51_59.rdata')
load('results/t1_corr_2012-06-06_00_44_44.rdata')


# Next, write a function to read each list item, calcualate the max arg, then get the params and make a data.frame from it. So basically a ldply on a custom function.

simple_max <- ldply(t1_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], type = "simple"))
	}, .progress = 'text')


vd_max <- ldply(t1_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], type = "vd"))
	}, .progress = 'text')


juvshape_max <- ldply(t1_juvshape, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = NA,  mstar = amax[[1]], amax_y = amax[[2]], type = "juvshape"))
	}, .progress = 'text')


corr_max <- ldply(t1_corr, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = x$params$corr,  mstar = amax[[1]], amax_y = amax[[2]], type = "corr"))
	}, .progress = 'text')

# all <- rbind(simple_max, vd_max, juvshape_max, corr_max)
all <- rbind(vd_max, juvshape_max)
all$slope <- abs(all$b)/all$a
all$cv = sqrt(all$juvshape)/(all$juvshape)
all$cv[all$type=="vd"] = 1



ggplot(all, aes(cv, mstar, colour = type)) + geom_point(shape = 16) + facet_grid(Fec ~ sA)


ggplot(subset(all, Fec==4), aes(cv, mstar, colour = type)) + geom_point(shape = 16) + facet_grid(~, sA)

ggplot(subset(all, Fec==6), aes(cv, mstar, colour = type)) + geom_point(shape = 16) + facet_grid(~, sA)

ggplot(subset(all, Fec==8), aes(cv, mstar, colour = type)) + geom_point(shape = 16) + facet_grid(~, sA)

ggplot(subset(all, Fec==10), aes(cv, mstar, colour = type)) + geom_point(shape = 16) + facet_grid(~, sA)



