function [ new ] = ...
  Traveling_MHStep(D, beta, old, prop_type)

  prop = old;

  switch prop_type
    case 1 % Exchange two randomly
      exchange = randperm(length(old.trip));
      prop.trip(exchange(1)) = old.trip(exchange(2));
      prop.trip(exchange(2)) = old.trip(exchange(1));
  end

  prop.dist  = Traveling_CalcDist(D, prop.trip);

  delta_dist = prop.dist - old.dist;
  if delta_dist < 0
    new = prop;
  else
    u = rand(1);
    if u < exp(-beta*delta_dist)
      new = prop;
    else
      new = old;
    end
  end


end
