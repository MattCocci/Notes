############################################
############################################

# Create plots for example improperly
#   integrable functions

############################################

# Triangles plot
b = 5
grid <- 1:b


# Triangle function: Takes grid of pts, returns x and y points to plot
triangle_function <- function(grid){

    one_pts <- grid[2:length(grid)]
    left_pts <- one_pts - 1/(one_pts^2)
    right_pts <- one_pts + 1/(one_pts^2)

    x_mat <- rbind(left_pts, one_pts, right_pts)
    x_vec <- as.vector(x_mat)

    y_mat <- rbind(rep(0, length(left_pts)), rep(1,length(one_pts)),
                   rep(0, length(right_pts)))
    y_vec <- as.vector(y_mat)

    return(rbind(c(0,0),cbind(x_vec,y_vec)))

}

to_plot <- triangle_function(grid)
pdf(file="TriangleFunction.pdf")
plot(to_plot[,1], to_plot[,2],type="l", ylim=c(0,1.5), lwd=2, col="blue", xlim=c(1,b), xlab="", ylab="", main="Example Function")
dev.off()


