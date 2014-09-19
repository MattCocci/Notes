########################################################################

# Purpose: Generate charts useful for SVD intuition
# - Matthew D. Cocci, 9/17/14

########################################################################

# Generate matrix that is a long sequence of (x,y) pairs repping a grid
bds <- c(-5,5)
pts <- expand.grid(seq(bds[1], bds[2]), seq(bds[1], bds[2]))



