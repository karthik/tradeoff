
# ---------------------------------------------------

sJ.from.m <- function(m, a, b) {
  return(a + b*m)
  }

# ---------------------------------------------------

dem.model <- function(m, sJ, Fec, sA) {
  mat <- matrix(c((1-m)*sJ, m*sJ, Fec, sA), nrow = 2)
  return (max(eigen(mat)$values))
 }

 # ---------------------------------------------------

tradeoff <- function(a,b, Fec, sA, m = NULL) {
	if(is.null(m))
		m <- seq(0.01, 0.99, length = 20)

	sJ <- sJ.from.m(m,a,b)
	df <- as.matrix(data.frame(m = m, sJ = sJ))
 	lambda <- apply(df, 1, function(x) dem.model(x[1],x[2], Fec, sA))
  type="simple"
	return((data.frame(m,sJ,lambda,type)))
}


# ---------------------------------------------------

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
# ---------------------------------------------------
vd_tradeoff <- function(a, b, sA, Fec, m = NULL, corr = NULL, juvshape = NULL) {
  if(is.null(m))
    m <- seq(0.01, .99,length = 20)

   if(!is.numeric(sA))
    stop("Adult mortality not specified...\n")

	sJ <- sJ.from.m(m,a,b)
	df <- as.matrix(data.frame(m = m, sJ = sJ))

    if(is.null(juvshape) && is.null(corr)) {
      message("running run_vdm()....\n")
      lambda <- apply(df, 1, function(x) run_vdm(x[1],x[2], sA, Fec))
      df<- data.frame(m,sJ,lambda)
      df$type <- "juv_tradeoff"
      }

    if(!is.null(juvshape) && is.null(corr)) {
      message("running with run_vdm_jg()....\n")
      lambda <- apply(df, 1, function(x) run_vdm_jg(x[1],x[2], sA, Fec, juvshape))
      df <- data.frame(m,sJ,lambda)
      df$type <- "juvshape"
      }

    if(is.null(juvshape) && !is.null(corr)) {
      message("running with run_vdm_corr()....\n")
      lambda <- apply(df, 1, function(x) run_vdm_corr(x[1],x[2], sA,Fec, corr))
      df <- data.frame(m,sJ,lambda)
      df$type <- "corr"
      }

    return(df)
}

# =------------------------------------------

param_combs <- function(a, b, sA, Fec) {
  parameters  <- expand.grid(a,b,sA,Fec)
  parameters$sim_id <- paste0("S",1:dim(parameters)[1])
  params <- mapply(list, a=parameters[,1],b=parameters[,2],sA=parameters[,3],Fec=parameters[,4], sim_id = parameters[,5], SIMPLIFY=F)
  return(params)
}

param_combs_jg <- function(a, b, sA, Fec, juvshape) {
  parameters  <- expand.grid(a,b,sA,Fec, juvshape)
  parameters$sim_id <- paste0("JG",1:dim(parameters)[1])
  params <- mapply(list, a=parameters[,1],b=parameters[,2],sA=parameters[,3],Fec=parameters[,4], juvshape = parameters[,5], sim_id = parameters[,6], SIMPLIFY=F)
  return(params)
}

param_combs_corr <- function(a, b, sA, Fec, corr) {
  parameters  <- expand.grid(a,b,sA,Fec,corr)
  parameters$sim_id <- paste0("CO",1:dim(parameters)[1])
  params <- mapply(list, a=parameters[,1],b=parameters[,2],sA=parameters[,3],Fec=parameters[,4], corr = parameters[,5],  sim_id = parameters[,6], SIMPLIFY=F)
  return(params)
}


# =------------------------------------------
tradeoff.plot <- function(dt, ptitle="") {
  data <- dt[[1]]
  params <- dt[2]
  return(ggplot(data, aes(m, lambda, colour = type)) + geom_point(size = 3.5,shape = 16) + opts(title = ptitle))
}


# =------------------------------------------

do_tradeoff <- function(tlist) {
  toff <- tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, m = NULL)
  # This keeps all the parameters for each run in the same unit.
  basic_result <- list(data=toff,params=tlist)
  return(basic_result)
}

# =------------------------------------------

do_vd_tradeoff <- function(tlist) {
  # if others are specified, do those functions.
  # This needs error handling for failed calls for any below. Use try and tryCatch()

  if(len(tlist)==5)
    vd_toff <- vd_tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, m = NULL)

  if(len(tlist)==6 && names(tlist)[5]=="juvshape")
    vd_toff <- vd_tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, juvshape = tlist$juvshape, m = NULL)

  if(len(tlist)==6 && names(tlist)[5]=="corr")
    vd_toff <- vd_tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, tlist$corr, m = NULL)
  # This keeps all the parameters for each run in the same unit.
  vd_result <- list(data=vd_toff,params=tlist)
  return(vd_result)
}
