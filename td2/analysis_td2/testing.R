tradeoff
fec.from.sA <- function(a =a, b=b, sA=sA) {
    return(a + b * (sA))
}

# ---------------------------------------------------
# Calculate lamba from a basic matrix model
dem.model <- function(m, sJ, sA, Fec) {
    # message(sprintf("\n %s, %s, %s, %s", m, sJ,sA, Fec))
    mat <- matrix(c((1 - m) * sJ, m * sJ, Fec, sA), nrow = 2)
    return(max(eigen(mat)$values))
}

 # ---------------------------------------------------
 # Imposing the tradeoff for a simple matrix case
tradeoff <- function(a, b, sJ, m, sA = NULL) {
    if (is.null(sA))
    sA <- seq(0.1, 0.9, length = 20)
    Fec <- fec.from.sA( a = a, b = b, sA = sA)
    df <- as.matrix(data.frame(m = m, sJ = sJ, sA = sA, Fec = Fec))
    lambda <- apply(df, 1, function(x) dem.model(x[1], x[2], x[3], x[4]))
    type <- "simple"
    return((data.frame(sA, Fec, lambda, cv = 1, type)))
}

# ------------------------------------
dem.model(.3, .5, .1, 50)
dem.model(.3, .5, .2, 49)
dem.model(.3, .5, .3, 48)
dem.model(.3, .5, .4, 47)
dem.model(.3, .5, .5, 45)
dem.model(.3, .5, .6, 43)
dem.model(.3, .5, .7, 41)
dem.model(.3, .5, .8, 39)
dem.model(.3, .5, .9, 37)
# ------------------------------------

sA <- seq(0.1, 0.9, length=100)
Fec <- rev(seq(35,50, length=100))
m <- rep(.3, 100)
sJ <- rep(0.5, 100)
df <- data.frame(m,sJ,sA,Fec)
lambda=apply(df, 1, function(x) dem.model(x[1], x[2], x[3], x[4]))
df$lambda <- lambda
ggplot(df, aes(sA,lambda)) + geom_point()
