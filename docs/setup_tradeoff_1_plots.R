## @knitr setup
rm(list=ls())
library(ggplot2)
library(gridExtra)
source('../tradeoff_functions.r')
load('../results/t1_simple.rdata')
load('../results/t1_vd.rdata')
load('../results/t1_juvshape.rdata')
load('../results/t1_corr.rdata')
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
## @knitr Fec_2_p1
do.call("grid.arrange", c(Fec2_plots[1:8], ncol=2))
## @knitr Fec_2_p2
do.call("grid.arrange", c(Fec2_plots[9:16], ncol=2))
## @knitr Fec_2_p3
do.call("grid.arrange", c(Fec2_plots[17:25], ncol=2))
## @knitr Fec_2_p4
do.call("grid.arrange", c(Fec2_plots[26:34], ncol=2))
## @knitr Fec_2_p5
do.call("grid.arrange", c(Fec2_plots[35:43], ncol=2))
## @knitr Fec_2_p6
do.call("grid.arrange", c(Fec2_plots[44:52], ncol=2))
## @knitr Fec_2_p7
do.call("grid.arrange", c(Fec2_plots[53:61], ncol=2))
## @knitr Fec_2_p8
do.call("grid.arrange", c(Fec2_plots[62:70], ncol=2))
## @knitr Fec_2_p9
do.call("grid.arrange", c(Fec2_plots[71:79], ncol=2))
## @knitr Fec_2_p10
do.call("grid.arrange", c(Fec2_plots[80:88], ncol=2))
## @knitr Fec_2_p11
do.call("grid.arrange", c(Fec2_plots[89:98], ncol=2))


## @knitr Fec_4
# Working with fecundity = 4
Fec4 <- all_plots[Fec==4]
Fec4_plots <- dlply(Fec4, .(id), assemble_plots)
## @knitr Fec_4_p1
do.call("grid.arrange", c(Fec4_plots[1:8], ncol=2))
## @knitr Fec_4_p2
do.call("grid.arrange", c(Fec4_plots[9:16], ncol=2))
## @knitr Fec_4_p3
do.call("grid.arrange", c(Fec4_plots[17:25], ncol=2))
## @knitr Fec_4_p4
do.call("grid.arrange", c(Fec4_plots[26:34], ncol=2))
## @knitr Fec_4_p5
do.call("grid.arrange", c(Fec4_plots[35:43], ncol=2))
## @knitr Fec_4_p6
do.call("grid.arrange", c(Fec4_plots[44:52], ncol=2))
## @knitr Fec_4_p7
do.call("grid.arrange", c(Fec4_plots[53:61], ncol=2))
## @knitr Fec_4_p8
do.call("grid.arrange", c(Fec4_plots[62:70], ncol=2))
## @knitr Fec_4_p9
do.call("grid.arrange", c(Fec4_plots[71:79], ncol=2))
## @knitr Fec_4_p10
do.call("grid.arrange", c(Fec4_plots[80:88], ncol=2))
## @knitr Fec_4_p11
do.call("grid.arrange", c(Fec4_plots[89:98], ncol=2))



## @knitr Fec_8
# Working with fecundity = 8
Fec8 <- all_plots[Fec==8]
Fec8_plots <- dlply(Fec8, .(id), assemble_plots)
## @knitr Fec_8_p1
do.call("grid.arrange", c(Fec8_plots[1:8], ncol=2))
## @knitr Fec_8_p2
do.call("grid.arrange", c(Fec8_plots[9:16], ncol=2))
## @knitr Fec_8_p3
do.call("grid.arrange", c(Fec8_plots[17:25], ncol=2))
## @knitr Fec_8_p4
do.call("grid.arrange", c(Fec8_plots[26:34], ncol=2))
## @knitr Fec_8_p5
do.call("grid.arrange", c(Fec8_plots[35:43], ncol=2))
## @knitr Fec_8_p6
do.call("grid.arrange", c(Fec8_plots[44:52], ncol=2))
## @knitr Fec_8_p7
do.call("grid.arrange", c(Fec8_plots[53:61], ncol=2))
## @knitr Fec_8_p8
do.call("grid.arrange", c(Fec8_plots[62:70], ncol=2))
## @knitr Fec_8_p9
do.call("grid.arrange", c(Fec8_plots[71:79], ncol=2))
## @knitr Fec_8_p10
do.call("grid.arrange", c(Fec8_plots[80:88], ncol=2))
## @knitr Fec_8_p11
do.call("grid.arrange", c(Fec8_plots[89:98], ncol=2))



## @knitr Fec_10
# Working with fecundity = 10
Fec10 <- all_plots[Fec==10]
Fec10_plots <- dlply(Fec10, .(id), assemble_plots)
## @knitr Fec_10_p1
do.call("grid.arrange", c(Fec10_plots[1:8], ncol=2))
## @knitr Fec_10_p2
do.call("grid.arrange", c(Fec10_plots[9:16], ncol=2))
## @knitr Fec_10_p3
do.call("grid.arrange", c(Fec10_plots[17:25], ncol=2))
## @knitr Fec_10_p4
do.call("grid.arrange", c(Fec10_plots[26:34], ncol=2))
## @knitr Fec_10_p5
do.call("grid.arrange", c(Fec10_plots[35:43], ncol=2))
## @knitr Fec_10_p6
do.call("grid.arrange", c(Fec10_plots[44:52], ncol=2))
## @knitr Fec_10_p7
do.call("grid.arrange", c(Fec10_plots[53:61], ncol=2))
## @knitr Fec_10_p8
do.call("grid.arrange", c(Fec10_plots[62:70], ncol=2))
## @knitr Fec_10_p9
do.call("grid.arrange", c(Fec10_plots[71:79], ncol=2))
## @knitr Fec_10_p10
do.call("grid.arrange", c(Fec10_plots[80:88], ncol=2))
## @knitr Fec_10_p11
do.call("grid.arrange", c(Fec10_plots[89:98], ncol=2))


# Drop the new columns in corr and juvshape. Do a match.
# Then pull M1 from simple, M1 from VD and M1 form merged table.
