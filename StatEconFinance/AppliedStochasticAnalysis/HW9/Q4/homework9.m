%% Matt Cocci
%
% Matlab Code for HW9

%% Parameters
lambda = 2;
mu     = 1;

%% Define the drift and diffusion functions

  % Geometric Brownian Motion
  b      = @(x,t) lambda*x; % Function for the drift
  sigma  = @(x,t) mu*x;     % Function for the diffusion
  dsigma = @(x,t) mu;       % Function for derivative of diffusion
  soln   = @(x0, t, W) x0*exp( (lambda-(mu^2)/2)*t + mu*W ); % Function for the soln of GBM
  EX     = @(x0, t) x0*exp(lambda*t); % Function for the mean of GBM

  % Ornstein-Uhlenbeck
  %b     = @(x,t) -1*x;
  %sigma = @(x,t) 1;


%% Question 4:

  %% Set parameters of sample path
  X_t0 = 1; % Starting value
  t0   = 0; % Starting time
  T    = 5; % Ending time
  N    = 2000; % Number of samples when doing weak and strong convergence
  step_sizes = cumprod(0.1*ones(3,1));


  %% Sample Path Plots
  % - Generate plots of sample paths for analytical vs. EM at different
  %   step size
  plot_sample_paths = 0;
  if plot_sample_paths
    label = {'EM'; 'Milstein'};
    index  = [2 3];

    for method = 1:length(label)
      figure()
      resize_plot;

      % Number of sample paths to generate and plot per step size
      npaths = 2;
      colors = jet(npaths);

      % Loop over sizes of dt and plot sample paths
      for s = 1:length(step_sizes)
        subplot(ceil(length(step_sizes)/2), 2, s)
        hold on

        % Generate sample paths and plot
        for p = 1:npaths
          X = SimulateAll(t0, T, step_sizes(s), X_t0, soln, EX, b, sigma, dsigma);

          plot(log(X(:,1)), '-', 'Color', colors(p,:))
          plot(log(X(:,index(method))), '--', 'Color',  colors(p,:))
        end
        title(sprintf('log( X_t ), dt = %1.10g', step_sizes(s)));
        legend('Analytical', label{method}, 'Location', 'SouthEast')
        set(gca, 'FontSize', 12)
        hold off
        set(gcf, 'PaperPositionMode', 'auto');
        print(gcf, '-dpdf', ['SamplePaths' label{method} '.pdf']);
      end
    end
  end


  %% Absolute Convergence
  redraw = 1;
  if redraw
    strong.em  = nan(N,length(step_sizes));
    strong.mil = nan(N,length(step_sizes));
    weak.data  = cell(length(step_sizes),1);
    weak.mean_em{s}  = cell(length(step_sizes),1);
    weak.mean_mil{s} = cell(length(step_sizes),1);

    for s = 1:length(step_sizes)
      fprintf('Simulating dt = %.10g\n', step_sizes(s));

      % Inialize matrix to hold paths for weak case
      weak.data{s} = nan(N, length(t0:step_sizes(s):T), 4);
      for n = 1:N
        X = SimulateAll(t0, T, step_sizes(s), X_t0, soln, EX, b, sigma, dsigma);

        % Compute abs diff between EM and Analytical; take mean
        strong.em(n,s)  = mean(abs(X(:,1)-X(:,2)));

        % Compute abs diff between Milstein and Analytical; take mean
        strong.mil(n,s) = mean(abs(X(:,1)-X(:,3)));

        % For the nth draw of steps size s, store the paths; we'll take
        % the mean later across n
        weak.data{s}(n,:,1) = X(:,1);
        weak.data{s}(n,:,2) = X(:,2);
        weak.data{s}(n,:,3) = X(:,3);
        weak.data{s}(n,:,4) = X(:,4);
      end

      % Store analytical mean of the process
      weak.mean{s} = weak.data{s}(1,2:end,4);

      % Take mean of function at all time points
      weak.mean_em{s}  = mean(weak.data{s}(:,2:end,2), 1);
      weak.mean_mil{s} = mean(weak.data{s}(:,2:end,3), 1);

    end
  end


  %% Plot strong convergence plots
  methods = {'em', 'mil'};
  methods_names = {'EM'; 'Milstein'};

  for m = 1:length(methods)
    x = repmat(step_sizes', size(strong.(methods{m}),1), 1); x = x(:);
    y = strong.(methods{m}); y = y(:);
    x_log = log10(x);
    y_log = log10(y);

    figure()

    % Plot sample points on log scale
    loglog(x, y, 'o')
    hold on

    % Get alpha
    coeffs = regress(y_log, [ones(length(y_log),1), x_log]);
    logC   = coeffs(1);
    alpha  = coeffs(2);

    % Plot line of best fit
    xl = [step_sizes(end)-step_sizes(end)/2, step_sizes(1)+0.1];
    plot(xl, (10^logC)*(xl.^alpha), 'r')

    % Axes and legend
    set(gca, 'xlim', xl);
    legend('Samples', sprintf('Line of Best Fit, \\alpha = %1.2f', alpha), 'Location', 'NorthWest')
    title([methods_names{m} ' Method'], 'FontSize', 16)
    set(gca, 'FontSize', 12)
  end




