%% Matt Cocci - Matlab/Octave Code for Traveling Salesman Problem,
%  Question 8

%% Load the data
Traveling_Data;

%% Initialize a starting distance
starting.trip = randperm(Nlocations);
starting.dist = Traveling_CalcDist(D, starting.trip);

%% Plot a sample starting path
Traveling_PlotTrip(L, starting.trip, names, 'ExampleStarting.pdf')

%% 8a. Different Constant Betas

  % Initialize
  N          = 10000;
  %betas      = [0.0001 0.001 0.01 0.1 1.0 10 100];
  %betas      = [0.01 0.05 0.1 0.5 1.0 5 10];
  betas      = [0.001 0.002 0.004 0.006 0.008 0.01];
  trips      = struct('trip', repmat({''}, N, length(betas)), ...
                      'dist', nan(N, length(betas)));
  trips(1,:) = starting; % Initialize all with same starting point
  prop_type  = 1; % Proposal type: Randomly swapping 2
  accepts    = nan(N,length(betas));

  % Run optimization, looping over different values of beta
  for b = 1:length(betas)
    beta = betas(b);
    fprintf('Trying beta = %9f\n', beta);

    % Loop over number of iterations
    for n = 1:N-1
      [trips(n+1, b), accepts(n+1,b)] = ...
        Traveling_MHStep(D, beta, trips(n, b), prop_type);
    end
  end

  % Plot the different values of beta against each other
  alldists = reshape([trips.dist], N, []);
  plot(alldists)
  labels = arrayfun(@(b) sprintf('\\beta = %9.4f',b), betas, 'UniformOutput', 0);
  ylabel('Total Distance d(c), Miles');
  xlabel('Number of Iterations');
  legend(labels);
  set(gca, 'FontSize', 12)
  print(gcf, '-dpdf', 'q8a_1.pdf')

  % Calculate and display acceptances
  accepted = nanmean(accepts);
  for b = 1:length(betas)
    fprintf('Beta = %9.4f: %9.4f\n', betas(b), accepted(b));
  end


  % Plot the sample path of the best beta
  alltrips = nan(N, Nlocations, length(betas));
  for n = 1:N
    for b = 1:length(betas)
      alltrips(n,:,b) = trips(n,b).trip;
    end
  end
  [bestdists, iter] = min(alldists);
  [bestbest,  b]    = min(bestdists);
  Traveling_PlotTrip(L, trips(iter(b),b).trip, names, 'q8a_2.pdf')


%% 8b. Changing the Temperature

  % Initialize
  N          = 10000;
  Nbtypes    = 2; % Number of types of betas: periodic and annealing
  trips      = struct('trip', repmat({''}, N, Nbtypes), ...
                      'dist', nan(N, Nbtypes));
  trips(1,:) = starting; % Initialize all with same starting point
  prop_type  = 1; % Proposal type: Randomly swapping 2
  accepts    = nan(N,1);

  % Set up the betas
  betas = nan(N,Nbtypes);
  betas(:,1) = 5*sin((pi/4)*[1:N]) + 5.01;
  %betas(:,2) = 1.005;
  betas(:,2) = 1.001;
  betas(1,2) = 0.001;
  betas(:,2) = cumprod(betas(:,2));

  % Run optimization, looping over different values of beta
  for b = 1:Nbtypes
    for n = 1:N-1
      [trips(n+1, b), accepts(n+1)] = ...
        Traveling_MHStep(D, betas(n,b), trips(n, b), prop_type);
    end
  end

  % Plot annealing vs period
  alldists = reshape([trips.dist], N, []);
  plot(alldists)
  legend('Periodic', 'Annealing');
  ylabel('Total Distance d(c), Miles');
  xlabel('Number of Iterations');
  set(gca, 'FontSize', 12)
  print(gcf, '-dpdf', 'q8b_1.pdf')

