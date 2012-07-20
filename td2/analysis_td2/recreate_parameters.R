# No need to run this re run expensive operation unless necessary
message("Generating various tradeoff combinations \n")
# Basic tradeoff, adult survival, and fecundity
a <-  seq(12, 6, by = -1)
b <-  seq(6, 12, by = 1)
b <- -1*b
sJ <- seq(0.4, 0.9, by = 0.1)
m <-  0.3 # fix juvenile maturation rate at some constant.
basic_params <- param_combs(a, b, sJ, m)
# length basic_params = 40

message("\n juvparams")
# Next, add in a range of cv values
# cv is defined as 1/sqrt(adshape)

ads <- function(x) return((1/x)*(1/x))
adshape <- ads(seq(0.1, 1, by = 0.1))
vd_params <- param_combs_jg(a, b, sJ, m, adshape)
# length vd_params: 36040

message("\n Finally, corr_params")
# Now add in a correlation
# corr <- c(0.1, 0.25, 0.5, 0.75, .99)
corr <- seq(0.1, 0.9, by = 0.1)
corr_params <- param_combs_corr(a, b, sJ, m, adshape, corr)

# Resulting combinations =  40, 400, 5760

message ("Now saving the params to disk \n")
save(basic_params, file="basic_params.rda")
save(vd_params, file="vd_params.rda")
save(corr_params, file="corr_params.rda")
paths=('.')
library(tools)
checkRdaFiles(paths)
resaveRdaFiles(paths, compress = "auto")
