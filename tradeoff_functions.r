# All functions necessary to calculate tradeoff curves.


# 1. ``````````````````````````````
# setting up a first tradeoff
# Getting Juvenile mortality from maturation rate.
sJ.from.m <- function(m, a, b)  a + b*m

## b should be negative
dem.model <- function(m, sJ, Fec, sA) {
  mat <- matrix(c( (1-m)*sJ, m*sJ, Fec, sA), nrow = 2)
  return (max(eigen(mat)$values))
 }




tradeoff <- function(a, b, sA, Fec, m.grid = NULL) {
  if(is.null(m.grid))
    m.grid <- seq(0.01, .99,length = 20)
    df <- data.frame(id = 1:length(m.grid), m = m.grid)
    df <- ddply(df, .(id),transform, sJ = sJ.from.m(m, a, b))
    df <- ddply(df, .(id), transform, lambda = dem.model(m, sJ, Fec, sA))
    df$type <- "simple"
    return (df)
}


run_vdm <- function(m, sA, sJ, Fec) {
      vdmodel <- VD.model(num.stages = 2,
          marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
          marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")),
          fecundity = Fec)

    VDS <- VD.run(vdmodel)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = Fec)
    r <- VD.solve.euler(mean.fec)
    return(exp(r))
} # end run_vdm

run_vdm_jg <- function(m, sA, sJ, Fec, juvshape) {
    lambdaJ <- -log(1-m) ## prob of not maturing for one time step is exp(-lambdaJ)
    meanjuv <- 1/lambdaJ ## mean of the exponential
    ## we need the scale parameter. mean = shape * scale. sd = sqrt(shape) * scale. see ?dgamma.  so:
    juvscale <- meanjuv / juvshape

          vdmodel <- VD.model(2,
                    marginal.durations = list(VD.dist("gamma", list(shape = juvshape, scale = juvscale)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")), fecundity = Fec)

    VDS <- VD.run(vdmodel)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = Fec)
    r <- VD.solve.euler(mean.fec)
    return(exp(r))
} # end run_vdm_jg


run_vdm_corr <- function(m, sA, sJ, Fec, corr) {
    my.gauss.cov <- matrix(c(1,corr,corr,1), nrow = 2)

    vdmodel <- VD.model(2,
                    marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")), gauss.cov = my.gauss.cov, fecundity = Fec)

    VDS <- VD.run(vdmodel)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = Fec)
    r <- VD.solve.euler(mean.fec)
    return(exp(r))
} # end run_vdm_corr


#  Running the tradeoff, specifying the right params calls the correct function

vd_tradeoff <- function(a, b, sA, m.grid = NULL, corr = NULL, juvshape = NULL) {


  if(is.null(m.grid))
    m.grid <- seq(0.01, .99,length = 20)

   if(!is.numeric(sA))
    stop("Adult mortality not specified...\n")


    assign("Fec", Fec, envir = .GlobalEnv)
   if(!is.numeric(Fec))
      warning("Fecundity not found in global environment...\n")

    df <- data.frame(id = 1:length(m.grid), m = m.grid)
    df <- ddply(df, .(id),transform, sJ = sJ.from.m(m, a, b))

    if(is.null(juvshape) && is.null(corr)) {
      message("running run_vdm()....\n")
      df <- ddply(df, .(id), transform, lambda = run_vdm(m, sA, sJ, Fec))
      df$type <- "juv_tradeoff"
      }

    if(!is.null(juvshape) && is.null(corr)) {
      message("running with run_vdm_jg()....\n")
      df$juvshape <- juvshape
      df <- ddply(df, .(id), transform, lambda = run_vdm_jg(m, sA, sJ, Fec, juvshape))
      df <- df[,-4]
      df$type <- "juvshape"
      }

    if(is.null(juvshape) && !is.null(corr)) {
      message("running with run_vdm_corr()....\n")
      df$corr <- corr
      df <- ddply(df, .(id), transform, lambda = run_vdm_corr(m, sA, sJ, Fec, corr))
      df <- df[,-4]
      df$type <- "corr"
      }

    return (df)
}

# 6. Plotting ```````````````````````
tradeoff.plot <- function(dt, ptitle="") {
  return(ggplot(dt, aes(m, lambda, colour = type)) + geom_point(size = 2) + opts(title = ptitle))
}

# End
