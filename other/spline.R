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



