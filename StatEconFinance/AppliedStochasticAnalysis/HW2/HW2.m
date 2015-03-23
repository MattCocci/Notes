N   = 1000000;
tau = zeros(N,1);

for n = 1:N
  t   = 0;
  X_t = 0;
  while abs(X_t) < 6
    t = t + 1;

    draw = (randperm(2,1)==1); % Indicator for a negative draw
    e    = -1*draw + 1*(1-draw);
    X_t  = X_t + e;
  end
  tau(n) = t;
end

fprintf('Mean hitting time: %9.2f\n', mean(tau));
fprintf('Std Err hitting time: %9.2f\n', std(tau)/sqrt(N));

