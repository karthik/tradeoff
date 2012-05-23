## @knitr setup
rm(list=ls())
library(ggplot2)
library(gridExtra)
library(data.table)
library(stringr)
source('~/Github/postdoc/tradeoff/tradeoff_functions.r')
load('~/Github/postdoc/tradeoff/results/t1_simple.rdata')
load('~/Github/postdoc/tradeoff/results/t1_vd.rdata')
load('~/Github/postdoc/tradeoff/results/t1_juvshape.rdata')
load('~/Github/postdoc/tradeoff/results/t1_corr.rdata')
# collapse all the parameter fields into a data.frame
simple_plot_ids <- ldply(t1_simple, function(x) data.frame(x$params))
vd_plot_ids <- ldply(t1_vd, function(x) data.frame(x$params))
juv_plot_ids <- ldply(t1_juvshape, function(x) data.frame(x$params))
corr_plot_ids <- ldply(t1_corr, function(x) data.frame(x$params))
first <- join(simple_plot_ids, juv_plot_ids, by=c("a","b","sA","Fec"))
all_plots <- join(first, corr_plot_ids,  by=c("a","b","sA","Fec"))
names(all_plots)[5] <- "sim_id"
names(all_plots)[7] <- "sim_juv"
names(all_plots)[9] <- "sim_cor"
all_plots$sim_id <- str_sub(all_plots$sim_id, 2)
all_plots$sim_juv <- str_sub(all_plots$sim_juv, 3)
all_plots$sim_cor <- str_sub(all_plots$sim_cor, 3)
all_plots$id <- 1:dim(all_plots)[1]
all_plots <- data.table(all_plots)
keycols = c("sim_id","sim_juv","sim_cor")
setkeyv(all_plots,keycols)

## @knitr Fec_2
# Working with fecundity = 2
Fec2 <- all_plots[Fec==2]
Fec2_plots <- dlply(Fec2, .(id), assemble_plots)
## @knitr Fec2p1
do.call("grid.arrange", c(Fec2_plots[1:8], ncol=2))

## @knitr Fec_2_p2
do.call("grid.arrange", c(Fec2_plots[13:25], ncol=3))

## @knitr Fec_2_p3
do.call("grid.arrange", c(Fec2_plots[26:38], ncol=3))

## @knitr Fec_2_p4
do.call("grid.arrange", c(Fec2_plots[39:51], ncol=3))

## @knitr Fec_2_p5
do.call("grid.arrange", c(Fec2_plots[52:64], ncol=3))

## @knitr Fec_2_p6
do.call("grid.arrange", c(Fec2_plots[65:77], ncol=3))

## @knitr Fec_2_p7
do.call("grid.arrange", c(Fec2_plots[78:90], ncol=3))

## @knitr Fec_2_p8
do.call("grid.arrange", c(Fec2_plots[90:98], ncol=3))


# Drop the new columns in corr and juvshape. Do a match.
# Then pull M1 from simple, M1 from VD and M1 form merged table.
