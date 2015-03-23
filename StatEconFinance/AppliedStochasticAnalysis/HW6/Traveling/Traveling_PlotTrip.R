library(maps)
library(mapdata)

# Retrieve arguments that provide the save name
args <- commandArgs(trailingOnly = TRUE);
save_name = args[1]

# Load the trip (that was written by Matlab, in order)
trip = read.csv('Trip.csv', header=FALSE)

# Set up the file to save to
pdf(args[1])

# Initialize a map of the US
map('worldHires', 'USA', xlim=c(-125,-65), ylim=c(25,50))

# Add the trip
lines(trip[,2], trip[,3], col='blue')
points(trip[,2], trip[,3], col='blue', pch=4)
jfactor = 10
text(jitter(trip[,2], factor=jfactor),
     jitter(trip[,3], factor=jfactor), labels=trip[,1], pos=4)
dev.off()
