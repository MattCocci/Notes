%% This is the key function to take an old sequence of cities, propose a
%  new one, then accept or reject
function [ new, accept ] = ...
  Traveling_MHStep(D, beta, old, prop_type)

  % Initialize
  prop   = old;
  accept = 0;

  % Construct a proposal sequence
  switch prop_type
    case 1 % Exchange two randomly
      exchange = randperm(length(old.trip));
      prop.trip(exchange(1)) = old.trip(exchange(2));
      prop.trip(exchange(2)) = old.trip(exchange(1));
  end

  % Calculate distance of proposed trip
  prop.dist  = Traveling_CalcDist(D, prop.trip);

  % Accept reject
  delta_dist = prop.dist - old.dist;
  if delta_dist < 0
    new = prop;
    accept = 1;
  else
    u = rand(1);
    if u < exp(-beta*delta_dist)
      new = prop;
      accept = 1;
    else
      new = old;
    end
  end

  % Return new, which is either the proposed or the old sequence and
  % distance

end
