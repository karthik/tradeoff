# title: initialize.R 
# author: Karthik Ram 
# Description: This script generates various parameter combinations and writes it to a list
# which allows for easy implementation via plyr functions which can then be scales to a cluster
# using mclapply and specifying a number of cores (greater than 2). This could also be run on a
# local machine but requires more than 2 cores.
# Note: this script is sources for each indivial model rather than being executed directly.

# ---- Initialize basic libraries ----
rm(list = ls())
# setwd('~/Github/postdoc/tradeoff/td1/analysis')
message("Loading libraries \n")
library(plyr)
# varDev2 is the same as varDev except that warnings were implemented as print statements
# which cannot be suppressed. These were re-written as message() statements.
library(varDev2)
# Handles date functions
suppressPackageStartupMessages(library(lubridate))
library(stringr)
library(multicore)
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(R.utils))

# ---- sourcing functions ----
# All functions to run the various cases from a simple matrix implementation all the way to 
 # a full model with both variable development and correlation between stages. 
source("tfunctions.R")

# ---- creating parameter combination functions ----------
# Basic tradeoff, adult survival, and fecundity
a <- seq(0.9, 0.6, by = -0.1)
b <- seq(-0.9, -0.6, by = 0.1)
sA <- seq(0.6, 0.9, by = 0.1)
Fec <- 2
basic_params <- param_combs(a, b, sA, Fec) # list length = 40


# Modeling juvenile survival as a gamma distribution
# Note:  cv is defined as 1/sqrt(juvshape)

jps <- function(x) return((1/x)*(1/x))
juvshape <- jps(seq(0.1, 1, by = 0.1))
vd_params <- param_combs_jg(a, b, sA, Fec, juvshape) # length = 400

# Finally, we add in correlation among stages.

corr <- seq(0.1, 0.9, by = 0.1)
corr_params <- param_combs_corr(a, b, sA, Fec, juvshape, corr)
# list length = 3600
#  >>>> end param generation 

