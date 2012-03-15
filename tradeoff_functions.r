# All functions necessary to calculate tradeoff curves.


# setting up a first tradeoff
sJ.from.m <- function(m, a, b) a + b*m ## b should be negative

tradeoff.curve <- function(a, b, m.grid = seq(0.01, 0.99, length = 20)) {
  sJ.grid <- lambda <- numeric(length(m.grid))
  for(i in seq_along(m.grid)) {
    m <- m.grid[i]
    sJ <- sJ.grid[i] <- sJ.from.m(m, a, b)
    A <- matrix(c( (1-m)*sJ, m*sJ, F, sA), nrow = 2) ## F and sA from globals
    lambda[i] <- max(eigen(A)$values)
  }
  data.frame(m = m.grid, sJ = sJ.grid, lambda = lambda)
}

tradeoff.plots <- function(tradeoff.df) {

	
}