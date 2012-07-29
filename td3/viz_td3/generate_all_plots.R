
rm(list=ls())
library(ggplot2)
library(gridExtra)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../analysis/tfunctions.R')
source('plot_functions.R')

# A collated data.frame with results from simple, vd, juvshape, and corr.
load('all_results_new.rda')
# The collapsed parameters to locate the plots
load("working_simple.rdata")
load("working_vd.rdata")
load('working_corr.rdata')
load('working_js.rdata')

# Raw results
load('../results_td3/t3_vd_2012-07-23_21_57_44.rdata')
load('../results_td3/t3_juv_2012-07-23_22_11_38.rdata')
load('../results_td3/t3_corr_2012-07-23_23_15_08.rdata')

t1_corr <- t1_corr1
rm(t1_corr1)
split_data <- dlply(cleaned_all, .(a,b,sA))
# One tradeoff
# ----------------------------------


vd1 <- subset(o_curves(1),type=="vd_tradeoff")
js1 <- subset(j_curves(1), cv==1.0)
js1 <- js1[1:20,]
co1 <- subset(c_curves(1), cv==1.0)
co1 <- co1[1:20,]
xx <- rbind(vd1, js1, co1)

# Just the tradeoff line
actual_tradeoff <- data.frame(x=c(0,abs(unique(xx$b))), y=c(abs(unique(xx$a)),0))

temp <- split_data[[1]]
temp$mstar <- as.numeric(temp$mstar)
temp$mstar <- round(temp$mstar, digits = 3)
temp$corr <- as.factor(as.character(temp$corr))
temp[which(is.na(temp$corr)),]$corr <- "No correlation"
temp$corr <- as.ordered(temp$corr)
high_correlation <- subset(temp, corr==0.6)
no_correlation <- subset(temp, type!="corr")



plot1 <- ggplot(actual_tradeoff, aes(x,y)) + geom_line(colour="#a1323a", size = 1) + xlab("Maturation Rate") + ylab("Juvenile Survival") + opts(panel.background= theme_blank()) + opts(axis.line=theme_segment())

plot2 <- ggplot(xx, aes(m, lambda, colour=type)) + geom_point(size=3.5, shape=1) + xlab("Juvenile survival") + ylab("Lambda") + opts(panel.background= theme_blank()) + opts(axis.line=theme_segment())
	

plot3 <- ggplot(high_correlation, aes(cv,mstar)) + geom_point(size=3.2, aes(shape = type)) + opts(panel.background= theme_blank()) + opts(axis.line=theme_segment())
	

plot4 <- ggplot(no_correlation, aes(cv,mstar,colour = type)) + geom_point(size=3.2, aes(shape = type)) + opts(panel.background= theme_blank()) + opts(axis.line=theme_segment())
	
plot1
ggsave(file="~/Desktop/plot1.eps")
plot2
ggsave(file="~/Desktop/plot2.eps")
plot3
ggsave(file="~/Desktop/plot3.eps")
plot4
ggsave(file="~/Desktop/plot4.eps")


























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




