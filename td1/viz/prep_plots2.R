
rm(list=ls())
library(plyr)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../analysis/tfunctions.R')

load('../results/t1_simple_2012-06-13_19_15_16.142.rdata')
load('../results/t1_vd_2012-06-13_22_23_52.rdata')
# load('../results/t1_juv_2012-06-14_02_03_07.rdata')
# load('../results/t1_corr1.rda')
# load('../results/t1_corr2.rda')
# load('../results/t1_corr3.rda')
# load('../results/t1_corr4.rda')
# load('../results/t1_corr5.rda')
# load('../results/t1_corr6.rda')
# load('../results/t1_corr7.rda')
# load('../results/t1_corr8.rda')
# load('../results/t1_corr9.rda')
load("../results/t1_juvshape_cleaned.rdata")
load("../results/cleaned_corr.rdata")
# t1_simple, len = 40
# t1_vd, len = 40
# t1_juvshape = 18040

# Processing juvshape
# xx <- ldply(t1_juvshape, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_juvshape <- t1_juvshape[keep]
# reduced to 10946 after the clean
# save(t1_juvshape, file="../results/t1_juvshape_cleaned.rdata")


# # Processing corr but these are all empty
# xx <- ldply(t1_corr1, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr1b <- t1_corr1[keep]

# xx <- ldply(t1_corr2, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr2b <- t1_corr2[keep]

# xx <- ldply(t1_corr3, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr3b <- t1_corr3[keep]

# xx <- ldply(t1_corr4, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr4b <- t1_corr4[keep]

# xx <- ldply(t1_corr5, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr5b <- t1_corr5[keep]

# xx <- ldply(t1_corr6, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr6b <- t1_corr6[keep]

# xx <- ldply(t1_corr7, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr7b <- t1_corr7[keep]

# xx <- ldply(t1_corr8, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr8b <- t1_corr8[keep]

# xx <- ldply(t1_corr9, function(x) class(x[[1]]))
# keep <- which(xx$V1=="data.frame")
# t1_corr9b <- t1_corr9[keep]

# t1_corr <- c(t1_corr1b, t1_corr2b, t1_corr3b, t1_corr4b, t1_corr5b, t1_corr6b, t1_corr7b, t1_corr8b, t1_corr9b)
# save(t1_corr, file="../results/cleaned_corr.rdata")
# don't repeat steps above unless necessary


# ===================================================================

# Next, write a function to read each list item, calcualate the max arg, then get the params and make a data.frame from it. So basically a ldply on a custom function.

# Simple
simple_max <- ldply(t1_simple, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "simple"))
	}, .progress = 'text')
simple_max$cv <- 1
# ------------------------------
# VD
vd_max <- ldply(t1_vd, function(x) {
		amax <- arg_max(x$data)
		return(data.frame(a=x$params$a, b=x$params$b, sA=x$params$sA, Fec = x$params$Fec, juvshape = NA, corr = NA, mstar = amax[[1]], amax_y = amax[[2]], sim_id = x$params$sim_id, type = "vd"))
	}, .progress = 'text')
vd_max$cv <- 1
# ------------------------------

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



message("Calculating arg max for t1_juvshape \n")
# removing empties from juvshape

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






# Removing empty results from t1_corr1b
message("Calculating arg max for t1_corr1b \n")
x2 <- ldply(t1_corr1b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor1 <- t1_corr1b[-which(x2$V1==0)] } else {
		t1_cor1 <- t1_corr1b
	}

# Removing empty results from t1_corr2b
message("Calculating arg max for t1_corr2b \n")
x2 <- ldply(t1_corr2b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor2 <- t1_corr2b[-which(x2$V1==0)] } else {
		t1_cor2 <- t1_corr2b
	}


# Removing empty results from t1_corr3b
message("Calculating arg max for t1_corr3b \n")
x2 <- ldply(t1_corr3b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor3 <- t1_corr3b[-which(x2$V1==0)] } else {
		t1_cor3 <- t1_corr3b
	}

# Removing empty results from t1_corr4b
message("Calculating arg max for t1_corr4b \n")
x2 <- ldply(t1_corr4b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor4 <- t1_corr4b[-which(x2$V1==0)] } else {
		t1_cor4 <- t1_corr4b
	}

# Removing empty results from t1_corr5b
message("Calculating arg max for t1_corr5b \n")
x2 <- ldply(t1_corr5b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor5 <- t1_corr5b[-which(x2$V1==0)] } else {
		t1_cor5 <- t1_corr5b
	}

# Removing empty results from t1_corr6b
message("Calculating arg max for t1_corr6b \n")
x2 <- ldply(t1_corr6b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor6 <- t1_corr6b[-which(x2$V1==0)] } else {
		t1_cor6 <- t1_corr6b
	}

# Removing empty results from t1_corr7b
message("Calculating arg max for t1_corr7b \n")
x2 <- ldply(t1_corr7b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor7 <- t1_corr7b[-which(x2$V1==0)] } else {
		t1_cor7 <- t1_corr7b
	}

# Removing empty results from t1_corr8b
message("Calculating arg max for t1_corr8b \n")
x2 <- ldply(t1_corr8b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor8 <- t1_corr8b[-which(x2$V1==0)] } else {
		t1_cor8 <- t1_corr8b
	}

# Removing empty results from t1_corr9b
message("Calculating arg max for t1_corr9b \n")
x2 <- ldply(t1_corr9b, length)
if(length(which(x2$V1==0))>0) {
	t1_cor9 <- t1_corr9b[-which(x2$V1==0)] } else {
		t1_cor9 <- t1_corr9b
	}


corr_max1 <- ldply(t1_cor1, process_mstar_cv, .progress = 'text')
corr_max1 <- remove_bad(corr_max1)

corr_max2 <- ldply(t1_cor2, process_mstar_cv, .progress = 'text')
corr_max2 <- remove_bad(corr_max2)

corr_max3 <- ldply(t1_cor3, process_mstar_cv, .progress = 'text')
corr_max3 <- remove_bad(corr_max3)

corr_max4 <- ldply(t1_cor4, process_mstar_cv, .progress = 'text')
corr_max4 <- remove_bad(corr_max4)

corr_max5 <- ldply(t1_cor5, process_mstar_cv, .progress = 'text')
corr_max5 <- remove_bad(corr_max5)

corr_max6 <- ldply(t1_cor6, process_mstar_cv, .progress = 'text')
corr_max6 <- remove_bad(corr_max6)

corr_max7 <- ldply(t1_cor7, process_mstar_cv, .progress = 'text')
corr_max7 <- remove_bad(corr_max7)

corr_max8 <- ldply(t1_cor8, process_mstar_cv, .progress = 'text')
corr_max8 <- remove_bad(corr_max8)

corr_max9 <- ldply(t1_cor9, process_mstar_cv, .progress = 'text')
corr_max9 <- remove_bad(corr_max9)



corr_max <- rbind(corr_max1, corr_max2, corr_max3, corr_max4, corr_max5, corr_max6, corr_max7, corr_max8, corr_max9)


# ------------------------------
all <- rbind(simple_max, vd_max, juvshape_max, corr_max)
message(sprintf("All currently has dim %s %s \n",dim(all)[1], dim(all)[2]))
# Remove any items that were not computed.
bad <- apply(all, 1, function(x) !any("Nan" %in% x))
cleaned_all <- all[bad, ]
message(sprintf("All currently has dim %s %s \n",dim(cleaned_all)[1], dim(cleaned_all)[2]))
cleaned_all <- data.table(all)
save(cleaned_all, file="all_results.rda")

