# fitting a simple spline

a <- 0.9
b <- -0.8
sA <- 0.7
Fec <- 2
parameters <- param_combs(a,b,sA, Fec)
t1_vd <- llply(parameters, do_vd_tradeoff, .progress = "text")
data <- t1_vd[[1]]$data

smoothed <- smooth.spline(data$m,data$lambda,df=10)
plot(lambda ~m, data)
plot(smoothed$y~ smoothed$x)
max(smoothed$y)



?smooth.construct in package mgcv

## We will need a way to find the arg max (location of the maximum).
## For the simulated models this is a little bit tricky because of
## simulation noise.  I think an easy practical approach would be to
## calculate lambda for a grid of values (as above), then fit a spline
## to those and find the peak of the spline.  Actually I have some
## code to do that for another project that I could dig up if we want
## it.  Another option is to open up the simulation code so we use the
## same underlying random quantiles every time (I can explain that
## more).
