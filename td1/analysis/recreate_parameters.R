# No need to run this re run expensive operation unless necessary
message("Generating various tradeoff combinations \n")
# Basic tradeoff, adult survival, and fecundity
a <- seq(0.9, 0.6, by = -0.1)
b <- seq(-0.9, -0.6, by = 0.1)
sA <- seq(0.6, 0.9, by = 0.1)
Fec <- 2
basic_params <- param_combs(a, b, sA, Fec)
# length basic_params = 40

message("\n juvparams")
# Next, add in a range of cv values
# cv is defined as 1/sqrt(juvshape)

jps <- function(x) return((1/x)*(1/x))
juvshape <- jps(seq(0.1, 1, by = 0.1))
vd_params <- param_combs_jg(a, b, sA, Fec, juvshape)
# length vd_params: 36040

message("\n Finally, corr_params")
# Now add in a correlation
corr <- c(0.1, 0.25, 0.5, 0.75, .99)
corr_params <- param_combs_corr(a, b, sA, Fec, juvshape, corr)
# length corr_params:


# basic_params = 1215, 36855, 90
# vd_params = 12150, 81090, 45050
# corr_params = 48600, 225250, 180200, 216240, 180200. 90200

message ("Now saving the params to disk \n")
save(basic_params, file="basic_params.rda")
save(vd_params, file="vd_params.rda")
save(corr_params, file="corr_params.rda")
paths=('.')
library(tools)
checkRdaFiles(paths)
resaveRdaFiles(paths, compress = "auto")
