# All functions necessary to calculate tradeoff curves.


# 1. ``````````````````````````````
# setting up a first tradeoff
# Getting Juvenile mortality from maturation rate.
sJ.from.m <- function(m, a, b) a + b*m
## b should be negative



# 2. ``````````````````````````````
# Tradeoff 2:
tradeoff.curve <- function(a, b, m.grid = seq(0.01, 0.99, length = 20)) {
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i] # grab maturation rates on a scale of 0-1
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)
    A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2) ## F and sA from globals
    lambda[i] <- max(eigen(A)$values)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}

# 3. ``````````````````````````````
# tradeoff 3:
VD.tradeoff.curve <- function(a, b, m.grid = seq(0.01, 0.99, length = 20)) {
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i]
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)

    VDM <- suppressWarnings(VD.model(2,
                    marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite"))))
    VDS <- VD.run(VDM)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F) ## F from global
    r <- VD.solve.euler(mean.fec)
    lambda[i] <- exp(r)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}


# 4. ``````````````````````````````
# A tradeoff between Juvenile growth and survival.
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

    VDM <- suppressWarnings(VD.model(2,
                    marginal.durations = list(VD.dist("gamma", list(shape = juvshape, scale = juvscale)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite"))))
    VDS <- VD.run(VDM)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F) ## F from global
    r <- VD.solve.euler(mean.fec)
    lambda[i] <- exp(r)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}


# 5. ``````````````````````````````
## Now let's try including a correlation between juv and adult duration, but keeping the geometric distributions
VD.tradeoff.curve.cor <- function(a, b, m.grid = seq(0.01, 0.99, length = 20), corr) {
  ## The corr parameter is the correlation in the gaussian copula
  ## between juvenile and adult stage duration
  my.gauss.cov <- matrix(c(1,corr,corr,1), nrow = 2)
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i]
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)

    VDM <- suppressWarnings(VD.model(2,
                    marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")), gauss.cov = my.gauss.cov))
    VDS <- VD.run(VDM)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F) ## F from global
    r <- VD.solve.euler(mean.fec)
    lambda[i] <- exp(r)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}


# End
