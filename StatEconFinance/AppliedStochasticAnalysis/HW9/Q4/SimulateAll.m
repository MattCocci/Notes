function [X] = SimulateAll(t0, T, dt, X_t0, soln, b, sigma, dsigma)

% Generate partition of interval [t0,T] into sub-intervals of size dt
P      = t0:dt:T;
nsteps = length(P)-1; % Number of sub-intervals/steps we'll make

% Generate random draws/path
dWs = sqrt(dt)*randn(nsteps,3);

% Initialize paths
X = [X_t0*ones(1,3); nan(nsteps,3)];

for t = 1:nsteps

  % The left-endpoint of the interval
  Pt = P(t);

  % Analytical Solution
  Xt = X(t,1); % Get last analytical step
  X(t+1,1) = soln(Xt, dt, dWs(t));

  % Euler-Maruyama
  Xt = X(t,2); % Get last euler-maruyama step
  X(t+1,2) = Xt + b(Xt,Pt)*dt + sigma(Xt,Pt)*dWs(t);

  % Milstein
  Xt = X(t,3);  % Get last milstein step
  X(t+1,3) = X_t0 + b(Xt,Pt)*dt + sigma(Xt,Pt)*dWs(t) ...
          + (1/2)*sigma(Xt,Pt) * dsigma(Xt,Pt) * ((dWs(t))^2-dt);

end

end


