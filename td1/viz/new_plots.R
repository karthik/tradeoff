
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

load('../results/t1_simple_2012-06-15_12_56_36.358.rdata')
load('../results/t1_vd_2012-06-15_13_05_13.819.rdata')
load('../results/t1_juv_2012-06-15_16_04_55.rdata')
load('../results/t1_corr1_2012-06-15_16_15_50.rdata')

# The collapsed parmas to locate the plots
load("working_simple.rdata")
load("working_vd.rdata")
load('working_corr.rdata')
load('working_js.rdata')
t1_corr <- t1_corr1
split_data <- dlply(cleaned_all, .(a,b,sA))

gen_plot(1)
gen_curve(1)
tplot(o_curves(30))
tplot.cv(j_curves(30))
tplot.cv.corr(c_curves(30))







# ggsave("pdfs/tradeoff_1_full.pdf", arrangeGrob(tplot(o_curves(1)), tplot.cv(j_curves(1)),tplot.cv.corr(c_curves(1))))



