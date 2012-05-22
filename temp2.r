# Summary
In this effort we calculate optimal trade-offs between juvenile survival, fecundity, and adult survial. We work with models at two ends of the spectrum. First, we have full on matrix model, and at the other end, we have a model with correlation in time spent between stages.

I have coded up a handful of possible tradeoffs and ways in which we might explore them. You will also notice the spline function I have written to calculate the optimum.

All the code including this document + source is currently available on [github](https://github.com/karthikram/tradeoff).

~~~

# Some assumptions
* Growth with maturation rate m describes an exponential distribution of time spent as a juvenile, with mean = sd = 1/m. We can assume different gamma distributions ranging from this exponential to intermediate variation to negligible variation (fixed development time) with expected value = 1/m to be equivalent.

* Adult survival rate `(1 − sA)` describes an exponential distribution of time spent as an adult, with `mean = sd = 1/sA`. Like the previous point, we can replace this with a range of gamma distributions with the same expected value.

* Juvenile survival is defined in the same way, as a simple rate.

* For example, for an assumed tradeoff between m and `(1−sJ)`, we can assume a gamma distribution for time spent as a juvenile, `tJ`, and instead define the tradeoff for `E[1/tJ]` vs. `(1 − sJ)`. Then with my old code we can solve for the optimal value on the tradeoff.

* And then we can also assume correlations between the two stages.