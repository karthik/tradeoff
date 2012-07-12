
## @knitr setup
rm(list=ls())
library(ggplot2)
library(RColorBrewer)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../analysis/tfunctions.R')

## @ knitr load_tradeoff_results
load('all_results.rda')
load('../results/t1_simple_2012-06-13_19_15_16.142.rdata')
load('../results/t1_vd_2012-06-13_22_23_52.rdata')
load("../results/t1_juvshape_cleaned.rdata")
load("../results/cleaned_corr.rdata")

# working_simple <- ldply(t1_simple, function(x) data.frame(x[[2]]), .progress = 'text')
# working_vd <- ldply(t1_vd, function(x) data.frame(x[[2]]), .progress = 'text')
# working_vd <- data.table(working_vd)
# setkeyv(working_vd, "sim_id")
# save(working_vd, file="working_vd.rdata")
# working_corr_a <- ldply(t1_corr[1:12000], function(x) data.frame(x[[2]]), .progress = 'text')
# working_corr_b <- ldply(t1_corr[12001:24000], function(x) data.frame(x[[2]]), .progress = 'text')
# working_corr_c <- ldply(t1_corr[24001:36000], function(x) data.frame(x[[2]]), .progress = 'text')
# working_corr_d <- ldply(t1_corr[36001:48000], function(x) data.frame(x[[2]]), .progress = 'text')
# working_corr_e <- ldply(t1_corr[48001:60000], function(x) data.frame(x[[2]]), .progress = 'text')
# working_corr_f <- ldply(t1_corr[60001:72977], function(x) data.frame(x[[2]]), .progress = 'text')

# working_js <- ldply(t1_juvshape, function(x) data.frame(x[[2]]), .progress = 'text')
# working_corr <- data.table(rbind(working_corr_a, working_corr_b, working_corr_c, working_corr_d, working_corr_e, working_corr_f))
# setkeyv(working_corr, "sim_id")
# working_js <- data.table(working_js)
# setkeyv(working_js, "sim_id")
# save(working_corr, file="working_corr.rdata")
# save(working_js, file="working_js.rdata")
# working_simple <- data.table(working_simple)
# setkeyv(working_simple, "sim_id")
# save(working_simple, file="working_simple.rdata")
load("working_simple.rdata")
load("working_vd.rdata")
load('working_corr.rdata')
load('working_js.rdata')
## @ knitr pram_combinations
split_data <- dlply(cleaned_all, .(a,b,sA))
# dlply by .(a,b, corr) so you get each list item as a tradeoff combination.
# Then, for each one, since sA and F are fixed, cv ~ mstar
# Then  split by the 5 correlations.
#  c(0.1, 0.25, 0.5, 0.75, 0.99)
# That's it for now. 5 plots.
combinations <- ldply(split_data, function(x) data.frame(a=unique(x$a), b=unique(x$b),sA=unique(x$sA), juvshape=x$juvshape,corr=unique(x$corr)))
combinations <- combinations[,-1]
combinations


test <- split_data[[35]]
test <- data.frame(test)
cv <- seq(0.1,.90, by=0.1)
cv <- c(cv,1)
test2 <- test[which(test$cv %in% cv),]
test2 <- subset(test2, is.na(test2$corr) | test2$corr>.76)
ggplot(test2, aes(cv, mstar, colour= type)) + geom_jitter(size =5) + opts(title="sA = 0.8, F = 2")
ggsave(file="working_plot1.pdf")

# Arrrr> subset(test2, is.na(test2$corr) | test2$corr>.76)
#        a    b  sA Fec   juvshape corr     mstar   amax_y  sim_id     type  cv
# 1    0.9 -0.7 0.8   2         NA   NA 0.4742105 1.324957     S24   simple 1.0
# 2    0.9 -0.7 0.8   2         NA   NA 0.5257895 1.322455     S24       vd 1.0
# 59   0.9 -0.7 0.8   2   1.562500   NA 0.6289474 1.309030 JG10024 juvshape 0.8
# 101  0.9 -0.7 0.8   2   2.040816   NA 0.5773684 1.306253 JG10524 juvshape 0.7
# 166  0.9 -0.7 0.8   2   2.777778   NA 0.5773684 1.300502 JG11024 juvshape 0.6
# 227  0.9 -0.7 0.8   2   6.250000   NA 0.7321053 1.311636 JG12024 juvshape 0.4
# 281  0.9 -0.7 0.8   2  25.000000   NA 0.7321053 1.347687 JG13024 juvshape 0.2
# 331  0.9 -0.7 0.8   2   1.000000 0.99 0.5773684 1.237141 CO45144     corr 1.0
# 831  0.9 -0.7 0.8   2   1.562500 0.99 0.6805263 1.233830 CO50144     corr 0.8
# 1081 0.9 -0.7 0.8   2   2.040816 0.99 0.7321053 1.245386 CO52644     corr 0.7
# 1331 0.9 -0.7 0.8   2   2.777778 0.99 0.7836842 1.250090 CO55144     corr 0.6
# 1581 0.9 -0.7 0.8   2   4.000000 0.99 0.7836842 1.262569 CO57644     corr 0.5
# 1831 0.9 -0.7 0.8   2   6.250000 0.99 0.7836842 1.275570 CO60144     corr 0.4
# 2331 0.9 -0.7 0.8   2  25.000000 0.99 0.7321053 1.337380 CO65144     corr 0.2
# 2566 0.9 -0.7 0.8   2 100.000000 0.99 0.7321053 1.369905 CO67644     corr 0.1

