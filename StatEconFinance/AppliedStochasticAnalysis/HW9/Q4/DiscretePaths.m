function [X,P,dWs] = DiscretePaths(t0, T, dt, X_t0)

% Generate partition of interval [t0,T] into sub-intervals of size dt
P      = t0:dt:T;
nsteps = length(P)-1; % Number of sub-intervals/steps we'll make

% Generate random draws/path
dWs = sqrt(dt)*randn(nsteps,1);

% Initialize paths
X = [X_t0; nan(nsteps,1)];

end

