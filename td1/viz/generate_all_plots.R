
## @knitr setup
rm(list=ls())
library(ggplot2)
library(gridExtra)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../analysis/tfunctions.R')
source('plot_functions.R')
## @ knitr load_tradeoff_results
load('all_results_new.rda')

load('../results/t1_simple_2012-07-12_14_47_11.085.rdata')
load('../results/t1_vd_2012-07-12_18_11_55.rdata')
load('../results/t1_juv_2012-07-12_18_15_44.rdata')
load('../results/t1_corr1_2012-07-12_18_15_52.rdata')

# The collapsed parameters to locate the plots
load("working_simple.rdata")
load("working_vd.rdata")
load('working_corr.rdata')
load('working_js.rdata')
t1_corr <- t1_corr1
split_data <- dlply(cleaned_all, .(a,b,sA))
# This contains 40 items
# -------------------------------------------


# For item #1 ------------------------------------
# The tradeoff curve
tradeoff_data <- rbind(subset(o_curves(1),type=="vd_tradeoff"), subset(j_curves(1), cv==1.0), subset(c_curves(1),cv==1.0))
xx= subset(tradeoff_data, cv==1.0)
xx$shape=0
xx[which(xx$type=="corr"),]$shape=0
xx[which(xx$type=="juvshape"),]$shape=1
xx[which(xx$type=="vd_tradeoff"),]$shape=2
# The tradeoff intercept and slope
actual_tradeoff <- data.frame(x=c(0,abs(unique(xx$b))), y=c(abs(unique(xx$a)),0))
ggplot(actual_tradeoff, aes(x,y)) + geom_line()
# ------------------------------------------------------
# The tradeoff curve
ggplot(xx[1:60,], aes(m, lambda, colour=type)) + geom_point(size=3.5, shape=1)
# ------------------------------------------------------
temp <- split_data[[1]]
temp$mstar <- as.numeric(temp$mstar)
temp$mstar <- round(temp$mstar, digits = 3)
temp$corr <- as.factor(as.character(temp$corr))
temp[which(is.na(temp$corr)),]$corr <- "No correlation"
temp$corr <- as.ordered(temp$corr)
ggplot(temp, aes(cv, mstar, colour = type)) + geom_point(size=3.2, aes(shape = type)) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set2")
ggsave('pdfs/td30.pdf')
























# old code below, revisit later. #


ggplot(split_data[[31]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td31.pdf')

ggplot(split_data[[32]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td32.pdf')

ggplot(split_data[[33]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td33.pdf')

ggplot(split_data[[34]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td34.pdf')

ggplot(split_data[[35]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td35.pdf')

ggplot(split_data[[36]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td36.pdf')


ggplot(split_data[[37]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td37.pdf')

ggplot(split_data[[38]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td38.pdf')


ggplot(split_data[[39]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td39.pdf')

ggplot(split_data[[40]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td40.pdf')




