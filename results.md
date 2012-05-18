% Life-history tradeoff example runs
% Karthik Ram
% `Thu May 17 22:11:17 2012`

# Summary
In this effort we calculate optimal trade-offs between juvenile survival, fecundity, and adult survial. We work with models at two ends of the spectrum. First, we have full on matrix model, and at the other end, we have a model with correlation in time spent between stages.

I have coded up a handful of possible tradeoffs and ways in which we might explore them. You will also notice the spline function I have written to calculate the optimum.

All the code including this document is currently available on [github](https://github.com/karthikram/tradeoff)

# Some assumptions
* Growth with maturation rate m describes an exponential distribution of time spent as a juvenile, with mean = sd = 1/m. We can assume different gamma distributions ranging from this exponential to intermediate variation to negligible variation (fixed development time) with expected value = 1/m to be equivalent.

* Adult survival rate `(1 − SA)` describes an exponential distribution of time spent as an adult, with `mean = sd = 1/SA`. Like the previous point, we can replace this with a range of gamma distributions with the same expected value.

* Juvenile survival is defined in the same way, as a simple rate.

* For example, for an assumed tradeoff between m and `(1−SJ)`, we can assume a gamma distribution for time spent as a juvenile, `tJ`, and instead define the tradeoff for `E[1/tJ ]` vs. `(1 − SJ )`. Then with my old code we can solve for the optimal value on the tradeoff.

* And then we can also assume correlations between the two stages.

<!-- Setting up R -->


<!-- read external r code -->



## 1. Basic testing to see if we can generate a simple tradeoff
Here I can generate my data


```r
sJ <- 0.8  # juvenile mortality sJ <- seq(0.1,.9,.1)
m <- 0.3  # maturation
sA <- 0.7  # adult mortality
F <- 2  #fecundity
A <- matrix(c((1 - m) * sJ, m * sJ, F, sA), nrow = 2)
max(eigen(A)$values)
```



```
## [1] 1.326
```




## 2.  `Juvenile growth` vs `survival`



```r
set.seed(123)
rnorm(5)
```



```
## [1] -0.56048 -0.23018  1.55871  0.07051  0.12929
```



results go here.

## 3.  Adult survival  vs. fecundity

results go here.

## 4.  Juvenile growth vs. fecundity

# Results
An now the reults are plotted


```r
plot1 <- ggplot(example.tradeoff, aes(m, lambda)) + geom_point(size = 2) + 
    geom_line() + opts(title = "An example tradeoff")
```



```
## Error: object 'example.tradeoff' not found
```




## 5.  How do results from the above classic kind of life-history tradeoffs change if we assume more realistic distributions of the time spent in each stage and/or allow correlations between stages?

In the example below, we consider one such case. Taking `1`, we now impose...



