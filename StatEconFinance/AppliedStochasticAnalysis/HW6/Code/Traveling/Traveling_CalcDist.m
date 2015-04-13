% Calculate the total distance for a path
function [ d ] = Traveling_CalcDist(D, trip)
  d = 0;
  for s = 1:length(trip)-1
    d = d + D(trip(s), trip(s+1));
  end
end
