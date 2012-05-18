library(ggplot2)
library(varDev)
library(gridExtra)

setwd('~/Github/postdoc/lh_tradeoff/')
source('tradeoff_functions.r')

# Some assumptions
# Growth with maturation rate m describes an exponential distribution of time spent as a juvenile, with mean = sd = 1/m. We can assume different gamma distributions ranging from this exponential to intermediate variation to negligible variation (fixed development time) with expected value = 1/m to be equivalent.

# Adult survival rate (1 − μA) describes an exponential distribution of time spent as an adult, with mean = sd = 1/μA. Like the previous point, we can replace this with a range of gamma distributions with the same expected value.

# Juvenile survival is defined in the same way, as a simple rate.

# For example, for an assumed tradeoff between m and (1−μJ ), we can assume a gamma distribution for time spent as a juvenile, tJ, and instead define the tradeoff for E[1/tJ ] vs. (1 − μJ ). Then with my old code we can solve for the optimal value on the tradeoff.

# And then we can also assume correlations between the two stages.

# Make the below to be vectors......
sJ <- 0.8 # juvenile mortality sJ <- seq(0.1,.9,.1)
m <- 0.3 # maturation
sA <- 0.7 # adult mortality
F <- 2 #fecundity
A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2)
max(eigen(A)$values)

example.tradeoff <- tradeoff.curve(0.9, -0.8)
example.tradeoff$type <- "Simple_Example"
## There is a nice optimum there.
plot1 <- ggplot(example.tradeoff, aes(m, lambda)) + geom_point(size=2) + geom_line() + opts(title="An example tradeoff")

# ---------------------------------------------------------------------------

VDM <- suppressWarnings(VD.model(2, marginal.durations = list(VD.dist("geomp1", list(prob = m)), VD.dist("geomp1", list(prob = (1-sA)))), marginal.death.times = list(VD.dist("geomp1", list(prob = (1-sJ))),VD.dist("infinite"))))

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
