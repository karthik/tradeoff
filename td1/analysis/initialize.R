

# ---- Initialize basic libraries ----
rm(list = ls())
# setwd('~/Github/postdoc/tradeoff/td1/analysis')
message("Loading libraries \n")
library(plyr)
library(varDev2)
suppressPackageStartupMessages(library(lubridate))
library(stringr)
library(multicore)
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(R.utils))

# ---- sourcing functions ----

source("tfunctions.R")

# ---- creating parameter combination functions ----------
#---------------------------------------------------------
# Basic tradeoff, adult survival, and fecundity
a <- seq(0.9, 0.6, by = -0.1)
b <- seq(-0.9, -0.6, by = 0.1)
sA <- seq(0.6, 0.9, by = 0.1)
Fec <- 2
basic_params <- param_combs(a, b, sA, Fec) # length = 40
#---------------------------------------------------------

# Modeling juvenile survival as a gamma distribution
# ------------------------------------------------------------
# cv is defined as 1/sqrt(juvshape)
jps <- function(x) return((1/x)*(1/x))
juvshape <- jps(seq(0.1, 1, by = 0.1))
vd_params <- param_combs_jg(a, b, sA, Fec, juvshape) # length = 400

# Adding in correlation among stages.
# ------------------------------------------------------------
corr <- seq(0.1, 0.9, by = 0.1)
corr_params <- param_combs_corr(a, b, sA, Fec, juvshape, corr)
# length = 3600
# ---- end param generation ----------------------------------
