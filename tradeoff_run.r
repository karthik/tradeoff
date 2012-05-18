library(plyr)
library(ggplot2)
library(gridExtra)
library(varDev)
source('tradeoff_functions.r')


## @knitr setting_up_parameters
sA <- 0.7 # adult mortality
Fec <- 2 #fecundity
A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2)
max(eigen(A)$values)

## @knitr basic-tradeoff
example.tradeoff <- tradeoff.curve(0.9, -0.8)
example.tradeoff$type <- "Simple_Example"
## There is a nice optimum there.

## @knitr basic-tradeoff-plot
plot1 <- tradeoff.plot(example.tradeoff, "An example tradeoff")



## @knitr jgrowth_survival


## @knitr agrowth_fecundity


## @knitr jgrowth_fecundity


# OLD CODE IS BELOW

# VD.model(num.stages, marginal.durations,
#     marginal.death.times, fecundity = NULL,
#     controls = NULL, stage.names = NULL, gauss.cov = NULL)

VDM <- suppressWarnings(VD.model(2, marginal.durations = list(VD.dist("geomp1", list(prob = m)), VD.dist("geomp1", list(prob = (1-sA)))),
	marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),VD.dist("infinite"))))

VDS <- VD.run(VDM)
dev.table <- compile.dev.table(VDS)
# dev.table contains:
#"dev.table", "dev.table.contin", "dev.table.Z", "survival.weight", "stage.kept.weight", "shared.weight", "MC.sample.size.final.stage", "MC.sample.size.all"

mean.fec <- calc.average.surv.rep.by.age(dev.table, F = F)
## note for Perry: doesn't work to supply F in VD.model and not here.
r <- VD.solve.euler(mean.fec)

## Now let's imitate the fitness surface above:

VD.example.tradeoff <- suppressWarnings(VD.tradeoff.curve(0.9, -0.8))
## ignore all the warnings.
VD.example.tradeoff$type <-"VD_Example_Tradeoff"
data <- rbind(example.tradeoff, VD.example.tradeoff)
plot2 <- ggplot(data,aes(m,lambda,colour=type)) + geom_point(size=3.5, aes(shape=type)) + opts(title="VD Example Tradeoff")

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


## If this is set up correctly, then with juvshape = 1, we should get the same result as above
VD.example.tradeoff.juvgamma <- VD.tradeoff.curve.juvgamma(0.9, -0.8, juvshape = 1)
VD.example.tradeoff.juvgamma$type="Juv_Gamma"
data2 <- rbind(example.tradeoff,VD.example.tradeoff.juvgamma)
plot3 <- ggplot(data2,aes(m,lambda,colour=type)) + geom_point(size=3.5, aes(shape=type)) + opts(title="Juv Gamma, juvshape =1")

## Good, they match.

## Now let's try setting sd = 0.5 * mean for juv duration
VD.example.tradeoff.juvgamma2 <- VD.tradeoff.curve.juvgamma(0.9, -0.8, juvshape = 1/(0.5^2))
VD.example.tradeoff.juvgamma2$type = "Juv_Gamma2"
data3 <- rbind(example.tradeoff,VD.example.tradeoff.juvgamma2)
plot4 <- ggplot(data3,aes(m,lambda,colour=type)) + geom_point(size=3.5, aes(shape=type)) + opts(title="Juv Gamma, juvshape =4")

## Off the cuff that looks substantially different (the location of the peak shifted), so it is an interesting result.

VD.example.tradeoff.cor <- VD.tradeoff.curve.cor(0.9, -0.8, cor = 0.7)
plot(lambda ~ m, example.tradeoff, pch = 'x') ## switched order so both show
points(lambda ~ m, VD.example.tradeoff.cor)

## Looks like a little bit of a shift, but not as big as for the gamma case above. We will need a way to find the arg max (location of the maximum).For the simulated models this is a little bit tricky because of simulation noise.  I think an easy practical approach would be to calculate lambda for a grid of values (as above), then fit a spline to those and find the peak of the spline.  Actually I have some code to do that for another project that I could dig up if we want it.  Another option is to open up the simulation code so we use the same underlying random quantiles every time (I can explain that more).


grid.arrange(plot1,plot2,plot3,plot4)
