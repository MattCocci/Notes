#############################################

# Generates Plot of Cantor's Devil Staircase

#############################################


# Steps
#   1. Take interval matrix, step over rows and put middle 
#       third in matrices. Put remaining in new matrix.
#   2. Figure out number of segment to plot at this stage.
#   3. Space them and plot them accordingly
#   4. Output is matrix containing remaining segments as rows, 
#       endpoints as columns.
#   5. Return to step 1


# Function to loop over matrix where rows are remaining segments.
# Output:
#   1. Plot Matrix
#   2. Remaining matrix
cantor.step <- function(in.matrix){

    # Number of stages of removals done so far
    n.stages <- log(nrow(in.matrix), base=2)

    # Number of new segments; initialize out matrix
    n.seg <- 2*nrow(in.matrix)
    out.matrix <- matrix(0,n.seg,2)

    # Length of new segments
    seg.length <- 1/(3^(n.stages+1))

    # Indicators for new segments close to 0 or 1
    near0 <- as.logical(matrix(rbind(rep(1,n.seg/2),rep(0,n.seg/2)),n.seg,1))
    near1 <- !near0

    # Assign values to matrix   
    out.matrix[near0,] <- in.matrix
    out.matrix[near1,] <- in.matrix
    plot.matrix <- in.matrix

    # Add and subtract lengths
    out.matrix[near0,2] <- out.matrix[near0,1] + seg.length 
    out.matrix[near1,1] <- out.matrix[near1,2] - seg.length 
    plot.matrix[,1] <- plot.matrix[,1] + seg.length + 1e-3
    plot.matrix[,2] <- plot.matrix[,2] - seg.length - 1e-3

    list(plot.matrix,out.matrix)
}


# Loop through and plot
n.removals <- 9
in.matrix <- matrix(c(0,1),1,2)
plot(1,type="n",xlim=c(0,1),ylim=c(0,1),xlab="",ylab="")
for(i in 1:n.removals){

    output <- cantor.step(in.matrix) 
    plot.matrix <- output[[1]]
    in.matrix <- output[[2]]
    
    ylocs <- seq(1,2^i,2)/(2^i)

    for(j in 1:(2^(i-1))){
        lines(plot.matrix[j,],rep(ylocs[j],2))
    }
}

