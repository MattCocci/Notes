%% Load the data
Traveling_Data;

%% Initialize a starting distance
starting.trip = randperm(Nlocations);
starting.dist = Traveling_CalcDist(D, starting.trip);

%% Plot a sample starting path
Traveling_PlotTrip(L, starting.trip, names, 'ExampleStarting.pdf')

%% 8a. Different Constant Betas

  % Initialize
  N          = 5000;
  betas      = [0.0001 0.001 0.01 0.1 1.0 10 100];
  trips      = repmat(struct(), N, length(betas));
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
  print(gcf, '-dpdf', 'q8a_1.pdf')

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
  N          = 5000;
  Nbtypes    = 2; % Number of types of betas: periodic and annealing
  trips      = repmat(struct(), N, Nbtypes);
  trips(1,:) = starting; % Initialize all with same starting point
  prop_type  = 1; % Proposal type: Randomly swapping 2
  accepts    = nan(N,1);

  % Set up the betas
  betas = nan(N,Nbtypes);
  betas(:,1) = 10*sin((-pi*N/8):pi/4:(pi*(N-1)/8));
  betas(:,2) = 1.005;
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
  print(gcf, '-dpdf', 'q8b_1.pdf')

