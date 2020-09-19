%% This writes a trip to a csv file so that R can read it in and plot on
%  a map
function [ ] = Traveling_PlotTrip(L, trip, names, saving)

  f = fopen('Trip.csv', 'w');
  for t = trip
    fprintf(f, '%s,%3.9f,%3.9f\n', names{t}, L(t,1), L(t,2));
  end
  fclose(f);

  %system(['Rscript Traveling_PlotTrip.R ' saving])

end
