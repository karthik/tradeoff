% Life-history tradeoff example runs
% Karthik Ram
% `Wed May 23 12:18:20 2012`

<!-- Setting up R -->







```r
rm(list = ls())
library(ggplot2)
library(plyr)
library(varDev2)
library(lubridate)
library(gridExtra)
library(multicore)
library(data.table)
source("tradeoff_functions.R")
```






```r
# Set up parameters
a <- c(0.9, 0.8, 0.6)
b <- c(-0.8, -0.7, -0.6)
sA <- seq(0.3, 0.9, by = 0.1)
Fec <- c(2, 4, 8, 10)
parameters <- param_combs(a, b, sA, Fec)
```






```r
# # run tradeoffs
t1_simple <- mclapply(parameters, do_tradeoff, mc.cores = 72)
save(t1_simple, file = "t1_simple.rdata")
t1_vd <- mclapply(parameters, do_vd_tradeoff, mc.cores = 72)
save(t1_vd, file = "t1_vd.rdata")
```






```r
# # tradeoffs with variable development
juvshape <- c(1, 0.5)
new_params <- param_combs_jg(a, b, sA, Fec, juvshape)
t1_juvshape <- mclapply(new_params, do_vd_tradeoff, mc.cores = 72)
save(t1_juvshape, file = "t1_juvshape.rdata")
```






```r
# tradeoffs with correlation among stages.
corr <- seq(0.3, 0.4, 0.5)
corr_params <- param_combs_corr(a, b, sA, Fec, corr)
t1_corr <- mclapply(corr_params, do_vd_tradeoff, mc.cores = 72)
save(t1_corr, file = "t1_corr.rdata")
```




