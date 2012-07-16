# All functions necessary to calculate tradeoff curves.
# TOC

# 1. sJ.from.m - Generates juvenile mortality form maturation
# 2. dem.model - contstructs the matrix model needed to run
# 3. tradeoff - generates simple tradeoff curves for the matrix case.
# 4. vd_tradeoff - a wrapper for the 3 functions above.
#   4a.. run_vdm -
#   4b. run_vdm_corr -
#   4c. run_vdm_jg -
# 5. Tradeoff between fecundity and adult survival.
#   5a.
#   5b.
#   5c.
# 9. Tradeoff between fecundity and juveline survival.
#   9a.
#   9b.
#   9c.

# That's the basic framework. After that, I'll just be setting various tradeoff within this framework of functions.

# -----------------------------------------
# setting up a first tradeoff
# Getting Juvenile mortality from maturation rate.

#' sJ.from.m
#'
#' Generates the _____ matrix
#' @param m maturation rate
#' @param a I should know what this means
#' @param b I should know what this means
#' @export
#' @keywords
#' @seealso
#' @return
#' @alias
#' @examples \dontrun{
#' foo <- sJ.from.m(m, a, b)
#'}
sJ.from.m <- function(m, a, b) {
  return(a + b*m)
  }

sA.from.F <- function() {

}

m.from.F <- function() {

}

#'dem.model
#'
#'<full description>
#' @param m <what param does>
#' @param  sJ <what param does>
#' @param  Fec <what param does>
#' @param  sA <what param does>
#' @export
#' @keywords
#' @seealso
#' @return
#' @alias
#' @examples \dontrun{
#'
#'}
dem.model <- function(m, sJ, Fec, sA) {
  mat <- matrix(c((1-m)*sJ, m*sJ, Fec, sA), nrow = 2)
  return (max(eigen(mat)$values))
 }

# -------------------------------------------------

#' tradeoff - function
#'
#'calculates tradeoff under the simple matrix condition
#' @param a
#' @param  b
#' @param  sA Adult mortality
#' @param  Fec Fecundity
#' @param  m.grid = NULL The grid of maturation rates.
#' @export
#' @seealso
#' @return
#' @examples \dontrun{
#' result <- tradeoff(0.9, -0.8)
#' tradeoff.plot(result)
#'}
tradeoff <- function(a, b, sA, Fec = NULL, m.grid = NULL) {
browser()

  if(is.null(m.grid))
    m.grid <- seq(0.01, .99,length = 20)

    df <- data.frame(id = 1:length(m.grid), m = m.grid)
    browser()
    df <- ddply(df, .(id),transform, sJ = sJ.from.m(m, a, b))
    df <- ddply(df, .(id), transform, lambda = dem.model(m, sJ, Fec, sA))
    df$type <- "simple"
    return(df)
}

# -----------------------------------------
run_vdm <- function(m, sJ, sA, Fec) {
      vdmodel <- suppressMessages(VD.model(num.stages = 2,
          marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
          marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")),
          fecundity = Fec))

    VDS <- VD.run(vdmodel)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = Fec)
    r <- VD.solve.euler(mean.fec)
    return(exp(r))
} # end run_vdm


# -----------------------------------------
run_vdm_jg <- function(m, sA, sJ, Fec, juvshape) {
    lambdaJ <- -log(1-m) ## prob of not maturing for one time step is exp(-lambdaJ)
    meanjuv <- 1/lambdaJ ## mean of the exponential
    # we need the scale parameter. mean = shape * scale. sd = sqrt(shape) * scale. see ?dgamma.  so:
    juvscale <- meanjuv / juvshape

          vdmodel <- suppressMessages(VD.model(2,
                    marginal.durations = list(VD.dist("gamma", list(shape = juvshape, scale = juvscale)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")),
                  fecundity = Fec))

    VDS <- VD.run(vdmodel)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = Fec)
    r <- VD.solve.euler(mean.fec)
    return(exp(r))
} # end run_vdm_jg



# -----------------------------------------
run_vdm_corr <- function(m, sA, sJ, Fec, corr) {
    my.gauss.cov <- matrix(c(1,corr,corr,1), nrow = 2)

    vdmodel <- suppressMessages(VD.model(2,
                    marginal.durations = list(VD.dist("geomp1", list(prob = m)),
                      VD.dist("geomp1", list(prob = (1-sA)))),
                    marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),
                  VD.dist("infinite")), gauss.cov = my.gauss.cov,
                  fecundity = Fec))

    VDS <- VD.run(vdmodel)
    dev.table <- compile.dev.table(VDS)
    mean.fec <- calc.average.surv.rep.by.age(dev.table, F = Fec)
    r <- VD.solve.euler(mean.fec)
    return(exp(r))
} # end run_vdm_corr

# -----------------------------------------
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

    return(df)
}


# 6. Plotting ```````````````````````
# I need to create my ggplot theme since this wont work elsewhere.
tradeoff.plot <- function(dt, ptitle="") {
  return(ggplot(dt, aes(m, lambda, colour = type)) + geom_point(size = 4,shape = 3) + opts(title = ptitle))
}

# End
