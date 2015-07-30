% Generate a payoff function for a call with strike K
call = @(K) (@(S) max(S-K,0));

strikes   = [800 850 900 950 1000];
available = arrayfun(call, strikes, 'un', 0);
portfolio = [2   -2  -1  0   1];

% Payoff function with that portfolio
payoff = @(S) cellfun(@(call) call(S), available)*portfolio';

support = 750:5:1050;
plot(support, arrayfun(payoff,support))
