# Tradeoff Functions
# TOC
# Setting up tradeoffs
#     sJ.from.m
#     sA.from.Fec
#     Fec.from.m
# dem.model (basic martix version)
# tradeoff (calculates basic tradeoff)
# vd_tradeoff (calculates tradeoff using varDev)
#     run_vdm
#     run_vdm_jg
#     run_vdm_corr

# param_combs (generates parameter combinations)
# param_combs_jg (same as above with juvenile growth)
# param_combs_corr (same as above with corrleation between stages)

# tradeoff_plot
# do_tradeoff (wrapper for tradeoff)
# do_vd_tradeoff (wrapper for do_tradeoff)
# ````````````````````````````````````````````


# ---------------------------------------------------

sJ.from.m <- function(m, a, b) {
  return(a + b*m)
  }

sA.from.Fec <- function(sA, a, b) {
  return(a + b*sA)
  }

 Fec.from.m <- function(m, a, b) {
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
vd_tradeoff <- function(a, b, sA, Fec, m = NULL, corr = NULL, juvshape = NULL, version="t1") {
  if(is.null(m))
    m <- seq(0.01, .99,length = 20)

   if(!is.numeric(sA))
    stop("Adult mortality not specified...\n")

    if(version=="t1")
  	 sJ <- sJ.from.m(m,a,b)


    if(is.null(juvshape) && is.null(corr)) {
      message("running run_vdm()....\n")
      df <- as.matrix(data.frame(m = m, sJ = sJ, sA=sA, Fec=Fec))
      lambda <- apply(df, 1, function(x) run_vdm(x[1],x[2], x[3], x[4]))
      df<- data.frame(m,sJ,lambda)
      df$type <- "juv_tradeoff"
      }

    if(!is.null(juvshape) && is.null(corr)) {
      message("running with run_vdm_jg()....\n")
      df <- as.matrix(data.frame(m = m, sJ = sJ, sA=sA, Fec=Fec, juvshape=juvshape))
      lambda <- apply(df, 1, function(x) run_vdm_jg(x[1],x[2], x[3], x[4], x[5]))
      df <- data.frame(m,sJ,lambda)
      df$type <- "juvshape"
      }

    if(is.null(juvshape) && !is.null(corr)) {
      message("running with run_vdm_corr()....\n")
      df <- as.matrix(data.frame(m = m, sJ = sJ, sA=sA, Fec=Fec, corr=corr))
      lambda <- apply(df, 1, function(x) run_vdm_corr(x[1], x[2], x[3], x[4], x[5]))
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
tradeoff.plot <- function(data, ptitle="") {
  # Make colors red, blue, and gold.
  # make shapes also 3 different kinds.
  if(length(unique(data$type))>3)
    stop("Function not set up to deal with more than 3 categories at the moment")

  base_colours <- c("#a8ddb5","#43a2ca","#e0f3db")
  colours <- base_colours[1:length(unique(data$type))]
  tplot <- ggplot(data, aes(m, lambda, colour = type)) + geom_point(size = 2.8,shape = 16) + opts(title = ptitle) + opts(panel.background = theme_blank()) + scale_color_manual(values=colours)
  return(tplot)
}

# =------------------------------------------

do_tradeoff <- function(tlist) {
  toff <- tradeoff(tlist$a, tlist$b, tlist$Fec, tlist$sA, m = NULL)
  basic_result <- list(data=toff,params=tlist)
  return(basic_result)
}

# =------------------------------------------

do_vd_tradeoff <- function(tlist) {
  if(len(tlist)==5)
    vd_toff <- vd_tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, m = NULL)

  if(len(tlist)==6 && names(tlist)[5]=="juvshape")
    vd_toff <- vd_tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, juvshape = tlist$juvshape, m = NULL)

  if(len(tlist)==6 && names(tlist)[5]=="corr")
    vd_toff <- vd_tradeoff(tlist$a, tlist$b, tlist$sA, tlist$Fec, tlist$corr, m = NULL)

  vd_result <- list(data=vd_toff,params=tlist)
  return(vd_result)
}

# =------------------------------------------

arg_max <- function(data) {
  smoothed <- smooth.spline(data$m,data$lambda,df=10)
  maxy <- max(smoothed$y)
  maxx <- smoothed$x[which(smoothed$y==maxy)]
  return(list(maxx,maxy))
}