c1 = working_corr[sim_id=="CO50144", which=T]
j1 = working_js[sim_id=="JG10024", which=T]
v1 <- working_vd[sim_id=="S24", which=T]
tradeoff.plot(rbind(t1_juvshape[[j1]]$data, t1_corr[[c1]]$data))
c2 <- working_corr[sim_id=="CO45144", which=T]
tradeoff.plot(rbind(t1_vd[[v1]]$data, t1_corr[[c2]]$data))
ggsave(file="corr1_cv.8.pdf")

j2 <- working_js[sim_id=="JG11024", which=T]
c3 <- working_corr[sim_id=="CO55144", which=T]
tradeoff.plot(rbind(t1_juvshape[[j2]]$data, t1_corr[[c3]]$data))
ggsave(file="cv0.6,corr0.9.pdf")


#---------------------------------------

new_test <- split_data[[36]]
new_test <- data.frame(new_test)
cv <- seq(0.1,.90, by=0.1)
cv <- c(cv,1)
new_test2 <- new_test[which(new_test$cv %in% cv),]
new_test2 <- subset(new_test2, is.na(new_test2$corr) | new_test2$corr>.76)
ggplot(new_test2, aes(cv, mstar, colour= type)) + geom_jitter(size =5) + opts(title="sA = 0.9, F = 2")
ggsave("split_36.pdf")




new_test2 <- split_data[[35]]
new_test2 <- data.frame(new_test2)
new_test2$xaxis <- cut(new_test2$cv, 10, labels=F)
# cv <- seq(0.1,.90, by=0.05)
# cv <- c(cv,1)
# new_test22 <- new_test2[which(new_test2$cv %in% cv),]
new_test22 <- new_test2[!duplicated(new_test2$mstar), ]
ggplot(new_test22, aes(cv, mstar, colour= type)) + geom_point(size =5) + opts(title="sA = 0.8, F = 2")
ggsave(file="dupes_removed.pdf")



s1 <- working_simple[sim_id=="S24", which=T]
v1 <- working_vd[sim_id=="S24", which=T]
tradeoff.plot(rbind(t1_simple[[s1]]$data, t1_vd[[v1]]$data))


j1 <- working_js[sim_id=="JG9094", which=T]
j2 <- working_js[sim_id=="JG9154", which=T]
j3 <- working_js[sim_id=="JG9484", which=T]
j4 <- working_js[sim_id=="JG10024", which=T]
j5 <- working_js[sim_id=="JG10374", which=T]
j6 <- working_js[sim_id=="JG11424", which=T]

new_js <- rbind(t1_juvshape[[j1]]$data,t1_juvshape[[j2]]$data,t1_juvshape[[j3]]$data,t1_juvshape[[j4]]$data,t1_juvshape[[j5]]$data,t1_juvshape[[j6]]$data)

ggplot(new_js, aes(m,lambda, colour=as.factor(cv))) + geom_point(size=3)


xx <- ldply(t1_juvshape, function(x) {
return(data.frame(cv = 1/sqrt(x[[2]]$juvshape), sim_id=x[[2]]$sim_id))})

all_data <- ldply(t1_juvshape, function(x) {
	data <- x[[1]]
	return(data)
	})

ggplot(all_data, aes(m, lambda, colour=cv)) + geom_point(size=3.2) + opts(title = "sA = 0.8, F = 2")

ggplot(subset(all_data, cv>0.4), aes(m, lambda, colour=cv)) + geom_point(size=3.2) + opts(title = "sA = 0.8, F = 2")


ggplot(juvshape_max, aes(cv, mstar)) + geom_point(size=5)

ggplot(subset(juvshape_max, cv > 0.5), aes(cv, mstar)) + geom_point(size=5)
