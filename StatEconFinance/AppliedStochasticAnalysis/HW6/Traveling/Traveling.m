%% Load the data
Traveling_Data;

%% Initialize a starting distance
starting.trip = randperm(13);
starting.dist = Traveling_CalcDist(D, starting.trip);
%Traveling_PlotTrip(L, starting, names)

%% 8a. Different Constant Betas

% Initialize
  N          = 5000;
  betas      = [0.0001 0.001 0.01 0.1 1.0 10 100];
  trips      = repmat(struct(), N, length(betas));
  trips(1,:) = starting; % Initialize all with same starting point
  prop_type  = 1; % Proposal type: Randomly swapping 2

% Run optimization, looping over different values of beta
for b = 1:length(betas)
  beta = betas(b);
  fprintf('Trying beta = %9f\n', beta);

  % Loop over number of iterations
  for n = 1:N-1
    trips(n+1, b) = Traveling_MHStep(D, beta, trips(n, b), prop_type);
  end
end

% Plot
plot(reshape([trips.dist], N, []))
labels = arrayfun(@(b) sprintf('\\beta = %9.4f',b), betas, 'UniformOutput', 0);
ylabel('Total Distance d(c), Miles');
xlabel('Number of Iterations');
legend(labels);
set(gca, 16);
