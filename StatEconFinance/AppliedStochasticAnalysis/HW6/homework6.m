
%% Question 4c

% Number of samples
N = 1000000;

% The values of r to loop over and corresponding mus
rs  = [3 5 10 20 25 30];
mus = rs + 2;

% This will hold the values of the integral for each block and r
I = nan(1, length(rs));

% Draw normals

% Loop over values of r
for i_ = 1:length(rs)

  r  = rs(i_);
  mu = mus(i_);

  % Random draws
  x1 = randn(N,1) + mu;
  x2 = randn(N,1) + mu;

  % Compute numerator and denominator
  I_num   = mean(x1.^2 .* (x1 > r) ...
              .* exp(-(1/2)*((2*x1*mu - mu^2))));
  I_denom = mean((x2 > r) .* exp(-(1/2)*((2*x2*mu - mu^2))));

  % Store integral
  I(i_) = I_num / I_denom;

end
