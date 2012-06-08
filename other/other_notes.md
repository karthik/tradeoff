# Some notes pulled from Perry's first script.

## Section on juvenile growth.
 Now let's make juvenile development follow a gamma distribution. This involves some roughnesses due to discretization of continuous rv's. Geometric is a discretized exponential.  Exponential has `mean = sd.` `Geometric mean != sd` due to discretization.

 Gamma generalizes the exponential and has mean = sd * sqrt(shape). Exponential case is shape = 1. For now I will generalize these by changing the shape parameter and keeping the mean at its exponential-equivalent value.  To nail it more precisely in the future, we can compute mean and sd of discretized gammas and set them as needed. Or, we might decide that is not necessary.  Another option, sticking with truly discrete distributions, might be to use the negative binomial to generalize from the geometric.

A juvshape of 1 should be the same as not including it and just running vd_tradeoff_curve. If this is set up correctly, then with juvshape = 1, we should get the same result as above. Now let's try setting sd = 0.5 * mean for juv duration (by setting juvshape = 1/(0.5^2)). Off the cuff that looks substantially different (the location of the peak shifted), so it is an interesting result.


## Section on adding in correlations
Now let's try including a correlation between juv and adult duration, but keeping the geometric distributions. The corr parameter is the correlation in the gaussian copula between juvenile and adult stage duration. Looks like a little bit of a shift (after correlation), but not as big as for the gamma case above.

## Notes on fitting a spline.

 We will need a way to find the arg max (location of the maximum).For the simulated models this is a little bit tricky because of simulation noise.  I think an easy practical approach would be to calculate lambda for a grid of values (as above), then fit a spline to those and find the peak of the spline.  Actually I have some code to do that for another project that I could dig up if we want it.  Another option is to open up the simulation code so we use the same underlying random quantiles every time (I can explain that more).
