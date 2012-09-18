
rm(list=ls())
library(ggplot2)
library(gridExtra)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../analysis/tfunctions.R')
source('plot_functions.R')

# A collated data.frame with results from simple, vd, juvshape, and corr.
load('all_results_new.rda')
# The collapsed parameters to locate the plots
load("working_simple.rdata")
load("working_vd.rdata")
load('working_corr.rdata')
load('working_js.rdata')

# Raw results
load('../results/t1_simple_2012-07-24_19_40_49.rdata')
load('../results/t1_vd_2012-07-24_19_41_14.rdata')
load('../results/t1_juv_2012-07-24_19_49_26.rdata')
load('../results/t1_corr_2012-07-24_20_12_45.rdata')

# Note, of the 40 + 400 + 4000 = 4040 combination, we only successfully got 338 (702 didn't work out).

split_data_a <- dlply(cleaned_all, .(sA))
# this is a length of 4 since there are 4 adult survival values.

rep <- split_data_a[2]
rep2 <- ldply(rep)
split_data <- dlply(rep2, .(a,b))
# This is 10 combinations




# ----------------------------------
# One tradeoff, 1
# ----------------------------------

# ordinary curves
vd1 <- o_curves(1)
# juvshape curves
js1 <- j_curves(1)
# correlation curves
co1 <- c_curves(1)
s_data1 <- rbind(vd1, js1, co1)

# ROW1 , PANEL 1
# Just the tradeoff line
actual_tradeoff <- data.frame(x=c(0,abs(unique(s_data1$b))), y=c(abs(unique(s_data1$a)),0))
tradeoff_plot <- ggplot(actual_tradeoff, aes(x,y)) + geom_line(color="#edb14a", size=1.5, type=2) + ggtitle("Tradeoff Scenario") + xlab("Juvenile growth rate") + ylab("Juvenile survival rate") 

# ROW1 , PANEL 2, 3, 4.
panel1<- ggplot(vd1, aes(m,lambda, colour=type)) + geom_point(size=4,aes(shape=type)) + xlab("Growth rate") + ylab("Lambda") + scale_color_manual(values=c("#1a68a0","#a1323a"), guide= "none")+ geom_vline(xintercept= 0.3710526) + geom_vline(xintercept=0.3194737, linetype=2)

Color palette for visualization.
Blue: #1a68a0
Red: #a1323a
Black: #455860
Gold: #edb14a

ggplot(js1, aes(m,lambda, colour=cv)) + geom_point(size=3,shape=16) + xlab("Growth rate") + ylab("Lambda")
ggplot(co1, aes(m,lambda, colour=cv)) + geom_point(size=3) + xlab("Growth rate") + ylab("Lambda")

# ROW 2, PANEL 1,2,3
# ---------------------------------------------
s1 <- split_data[[1]]
s1$mstar <- as.numeric(s1$mstar)
s1$cor_status <- rep("cor_status", dim(s1)[1])
s1[which(is.na(s1$corr)), ]$cor_status <- "No correlation"
s1[which(!is.na(s1$corr)), ]$cor_status <- "Correlation"

s1$variation <- rep("variation", dim(s1)[1])
s1[which(s1$cv==1), ]$variation <- "No variation"
s1[which(s1$cv!=1), ]$variation <- "With variation"

nc_plot <- ggplot(subset(s1, s1$cor_status=="Correlation"), aes(cv,mstar))  + geom_point(size=4)  + ylim(0.35,.7) + facet_wrap(~corr)


low_plot <- ggplot(subset(s1, corr==0.2) , aes(cv,mstar, colour=variation))  + geom_point(size=4, aes(shape=cor_status), position = position_jitter(w = 0.001, h = 0.0)) + ylim(0.35,.7) +  scale_shape_manual(values=c(1,19))


high_plot <- ggplot(subset(s1, corr==0.9) , aes(cv,mstar, colour=variation))  + geom_point(size=4, aes(shape=cor_status), position = position_jitter(w = 0.001, h = 0.0)) + ylim(0.35,.7) +  scale_shape_manual(values=c(19,1))

grid.arrange(nc_plot, low_plot, high_plot, nrow=1)

# ----------------------------------
# ---- end one tradeoff ------------


# grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 5)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y) 
print(tradeoff_plot, vp = vplayout(1:2, 1:2)) 
print(panel1, vp = vplayout(1, 3)) 
print(panel1, vp = vplayout(1, 4))
print(panel1, vp = vplayout(1, 5))
print(plota, vp = vplayout(2, 3)) 
print(plota, vp = vplayout(2, 4))
print(plota, vp = vplayout(2, 5))
print(plota, vp = vplayout(3, 1))
print(plota, vp = vplayout(3, 2))
print(plota, vp = vplayout(3, 3))
print(plota, vp = vplayout(3, 4))
print(plota, vp = vplayout(3, 5))
# dev.off()












# ----------------------------------
# One tradeoff, 1
# ----------------------------------

# ordinary curves
vd1 <- o_curves(6)
# juvshape curves
js1 <- j_curves(6)
# correlation curves
co1 <- c_curves(6)
s_data1 <- rbind(vd1, js1, co1)

# ROW1 , PANEL 1
# Just the tradeoff line
actual_tradeoff <- data.frame(x=c(0,abs(unique(s_data1$b))), y=c(abs(unique(s_data1$a)),0))
ggplot(actual_tradeoff, aes(x,y)) + geom_line(color="#a1323a", size=2.3) + ggtitle("Tradeoff Scenario") + xlab("Juvenile growth rate") + ylab("Juvenile survival rate")

# ROW1 , PANEL 2, 3, 4.
ggplot(vd1, aes(m,lambda, colour=type)) + geom_point(size=3,shape=16) + xlab("Growth rate") + ylab("Lambda")
ggplot(js1, aes(m,lambda, colour=cv)) + geom_point(size=3,shape=16) + xlab("Growth rate") + ylab("Lambda")
ggplot(co1, aes(m,lambda, colour=cv)) + geom_point(size=3) + xlab("Growth rate") + ylab("Lambda")

# ROW 2, PANEL 1,2,3
# ---------------------------------------------
s1 <- split_data[[1]]
s1$mstar <- as.numeric(s1$mstar)
s1$cor_status <- rep("cor_status", dim(s1)[1])
s1[which(is.na(s1$corr)), ]$cor_status <- "No correlation"
s1[which(!is.na(s1$corr)), ]$cor_status <- "Correlation"

s1$variation <- rep("variation", dim(s1)[1])
s1[which(s1$cv==1), ]$variation <- "No variation"
s1[which(s1$cv!=1), ]$variation <- "With variation"

nc_plot <- ggplot(subset(s1, is.na(corr)), aes(cv,mstar, colour=variation))  + geom_point(size=4, aes(shape=cor_status), position = position_jitter(w = 0.001, h = 0.0))  + ylim(0.35,.7) +  scale_shape_manual(values=c(1,19))


low_plot <- ggplot(subset(s1, corr==0.2) , aes(cv,mstar, colour=variation))  + geom_point(size=4, aes(shape=cor_status), position = position_jitter(w = 0.001, h = 0.0)) + ylim(0.35,.7) +  scale_shape_manual(values=c(1,19))


high_plot <- ggplot(subset(s1, corr==0.9) , aes(cv,mstar, colour=variation))  + geom_point(size=4, aes(shape=cor_status), position = position_jitter(w = 0.001, h = 0.0)) + ylim(0.35,.7) +  scale_shape_manual(values=c(19,1))

grid.arrange(nc_plot, low_plot, high_plot, nrow=1)

# ------------------------------------------------------
# ---- end one tradeoff ------------















# old code below, revisit later. #


ggplot(split_data[[31]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td31.pdf')

ggplot(split_data[[32]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td32.pdf')

ggplot(split_data[[33]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td33.pdf')

ggplot(split_data[[34]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td34.pdf')

ggplot(split_data[[35]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td35.pdf')

ggplot(split_data[[36]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td36.pdf')


ggplot(split_data[[37]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td37.pdf')

ggplot(split_data[[38]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td38.pdf')


ggplot(split_data[[39]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td39.pdf')

ggplot(split_data[[40]], aes(cv, mstar, colour = type)) + geom_point(size=3.2) + facet_wrap(~corr) + scale_colour_brewer("type",palette="Set1")
ggsave('pdfs/td40.pdf')




