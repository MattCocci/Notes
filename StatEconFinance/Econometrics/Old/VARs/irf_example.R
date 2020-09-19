###################################################
## IRF Example ####################################
###################################################

# This code generates an IRF for a simple AR(1)
# process 
#
#   y_t = p * y_{t-1} + e 
#
# using the same variance, but changing
# the autocorrelation parameter, p.
# 
# For the jth ahead obs (after the shock at t), the 
# irf simplifies to
#
#   IRF(j) = s * p^j
#
# where s = var(e) 

###################################################

irf <- function(j, rho, s){
    return(s*(rho^j))
}

# Parameters
rhos <- c(0, 0.5, 0.75, 0.95, 1) 
s <- 1
j <- 15 


# To hold the observations
irf_mat <- matrix(0, j+1, length(rhos))


# Compute irfs given different rhos
for(i in 1:length(rhos)){
    rho.vec <- rep(rhos[i], j+1)
    s.vec   <- rep(s, j+1)
    j.vec   <- 0:j 
    irf_mat[,i] <- irf(j.vec, rho.vec, s.vec)
}


# Plot the irfs
colors=c("green", "orange", "blue", "red", "black")
legend_labs = c()
text_locs = c(c(0.1, 0.15), c(4, 0.18), c(7.5, 0.25), c(10, 0.4),
              c(12.5, 0.8))


pdf('irf_example.pdf', width=8, height=4)
for(i in 1:length(rhos)){
    if(i == 1){
        plot(0:j, irf_mat[,i], type='o', col=colors[i],pch=21,
         main=expression(paste('IRF Example for AR(1), ', sigma, ' = 1')), 
         xlab='Periods after Shock', ylab='Impulse Response')
    } else {
        lines(0:j, irf_mat[,i], type='o', col=colors[i],pch=21)
    }
    # Add label
    rho = rhos[i]
    text(text_locs[2*i-1], text_locs[2*i],
         bquote(rho==.(rho)), col=colors[i])
}
dev.off()


