% Life-history tradeoff example runs
% Karthik Ram
% `r date()`

<!-- Setting up R -->
`ro warning=FALSE, dev="png", fig.cap="", cache=FALSE or`

```{r setup, echo=F}
library(ggplot2)
library(plyr)
library(varDev2)
library(lubridate)
library(gridExtra)
read_chunk("t1_example.r")
```


# Summary
In my attempts so far, I have set up and run various tradeoff scenarios. In my attempts so far, I have set up and run various tradeoff scenarios. The first set of scenarios look at tradeoffs between maturation rate `m` and juvenile survival `sJ`.

##1. Exploring tradeoffs between maturation rate and juvenile survival



### Generating an initial set of tradeoffs
```{r parameters}
```
Using the function `param_combs`, we have created a set of `r length(parameters)` combination(s).

### Simple case
First we fit the really simple matrix case.
```{r simple_tradeoff, echo=TRUE, cache=TRUE}
```

### Results
```{r simple_tradeoff_results}
```

```{r plot, echo=FALSE, results="asis", cache=TRUE}
```
