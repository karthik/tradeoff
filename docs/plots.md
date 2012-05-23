% Life-history tradeoff example runs
% Karthik Ram
% `Wed May 23 12:10:37 2012`

<!-- Setting up R -->











```r
# Working with fecundity = 2
Fec2 <- all_plots[Fec == 2]
Fec2_plots <- dlply(Fec2, .(id), assemble_plots)
```



Length of Fec2 is `98, 10`

## Plots, page 1


```r
do.call("grid.arrange", c(Fec2_plots[1:8], ncol = 2))
```

![](figure/Fec_2_p1.png) 



```r
do.call("grid.arrange", c(Fec2_plots[1:8], ncol = 2))
```

![](figure/Fec_2_p1.png) 



```r
do.call("grid.arrange", c(Fec2_plots[9:16], ncol = 2))
```

![](figure/Fec_2_p2.png) 



```r
do.call("grid.arrange", c(Fec2_plots[17:25], ncol = 2))
```

![](figure/Fec_2_p3.png) 



```r
do.call("grid.arrange", c(Fec2_plots[26:34], ncol = 2))
```

![](figure/Fec_2_p4.png) 



```r
do.call("grid.arrange", c(Fec2_plots[35:43], ncol = 2))
```

![](figure/Fec_2_p5.png) 



```r
do.call("grid.arrange", c(Fec2_plots[44:52], ncol = 2))
```

![](figure/Fec_2_p6.png) 



```r
do.call("grid.arrange", c(Fec2_plots[53:61], ncol = 2))
```

![](figure/Fec_2_p7.png) 



```r
do.call("grid.arrange", c(Fec2_plots[62:70], ncol = 2))
```

![](figure/Fec_2_p8.png) 



```r
do.call("grid.arrange", c(Fec2_plots[80:88], ncol = 2))
```

![](figure/Fec_2_p10.png) 



```r
do.call("grid.arrange", c(Fec2_plots[89:98], ncol = 2))
```

![](figure/Fec_2_p11.png) 

```r
# Drop the new columns in corr and juvshape. Do a match.
# Then pull M1 from simple, M1 from VD and M1 form merged table.
```



