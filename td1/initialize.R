# Initialize basic libraries and functions
rm(list = ls())
message("Loading libraries \n")
library(plyr)
library(varDev2)
suppressPackageStartupMessages(library(lubridate))
library(stringr)
library(multicore)
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(R.utils))
message("Loading functions \n")
source("tfunctions.R")

# # No need to run this re run expensive operation unless necessary
# message("Generating various tradeoff combinations \n")
# # Basic tradeoff, adult survival, and fecundity
# a1 <- seq(0.9, 0.1, by = -0.1)
# b1 <- seq(-0.9, -0.1, by = 0.1)
# a <- 0.9
# b <- -0.8
# sA <- 0.4
# sA2 <- seq(0.1, 0.9, by = 0.1)
# Fec <- 2
# basic_params <- param_combs(a, b, sA, Fec)

# message("\n juvparams")
# # Next, add in a range of cv values
# # cv is defined as sqrt(juvshape)/juvshape

# jps <- function(x) return((1/x)*(1/x))
# jss <- jps(seq(0.1, 1, by = 0.01))
# juvshape <- jss
# vd_params <- param_combs_jg(a, b, sA, Fec, juvshape)


# message("\n Finally, corr_params")
# # Now add in a correlation
# corr <- seq(0.1, 0.9, by = 0.1)
# corr_params <- param_combs_corr(a, b, sA, Fec, juvshape, corr)

# # basic_params = 1215
# # vd_params = 12150
# # corr_params = 48600

# message ("Now saving the params to disk \n")
# save(basic_params, file="basic_params.rda")
# save(vd_params, file="vd_params.rda")
# save(corr_params, file="corr_params.rda")
# paths=('.')
# library(tools)
# checkRdaFiles(paths)
# resaveRdaFiles(paths, compress = "auto")

