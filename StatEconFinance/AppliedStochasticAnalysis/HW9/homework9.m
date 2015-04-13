
%% Parameters
lambda = 2;
mu     = 1;

%% Define the drift and diffusion functions

  % Geometric Brownian Motion
  b     = @(x,t) lambda*x;
  sigma = @(x,t) mu*x;
  soln  = @(x0, t, W) x0*exp( (lambda-(mu^2)/2)*t + mu*W );

  % Ornstein-Uhlenbeck
  %b     = @(x,t) -1*x;
  %sigma = @(x,t) 1;


%% Question 4a: Run Euler-Maruyama

  % Set parameters of sample path
  X_t0 = randn(1); % Starting value
  t0   = 0; % Starting time
  T    = 10; % Ending time
  step_sizes = cumprod(0.1*ones(6,1));

  % Generate plots of sample paths at different step sizes
  npaths = 3; % Number of sample paths to generate
  colors = jet(npaths);
  subplot(ceil(length(step_sizes)/2), 2, 1)

  for s = 1:length(step_sizes)
    subplot(ceil(length(step_sizes)/2), 2, s)
    hold on
    for p = 1:npaths % Generate sample paths and plot
      plot( log( EulerMaruyama(t0,T,step_sizes(s),rand(1),b,sigma) ),...
            'Color', colors(p,:));
    end
    hold off
  end


