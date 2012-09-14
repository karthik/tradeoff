# Initialize basic libraries and functions
rm(list = ls())
# setwd('~/Github/postdoc/tradeoff/td2/analysis_td2')
message("Loading libraries \n")
library(plyr)
library(varDev2)
suppressPackageStartupMessages(library(lubridate))
library(stringr)
library(multicore)
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(R.utils))
message("Loading functions \n")
source("tfunctions2.R")

# No need to run this re run expensive operation unless necessary
message("Generating various tradeoff combinations \n")
# Basic tradeoff, adult survival, and fecundity
a <- seq(0.9, 0.6, by = -0.1)
b <- seq(-0.9, -0.6, by = 0.1)
sJ <- seq(0.3, 0.9, by = 0.1)
m <-  seq(.2,.8,by=.2) # fix juvenile maturation rate at some constant.
basic_params <- param_combs(a, b, sJ, m)
# length basic_params = 112

message("\n adult survival")
# Next, add in a range of cv values
# cv is defined as 1/sqrt(adshape)

ads <- function(x) return((1/x)*(1/x))
adshape <- ads(seq(0.1, 1, by = 0.1))
vd_params <- param_combs_jg(a, b, sJ, m, adshape)
# length vd_params: 1120

message("\n Finally, corr_params")
# Now add in a correlation
# corr <- c(0.1, 0.25, 0.5, 0.75, .99)
corr <- seq(0.1, 0.9, by = 0.1)
corr_params <- param_combs_corr(a, b, sJ, m, adshape, corr)
# 10080
