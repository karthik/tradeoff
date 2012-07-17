
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

# The collapsed parmas to locate the plots
load("working_simple.rdata")
load("working_vd.rdata")
load('working_corr.rdata')
load('working_js.rdata')
t1_corr <- t1_corr1
split_data <- dlply(cleaned_all, .(a,b,sA))

temp <- split_data[[30]]
temp$mstar <- as.numeric(temp$mstar)
temp$mstar <- round(temp$mstar, digits = 3)
ggplot(temp, aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set2")
ggsave('pdfs/td30.pdf')

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




