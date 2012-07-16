# Fitting a spline

http://stat.ethz.ch/R-manual/R-patched/library/stats/html/smooth.spline.html

00ffba color for green lines
How do I pass a list of ggplots to grid.arrange?
Solved!

I generate variable number of plots using a function.

plot_f <- function(data) return(ggplot(data,aes(x,y)) + geom_point())
plot_list <- llply(list_of_data, plot_f)
grid.arrange(plot_list[[1]], plot_list[[2]])
# Can I automate the last bit so I am not loading one plot at a time?

Challenge, Once I add in parameter combinations, then the list lengths wont exactly match so it would be hard to match the prediction of what I get with my simple tradeoff to what I get once I add in various levels of complexity.

colours <- c("#00ffba", "#657a8a")
#43a2ca
#a8ddb5
#e0f3db

> colours = c(“#599ad3″, “#f9a65a”, “#9e66ab”)
> ggplot(e, aes(x=a, y=c, fill=b, stat=”identity”)) + geom_bar(position=”dodge”) + coord_flip()+scale_fill_manual(values=colours)


# To catch errors.

ss107927468.model <- try(aov(Race.5~ss107927468, data=snp1))
if(isTRUE(all.equal(class(ss107927468.model), "tryCatch"))) {
    writeLines("Model failed")
} else {
    summary(ss107927468.model)
}

n <- length(plist)
nCol <- floor(sqrt(n))
do.call("grid.arrange", c(plist, ncol=nCol))


 x <- 1:10
 y <- c(2,4,6,8,7,12,14,16,18,20)
 lo <- loess(y~x)
 plot(x,y)
 lines(predict(lo), col='red', lwd=2)
