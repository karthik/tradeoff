
rm(list=ls())
library(ggplot2)
library(RColorBrewer)
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../tfunctions.R')


# Next, write a function to read each list item, calcualate the max arg, then get the params and make a data.frame from it. So basically a ldply on a custom function.

simple_max <- ldply(t1_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], type = "simple"))
	}, .progress = 'text')
simple_max$cv <- 1

vd_max <- ldply(t1_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], type = "vd"))
	}, .progress = 'text')
vd_max$cv <- 1


x <- ldply(t1_juvshape1, length)
t1_juvshape <- t1_juvshape1[-which(x$V1==0)]

juvshape_max <- ldply(t1_juvshape, function(x) {
	if(x$data!="TimedOut") {
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = NA,  mstar = amax[[1]], amax_y = amax[[2]], type = "juvshape", cv = cv)) }
	}, .progress = 'text')


corr_max <- ldply(t1_corr, function(x) {
	if(x$data!="TimedOut") {
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = x$params$corr,  mstar = amax[[1]], amax_y = amax[[2]], type = "corr", cv = cv)) }
	}, .progress = 'text')

# all <- rbind(simple_max, vd_max, juvshape_max, corr_max)
all <- rbind(vd_max, juvshape_max, corr_max)
# color_palette <- data.frame(type=c("simple", "vd", "juvshape", "corr"),colors=brewer.pal(4,"Set1"))
# all2 <- merge(all, color_palette)

ggplot(xx1, aes(sA, amax_y, colour=type)) + geom_point() +  scale_fill_brewer(palette='Set1') + scale_colour_brewer("type",palette="Set2") + facet_grid(~Fec)

# ------------------------------------------------------------------
# Fecundity is 2
f2 <- subset(all,all$Fec==2)
f2 <- dlply(f2, .(a,b))
tplot <- function(dat) {
dat$point_size <- dat$corr+2
dat$point_size[is.na(dat$corr)] <- 2
ggplot(dat, aes(cv, mstar, colour = type)) + geom_point(size=3) + facet_grid( ~ sA) + scale_colour_brewer("type",palette="Set2") + xlim(0,1.5)
}

f2_plots <- llply(f2, tplot)



f2_plots[29]
f2_plots[31]
f2_plots[32]

f2_plots[37]
