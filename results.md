% Life-history tradeoffs trial runs
% Karthik Ram
% `Fri May 18 10:13:36 2012`

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

<!-- Setting up R -->


<!-- read external r code -->



## 1. Setting up parameters


```r
a <- 0.9
b <- -0.8
sA <- 0.7  # adult mortality
Fec <- 2  #fecundity
```



### Next, we generate two sets of simple tradeoffs


```r
simple <- tradeoff(a, b, sA)
```



```
## Error: could not find function "tradeoff"
```



```r
vd_test <- vd_tradeoff(a, b, sA)
```



```
## Error: could not find function "vd_tradeoff"
```



```r
simple
```



```
## Error: object 'simple' not found
```



```r
vd_test
```



```
## Error: object 'vd_test' not found
```






```r
plot1 <- tradeoff.plot(rbind(simple, vd_test))
```



```
## Error: could not find function "tradeoff.plot"
```



```r
plot1
```



```
## Error: object 'plot1' not found
```





## 2. With Juvgamma


```r
with_juvgamma <- vd_tradeoff(a, b, sA, juvshape = 1)
```



```
## Error: could not find function "vd_tradeoff"
```



```r
with_juvgamma2 <- vd_tradeoff(a, b, sA, juvshape = 1/(0.5^2))
```



```
## Error: could not find function "vd_tradeoff"
```



```r
with_juvgamma
```



```
## Error: object 'with_juvgamma' not found
```



```r
with_juvgamma2
```



```
## Error: object 'with_juvgamma2' not found
```






```r
plot2 <- tradeoff.plot(rbind(simple, with_juvgamma))
```



```
## Error: could not find function "tradeoff.plot"
```



```r
plot3 <- tradeoff.plot(rbind(simple, with_juvgamma2))
```



```
## Error: could not find function "tradeoff.plot"
```



```r
grid.arrange(plot2, plot3)
```



```
## Error: could not find function "grid.arrange"
```




## 3.  With Correlation


```r
with_cor <- vd_tradeoff(a, b, sA, corr = 1)
```



```
## Error: could not find function "vd_tradeoff"
```



```r
with_cor2 <- vd_tradeoff(a, b, sA, corr = 0.7)
```



```
## Error: could not find function "vd_tradeoff"
```



```r
with_cor
```



```
## Error: object 'with_cor' not found
```



```r
with_cor2
```



```
## Error: object 'with_cor2' not found
```





```r
# plot4 <- tradeoff.plot(rbind(simple,with_cor))\nplot5 <- tradeoff.plot(rbind(simple,with_cor2))\nplot5
```






