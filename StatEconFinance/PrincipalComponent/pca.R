########################################

# Produces example charts for PCA note

# Generates data according to
#
#   y = a + b*x + e
#
# for n samples with e N(0,1)


########################################

# Parameters
a <- 5
b <- 1
n <- 20

# Generate data
e <- rnorm(n)
x <- 1:n
y <- a + b*x + e 

# Demean
x.demean <- x - mean(x)
y.demean <- y - mean(y)

# Limits
xlim <- c(round(min(x.demean))-1, round(max(x.demean))+1)
ylim <- c(round(min(y.demean))-1, round(max(y.demean))+1)

# Plot un-pca'd graph
plot(x.demean, y.demean, xlim=xlim, ylim=ylim, pch=19,col='blue', main='Demeaned
     Variables', xlab='x', ylab='y', bty='n')
lines(xlim, rep(0, length(xlim)), col='black')
lines(rep(0, length(ylim)), ylim, col='black')



