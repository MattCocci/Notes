function [X] = SimulateAll(t0, T, dt, X_t0, soln, EX, b, sigma, dsigma)

% Generate partition of interval [t0,T] into sub-intervals of size dt
P      = t0:dt:T;
nsteps = length(P)-1; % Number of sub-intervals/steps we'll make

% Generate random draws/path and scale
dWs = sqrt(dt)*randn(nsteps,1);
Ws  = cumsum(dWs);

% Initialize paths
X = [X_t0*ones(1,4); ...
     nan(nsteps,4)];

for t = 1:nsteps

  % The left-endpoint of the interval
  Pt = P(t);

  % Analytical Solution
  Xt = X(t,1); % Get last analytical step
  X(t+1,1) = soln(Xt, dt, dWs(t));    % Step to step
  %X(t+1,1) = soln(X_t0, Pt+dt, Ws(t)); % Alternative method; from t0

  % Euler-Maruyama
  Xt = X(t,2); % Get last euler-maruyama step
  X(t+1,2) = Xt + b(Xt,Pt)*dt + sigma(Xt,Pt)*dWs(t);

  % Milstein
  Xt = X(t,3);  % Get last milstein step
  X(t+1,3) = Xt + b(Xt,Pt)*dt + sigma(Xt,Pt)*dWs(t) ...
             + (1/2)*sigma(Xt,Pt) * dsigma(Xt,Pt) * ((dWs(t))^2-dt);

  % Expected value
  Xt = X(t,4);
  %X(t+1,4) = EX(Xt, dt);
  X(t+1,4) = EX(X_t0, Pt+dt);

end

end


