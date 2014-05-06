#############################################

# Generates Plot of Cantor's Devil Staircase

#############################################


# Function to remove the middle third, return the 

# Steps
#   1. Take a segment and a max height 
#   2. Remove the middle third
#   3. Plot that middle third at half the max height
#   4. Redefine segment and max height; return to 1

n.iter <- 100
max.height <- 1
segment <- c(0,1)

i <- 1
while (i < n.iter) {
    seg.len <- segment[2] - segment[1]
    mid.third <- c(segment[1]+seg.len/3, 
                   segment[2]-(seg.len)/3)
    max.height <- max.height / 2
    if (i==1) {
        plot(mid.third, c(max.height, max.height), type="l", 
             xlim=c(0,1), ylim=c(0,1))
    } else {
        lines(mid.third, c(max.height, max.height))
        lines(1-mid.third, c(3*max.height, 3*max.height))
    }
    segment = c(0, mid.third[1])
    i <- i+1
    readline()
}


