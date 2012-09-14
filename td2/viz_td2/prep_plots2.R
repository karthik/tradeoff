rm(list=ls())
library(plyr)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td2/viz_td2')
source('../analysis_td2/tfunctions2.R')
load('../results_td2/t2_adshape_2012-08-29_10_02_00.rdata')
load('../results_td2/t2_simple_2012-08-29_09_57_04.rdata')
load('../results_td2/t2_corr_2012-08-29_10_53_51.rdata')
load('../results_td2/t2_vd_2012-08-29_09_45_19.rdata')


# ------------------------------ SIMPLE
simple_max <- ldply(t2_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sJ=x$params$sJ, adshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "simple"))
	}, .progress = 'text')

simple_max$cv <- 1
# ------------------------------ VD
# VD
vd_max <- ldply(t2_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sJ=x$params$sJ, adshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "vd"))
	}, .progress = 'text')
vd_max$cv <- 1

# ------------------------------ adshape

xx <- ldply(t2_adshape, function(x) class(x[[1]]))
keep <- which(xx$V1=="data.frame")
t2_adshape <- t2_adshape[keep]


process_mstar_adshape <- function(x) {
	if(!inherits(x, "try-error")) {
	 if(class(x$data)=="data.frame") {
		# message(sprintf("%s",x$params$sim_id))
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sJ=x$params$sJ, adshape = x$params$adshape, corr = NA,  mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "adshape", cv = cv))
		 }
		} else {
			return(data.frame(a= NA, b= NA, sJ= NA,  adshape = NA, corr = NA,  mstar = "Nan", amax_y = "Nan", sim_id = x$params$sim_id, type = "adshape", cv = NA))
		}
	}
# ------------------------------cleaning up adshape.

remove_bad <- function(all) {
keep <- apply(all, 1, function(x) !any("Nan" %in% x))
cleaned_all <- all[keep, ]
return(cleaned_all)
}

juvshape_max <- ldply(t2_adshape, process_mstar_adshape, .progress = 'text')
juvshape_max <- remove_bad(juvshape_max)

# ------------------------------working through the mstar of corr.
process_mstar_cv <- function(x) {
		# message(sprintf("%s, %s", class(x$data), dim(x$data)[1]))
		if(class(x$data)=="data.frame") {
		# message(sprintf("%s",x$params$sim_id))
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sJ=x$params$sJ, adshape = x$params$adshape, corr = x$params$corr,  mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "corr", cv = cv))
	}
		else {
			return(data.frame(a = NA, b = NA, sA = NA, Fec = NA, adshape = NA, corr = NA,  mstar = "Nan", amax_y = "Nan", sim_id = x$params$sim_id, type = "corr", cv = NA))
		}
	}


# ------------------------------

message("Calculating arg max for t1_corr \n")
x2 <- ldply(t2_corr, length)
if(length(which(x2$V1==0))>0) {
	t2_cor <- t2_corr[-which(x2$V1==0)] } else {
		t2_cor <- t2_corr
	}

corr_max <- ldply(t2_cor, process_mstar_cv, .progress = 'text')
corr_max <- remove_bad(corr_max)

all <- rbind(simple_max, vd_max, juvshape_max, corr_max)
message(sprintf("All currently has dim %s %s \n",dim(all)[1], dim(all)[2]))
# Remove any items that were not computed.
bad <- apply(all, 1, function(x) !any("Nan" %in% x))
cleaned_all <- all[bad, ]
message(sprintf("All currently has dim %s %s \n",dim(cleaned_all)[1], dim(cleaned_all)[2]))
cleaned_all <- data.table(all)
save(cleaned_all, file="all_results_new.rda")



# Saving individual results in separate data tables
working_corr2 <- data.table(ldply(t2_corr, function(x) data.frame(x[[2]]), .progress='text'))
working_js2 <- data.table(ldply(t2_adshape, function(x) data.frame(x[[2]]), .progress = 'text'))
working_vd2 <- data.table(ldply(t2_vd, function(x) data.frame(x[[2]]), .progress = 'text'))
working_simple2 <- data.table(ldply(t2_simple, function(x) data.frame(x[[2]]), .progress = 'text'))

# Setting keys to make them sortable.
setkeyv(working_corr, "sim_id")
setkeyv(working_js, "sim_id")
setkeyv(working_vd, "sim_id")
setkeyv(working_simple, "sim_id")

# Saving the files to disk.
save(working_vd, file="working_vd2.rdata")
save(working_corr, file="working_corr2.rdata")
save(working_js, file="working_js2.rdata")
save(working_simple, file="working_simple2.rdata")

# Next run generate_all_plots.R to visualize these results.
# ------------------------------------------------------------------
