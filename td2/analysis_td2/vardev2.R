# vardev.R
source('initialize2.R')
# t2_vd <- mclapply(basic_params, do_vd_tradeoff, mc.cores=12, mc.preschedule=TRUE)
t2_vd <- llply(basic_params, do_vd_tradeoff, .progress = 'text')

fname2 <- generate_filename("../results_td2/t2_vd")
save(t2_vd, file = fname2)

# Testing to see how many have a tradeoff
 ldply(t2_vd, function(x) {
	if(!is.null(x$data)) {
		    lam <- x$data[, 3]
		    lam2 <- c(x$data[1:dim(x$data)[1]-1, 3],0)

			if(any(lam-lam2<0)) {
			  return(data.frame(x$params))
			}
		}
	})

