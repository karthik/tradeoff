# Examples from Perry; 01/26/12
# now we're almost at 02/26/12
library(ggplot2)
library(varDev)
setwd('~/Github/postdoc/lh_tradeoff/')

## Matrix case:
sJ <- 0.8
m <- 0.3
sA <- 0.7
F <- 2
A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2)
max(eigen(A)$values)

## tradeoff:
sJ.from.m <- function(m, a, b) a + b*m ## b should be negative

tradeoff.curve <- function(a, b, m.grid = seq(0.01, 0.99, length = 20)) {
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i]
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)
    A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2) ## F and sA from globals
    lambda[i] <- max(eigen(A)$values)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}

example.tradeoff <- tradeoff.curve(0.9, -0.8)
plot(lambda ~ m, example.tradeoff) ## there is a nice optimum there.


## varDev code:

## Here is the vignette that walks through how to set up a model
 # vignette('varDev')

## Here is the model that should be equivalent to the matrix
VDM <- VD.model(2,
                marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                  VD.dist("geomp1", list(prob = (1-sA)))),
                marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")))


VDS <- VD.run(VDM)

dev.table <- compile.dev.table(VDS)

mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F) ## note for myself: doesn't work to supply F in VD.model and not here.

r <- VD.solve.euler(mean.fec)

## Now let's imitate the fitness surface above:


VD.tradeoff.curve <- function(a, b, m.grid = seq(0.01, 0.99, length = 20)) {
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i]
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)

    VDM <- VD.model(2,
                    marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")))
    VDS <- VD.run(VDM)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F) ## F from global
    r <- VD.solve.euler(mean.fec)
    lambda[i] <- exp(r)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}

VD.example.tradeoff <- VD.tradeoff.curve(0.9, -0.8)
## ignore all the warnings.
plot(lambda ~ m, VD.example.tradeoff) ## there is a nice optimum there.
points(lambda ~ m, example.tradeoff, pch = 'x')
## Good: these match very closely, within simulation error

## Now let's make juvenile development follow a gamma distribution
## This involves some roughnesses due to discretization of continuous rv's.

## Geometric is a discretized exponential.  Exponential has mean = sd.
## Geometric mean != sd due to discretization.

## Gamma generalizes the exponential and has mean = sd * sqrt(shape).
## Exponential case is shape = 1.

## For now I will generalize these by changing the shape parameter and
## keeping the mean at its exponential-equivalent value.  To nail it
## more precisely in the future, we can compute mean and sd of
## discretized gammas and set them as needed. Or, we might decide that
## is not necessary.  Another option, sticking with truly discrete
## distributions, might be to use the negative binomial to generalize
## from the geometric.

VD.tradeoff.curve.juvgamma <- function(a, b, m.grid = seq(0.01, 0.99, length = 20), juvshape) {
  ## Additional argument juvshape is the shape of the gamma for juvenile duration
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i]
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)

    ## exponential equivalent rate:
    lambdaJ <- -log(1-m) ## prob of not maturing for one time step is exp(-lambdaJ)
    meanjuv <- 1/lambdaJ ## mean of the exponential
    ## we need the scale parameter. mean = shape * scale. sd = sqrt(shape) * scale. see ?dgamma.  so:
    juvscale <- meanjuv / juvshape

    VDM <- VD.model(2,
                    marginal.durations = list(VD.dist("gamma", list(shape = juvshape, scale = juvscale)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")))
    VDS <- VD.run(VDM)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F) ## F from global
    r <- VD.solve.euler(mean.fec)
    lambda[i] <- exp(r)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}

## If this is set up correctly, then with juvshape = 1, we should get the same result as above
VD.example.tradeoff.juvgamma <- VD.tradeoff.curve.juvgamma(0.9, -0.8, juvshape = 1)
plot(lambda ~ m, VD.example.tradeoff.juvgamma)
points(lambda ~ m, example.tradeoff, pch = 'x')
## Good, they match.

## Now let's try setting sd = 0.5 * mean for juv duration
VD.example.tradeoff.juvgamma <- VD.tradeoff.curve.juvgamma(0.9, -0.8, juvshape = 1/(0.5^2))
plot(lambda ~ m, example.tradeoff, pch = 'x') ## switched order so both show
points(lambda ~ m, VD.example.tradeoff.juvgamma)
## Off the cuff that looks substantially different (the location of the peak shifted), so it is an interesting result.

## Now let's try including a correlation between juv and adult duration, but keeping the geometric distributions
VD.tradeoff.curve.cor <- function(a, b, m.grid = seq(0.01, 0.99, length = 20), corr) {
  ## The corr parameter is the correlation in the gaussian copula
  ## between juvenile and adult stage duration
  my.gauss.cov <- matrix(c(1,corr,corr,1), nrow = 2)
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i]
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)

    VDM <- VD.model(2,
                    marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")), gauss.cov = my.gauss.cov)
    VDS <- VD.run(VDM)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F) ## F from global
    r <- VD.solve.euler(mean.fec)
    lambda[i] <- exp(r)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}
VD.example.tradeoff.cor <- VD.tradeoff.curve.cor(0.9, -0.8, cor = 0.7)
plot(lambda ~ m, example.tradeoff, pch = 'x') ## switched order so both show
points(lambda ~ m, VD.example.tradeoff.cor)
## Looks like a little bit of a shift, but not as big as for the gamma case above.

## We will need a way to find the arg max (location of the maximum).
## For the simulated models this is a little bit tricky because of
## simulation noise.  I think an easy practical approach would be to
## calculate lambda for a grid of values (as above), then fit a spline
## to those and find the peak of the spline.  Actually I have some
## code to do that for another project that I could dig up if we want
## it.  Another option is to open up the simulation code so we use the
## same underlying random quantiles every time (I can explain that
## more).
