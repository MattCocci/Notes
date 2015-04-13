
%% Parameters
lambda = 2;
mu     = 1;

%% Define the drift and diffusion functions

  % Geometric Brownian Motion
  b      = @(x,t) lambda*x; % Function for the drift
  sigma  = @(x,t) mu*x;     % Function for the diffusion
  dsigma = @(x,t) mu;     % Function for derivative of diffusion
  soln  = @(x0, t, W) x0*exp( (lambda-(mu^2)/2)*t + mu*W );

  % Ornstein-Uhlenbeck
  %b     = @(x,t) -1*x;
  %sigma = @(x,t) 1;


%% Question 4a: Run Euler-Maruyama

  % Set parameters of sample path
  X_t0 = 1; % Starting value
  t0   = 0; % Starting time
  T    = 5; % Ending time
  N    = 100; % Number of samples
  step_sizes = cumprod(0.1*ones(3,1));

  % Generate plots of sample paths for analytical vs. EM at different
  % step sizes
  if 0
    npaths = 2; % Number of sample paths to generate
    colors = jet(npaths);
    subplot(ceil(length(step_sizes)/2), 2, 1)

    for s = 1:length(step_sizes)
      subplot(ceil(length(step_sizes)/2), 2, s)
      hold on
      for p = 1:npaths % Generate sample paths and plot
        X = SimulateAll(t0, T, step_sizes(s), X_t0, soln, b, sigma, dsigma);

        plot(log(X(:,1)), '--', 'Color', colors(p,:))
        plot(log(X(:,2)), ':', 'Color', colors(p,:))
      end
      legend('Analytical Solution', 'EM')
      hold off
    end
  end

  errors_em  = nan(N,length(step_sizes));
  errors_mil = nan(N,length(step_sizes));
  for s = 1:length(step_sizes)
    fprintf('Simulating dt = %9.6f\n', step_sizes(s));
    fflush(stdout);
    for n = 1:N
      X = SimulateAll(t0, T, step_sizes(s), X_t0, soln, b, sigma, dsigma);
      errors_em(n,s)  = mean(abs(X(:,1)-X(:,2)));
      errors_mil(n,s) = mean(abs(X(:,1)-X(:,3)));
    end
  end

  figure()
  hold on
  x = log(repmat(step_sizes', size(errors_em,1), 1));
  y = log(errors_em);
  for s = 1:length(step_sizes)
    plot(x(:,s), y(:,s), 'o')
  end

