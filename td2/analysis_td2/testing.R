source('tfunctions2.R')

fec.from.sA <- function(a =a, b=b, sA=sA) {  
    Fec <- a + b*(1-sA)
    return (100*Fec)
}

# ---------------------------------------------------
# Calculate lamba from a basic matrix model
dem.model <- function(m, sJ, Fec, sA) {
    message(sprintf("\n %s, %s, %s, %s", m, sJ,Fec, sA))
    mat <- matrix(c((1 - m) * sJ, m * sJ, Fec, sA), nrow = 2)
    return(max(eigen(mat)$values))
}

 # ---------------------------------------------------
 # Imposing the tradeoff for a simple matrix case
tradeoff <- function(a, b, sJ, m, sA = NULL) {
    if (is.null(sA))
    sA <- seq(.99, .01, length = 20)
    Fec <- fec.from.sA( a = a, b = b, sA = sA)
    df <- as.matrix(data.frame(m = m, sJ = sJ, sA = sA, Fec = Fec))
    lambda <- apply(df, 1, function(x) dem.model(x[1], x[2], x[4], x[3]))
    type <- "simple"
    return((data.frame(sA, Fec, lambda, cv = 1, type)))
}

tradeoff(0.8, -0.8, 0.7, 0.7, sA=NULL)
tradeoff(0.9, -0.8, 0.1, 0.1, sA=NULL)
tradeoff(0.9, -0.8, 0.5, 0.3, sA=NULL)
tradeoff(0.9, -0.8, 0.6, 0.3, sA=NULL)
tradeoff(0.9, -0.8, 0.7, 0.3, sA=NULL)
