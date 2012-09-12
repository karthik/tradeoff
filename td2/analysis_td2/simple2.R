# simple.R
source('initialize2.R')

# total_cores <- 60
# t2_simple <- llply(basic_params, do_tradeoff, mc.cores = total_cores, mc.preschedule = TRUE)
t2_simple <- llply(basic_params, do_tradeoff, .progress = 'text')

fname1 <- generate_filename("../results_td2/t2_simple")
save(t2_simple, file=fname1)

# llply(sample(basic_params, 1), do_tradeoff)


working_sims <- ldply(t2_simple, function(x) {
	if(!is.null(x$data)) {
		    lam <- x$data[, 3]
		    lam2 <- c(x$data[1:dim(x$data)[1]-1, 3],0)

			if(any(lam-lam2<0)) {
			  return(data.frame(x$params))
			}
		}
	})
