# Initialize basic libraries and functions
rm(list = ls())
library(plyr)
library(varDev2)
library(lubridate)
library(stringr)
library(gridExtra)
library(multicore)
library(data.table)
library(R.utils)
source("tfunctions.R")


# Basic tradeoff, adult survival, and fecundity
a <- seq(0.9, 0.1, by = -0.1)
b <- seq(-0.9, -0.1, by = 0.1)
sA <- seq(0.1, 0.9, by = 0.1)
Fec <- 1:10
basic_params <- param_combs(a, b, sA, Fec)

# Next, add in a range of cv values
# cv is defined as sqrt(juvshape)/juvshape
juvshape <- seq(1,50, by = 2)
vd_params <- param_combs_jg(a, b, sA, Fec, juvshape)

# Now add in a correlation
corr <- seq(0.1, 0.9, by = 0.1)
corr_params <- param_combs_corr(a, b, sA, Fec, juvshape, corr)

