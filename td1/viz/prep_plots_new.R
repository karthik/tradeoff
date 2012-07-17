rm(list=ls())
library(plyr)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../analysis/tfunctions.R')

load('../results/t1_simple_2012-07-12_14_47_11.085.rdata')
load('../results/t1_juv_2012-07-12_18_15_44.rdata')
load('../results/t1_vd_2012-07-12_18_11_55.rdata')
load('../results/t1_corr1_2012-07-12_18_15_52.rdata')

xx <- ldply(t1_juvshape, function(x) class(x[[1]]))
keep <- which(xx$V1=="data.frame")
t1_juvshape <- t1_juvshape[keep]


# ------------------------------ SIMPLE
simple_max <- ldply(t1_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "simple"))
	}, .progress = 'text')
simple_max$cv <- 1
# ------------------------------ VD
# VD
vd_max <- ldply(t1_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "vd"))
	}, .progress = 'text')
vd_max$cv <- 1

# ------------------------------ JUVSHAPE

process_mstar_juvshape <- function(x) {
	if(!inherits(x, "try-error")) {
	 if(class(x$data)=="data.frame") {
		# message(sprintf("%s",x$params$sim_id))
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = NA,  mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id,type = "juvshape", cv = cv))
		 }
		} else {
			return(data.frame(a= NA, b= NA, sA= NA, Fec = NA, juvshape = NA, corr = NA,  mstar = "Nan", amax_y = "Nan", sim_id = x$params$sim_id, type = "juvshape", cv = NA))
		}
	}
# ------------------------------

remove_bad <- function(all) {
keep <- apply(all, 1, function(x) !any("Nan" %in% x))
cleaned_all <- all[keep, ]
return(cleaned_all)
}

juvshape_max <- ldply(t1_juvshape, process_mstar_juvshape, .progress = 'text')
juvshape_max <- remove_bad(juvshape_max)
# ------------------------------
process_mstar_cv <- function(x) {
		if(class(x$data)=="data.frame") {
		# message(sprintf("%s",x$params$sim_id))
		amax <- arg_max(x$data)
		cv <- unique(x$data$cv)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = x$params$juvshape, corr = x$params$corr,  mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "corr", cv = cv))
	}
		else {
			return(data.frame(a = NA, b = NA, sA = NA, Fec = NA, juvshape = NA, corr = NA,  mstar = "Nan", amax_y = "Nan", sim_id = x$params$sim_id, type = "corr", cv = NA))
		}
	}

# ------------------------------
# Removing empty results from t1_corr1
message("Calculating arg max for t1_corr1 \n")
x2 <- ldply(t1_corr1, length)
if(length(which(x2$V1==0))>0) {
	t1_cor1 <- t1_corr1[-which(x2$V1==0)] } else {
		t1_cor1 <- t1_corr1
	}

corr_max <- ldply(t1_cor1, process_mstar_cv, .progress = 'text')
corr_max <- remove_bad(corr_max)

all <- rbind(simple_max, vd_max, juvshape_max, corr_max)
message(sprintf("All currently has dim %s %s \n",dim(all)[1], dim(all)[2]))
# Remove any items that were not computed.
bad <- apply(all, 1, function(x) !any("Nan" %in% x))
cleaned_all <- all[bad, ]
message(sprintf("All currently has dim %s %s \n",dim(cleaned_all)[1], dim(cleaned_all)[2]))
cleaned_all <- data.table(all)
save(cleaned_all, file="all_results_new.rda")




working_corr <- data.table(ldply(t1_corr1, function(x) data.frame(x[[2]]), .progress = 'text'))

working_js <- data.table(ldply(t1_juvshape, function(x) data.frame(x[[2]]), .progress = 'text'))


working_vd <- data.table(ldply(t1_vd, function(x) data.frame(x[[2]]), .progress = 'text'))

working_simple <- data.table(ldply(t1_simple, function(x) data.frame(x[[2]]), .progress = 'text'))

setkeyv(working_corr, "sim_id")
setkeyv(working_js, "sim_id")
setkeyv(working_vd, "sim_id")
setkeyv(working_simple, "sim_id")


save(working_vd, file="working_vd.rdata")
save(working_corr, file="working_corr.rdata")
save(working_js, file="working_js.rdata")
save(working_simple, file="working_simple.rdata")

