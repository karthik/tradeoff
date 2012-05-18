% Life-history tradeoff example runs
% Karthik Ram
% `Thu May 17 21:09:32 2012`

# Summary
In this effort we calculate optimal trade-offs between juvenile survival, fecundity, and adult survial. We work with models at two ends of the spectrum. First, we have full on matrix model, and at the other end, we have a model with correlation in time spent between stages.

I have coded up a handful of possible tradeoffs and ways in which we might explore them. You will also notice the spline function I have written to calculate the optimum.

All the code including this document is currently available on [github](http://github.com/karthikram/lhtradeoff)

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

results go here.

## 5.  How do results from the above classic kind of life-history tradeoffs change if we assume more realistic distributions of the time spent in each stage and/or allow correlations between stages?

In the example below, we consider one such case. Taking `1`, we now impose...



