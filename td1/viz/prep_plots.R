rm(list=ls())
library(plyr)
suppressPackageStartupMessages(library(data.table))
setwd('~/Github/postdoc/tradeoff/td1/viz')
source('../analysis/tfunctions.R')
load('../results/t1_simple_2012-07-24_19_40_49.rdata')
load('../results/t1_vd_2012-07-24_19_41_14.rdata')
load('../results/t1_juv_2012-07-24_19_49_26.rdata')
load('../results/t1_corr_2012-07-24_20_12_45.rdata')





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

xx <- ldply(t1_juvshape, function(x) class(x[[1]]))
keep <- which(xx$V1=="data.frame")
t1_juvshape <- t1_juvshape[keep]


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
# ------------------------------cleaning up juvshape.

remove_bad <- function(all) {
keep <- apply(all, 1, function(x) !any("Nan" %in% x))
cleaned_all <- all[keep, ]
return(cleaned_all)
}

juvshape_max <- ldply(t1_juvshape, process_mstar_juvshape, .progress = 'text')
juvshape_max <- remove_bad(juvshape_max)

# ------------------------------working through the mstar of corr.
process_mstar_cv <- function(x) {
		# message(sprintf("%s, %s", class(x$data), dim(x$data)[1]))
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
# corr_data <- llply(t1_corr, function(x) class(x[1]))
# corr_data <- ldply(corr_data)
# index <-which(corr_data$V1=="character")
# t1_corr2 <- t1_corr[-index]
# t1_corr <- t1_corr2
# save(t1_corr, file="cleaned_t1_corr.rdata")
# Removing empty results from t1_corr
message("Calculating arg max for t1_corr \n")
x2 <- ldply(t1_corr, length)
if(length(which(x2$V1==0))>0) {
	t1_cor1 <- t1_corr[-which(x2$V1==0)] } else {
		t1_cor1 <- t1_corr
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



# Saving individual results in separate data tables
working_corr <- data.table(ldply(t1_corr, function(x) data.frame(x[[2]]), .progress='text'))
working_js <- data.table(ldply(t1_juvshape, function(x) data.frame(x[[2]]), .progress = 'text'))
working_vd <- data.table(ldply(t1_vd, function(x) data.frame(x[[2]]), .progress = 'text'))
working_simple <- data.table(ldply(t1_simple, function(x) data.frame(x[[2]]), .progress = 'text'))

# Setting keys to make them sortable.
setkeyv(working_corr, "sim_id")
setkeyv(working_js, "sim_id")
setkeyv(working_vd, "sim_id")
setkeyv(working_simple, "sim_id")

# Saving the files to disk.
save(working_vd, file="working_vd.rdata")
save(working_corr, file="working_corr.rdata")
save(working_js, file="working_js.rdata")
save(working_simple, file="working_simple.rdata")

# Next run generate_all_plots.R to visualize these results.
# ------------------------------------------------------------------
pdf("tradeoff_plot.pdf", width = 8, height = 6) 
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 5)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y) 
print(plota, vp = vplayout(1:2, 1:2)) 
print(plota, vp = vplayout(1, 3)) 
print(plota, vp = vplayout(1, 4))
print(plota, vp = vplayout(1, 5))
print(plota, vp = vplayout(2, 3)) 
print(plota, vp = vplayout(2, 4))
print(plota, vp = vplayout(2, 5))
print(plota, vp = vplayout(3, 1))
print(plota, vp = vplayout(3, 2))
print(plota, vp = vplayout(3, 3))
print(plota, vp = vplayout(3, 4))
print(plota, vp = vplayout(3, 5))
dev.off()