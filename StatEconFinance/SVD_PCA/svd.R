########################################################################

# Purpose: Generate charts useful for SVD intuition
# - Matthew D. Cocci, 9/17/14

########################################################################
library(ggplot2)
library(grid)
source('multiplot.R')

# Bounds for our grid
bds <- c(-5,5)

# Generate a grid of points
pts <- expand.grid(seq(bds[1], bds[2]), seq(bds[1], bds[2]))

# Function to plot grid and transformations of the grid
gen_plot <- function(vec, pts, A=diag(2)) {

  pts.forplot <- t(A %*% t(pts))
  vec.forplot <- t(A %*% matrix(vec, 2, 1))

  fig <- ggplot()
  fig <- fig + geom_point(data.frame(x=pts.forplot[,1], y=pts.forplot[,2]),
                mapping=aes(x,y), color=I('navy'), na.rm=TRUE)
  fig <- fig + geom_segment(data.frame(x=vec.forplot[1], y=vec.forplot[2]),
                mapping=aes(x=0, y=0, xend=x, yend=y),
                arrow=arrow(length=unit(0.5,'cm')))
  fig <- fig + labs(x="", y="") +
           xlim(2*bds[1], 2*bds[2]) + ylim(2*bds[1], 2*bds[2])
}

# Return an abline aligned along the eigenvectors 
eig_lines <- function(A) {
  eig <- eigen(A)
  m <- lapply(c(1,2), function(i) eig$vectors[2,i]/eig$vectors[1,i])
  lapply(c(1,2), function(i) geom_abline(slope=m[[i]]))
}


A <- rbind(c(2,0), c(0,3))
fig1a <- gen_plot(c(2,1), pts)
fig1b <- gen_plot(c(2,1), pts, A) 
multiplot(fig1a, fig1b, layout=matrix(c(1,2), 1, 2))


A <- rbind(c(2,1), c(1,0))
fig2a <- gen_plot(c(2,1), pts)
fig2b <- gen_plot(c(2,1), pts, A)
multiplot(fig2a, fig2b, layout=matrix(c(1,2), 1, 2))
