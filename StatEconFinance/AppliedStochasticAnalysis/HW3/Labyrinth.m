%% Set up Generator Matrix
Q = [...
 -2, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;...
  1,-3, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;...
  0, 1,-3, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;...
  0, 0, 1,-2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ;...
  1, 0, 0, 0,-3, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ;...
  0, 1, 0, 0, 1,-4, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0 ;...
  0, 0, 1, 0, 0, 1,-4, 1, 0, 0, 1, 0, 0, 0, 0, 0 ;...
  0, 0, 0, 1, 0, 0, 1,-3, 0, 0, 0, 1, 0, 0, 0, 0 ;...
  0, 0, 0, 0, 1, 0, 0, 0,-3, 1, 0, 0, 1, 0, 0, 0 ;...
  0, 0, 0, 0, 0, 1, 0, 0, 1,-4, 1, 0, 0, 1, 0, 0 ;...
  0, 0, 0, 0, 0, 0, 1, 0, 0, 1,-4, 1, 0, 0, 1, 0 ;...
  0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,-3, 0, 0, 0, 1 ;...
  0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,-2, 1, 0, 0 ;...
  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,-3, 1, 0 ;...
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,-3, 1 ;...
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,-2 ;...
];
Nboxes = size(Q,1);
minotaur_box = 13; % Where the Minotaur is
startboxes   = 4; % Where Theseus starts
%startboxes  = 1:Nboxes;

%% Question 5b: Kinetic Monte Carlo

% Compute the transition matrix
Qii = diag(Q);
P   = -Q ./ repmat(Qii, 1, Nboxes);
P(find(eye(Nboxes))) = 0;

% Find the average mean starting points
N = 1000;
mfpt  = nan(Nboxes,N);
nmove = nan(Nboxes,N);
for startbox = startboxes;
  fprintf('Starting at %d...\n', startbox);

  for n = 1:N
    t = 0;
    box = startbox; % Box is the current box Theseus is in
    moves = 0;
    while box ~= minotaur_box

      moves = moves+1;

      % Draw a time and add to running tally of time
      t = t + exprnd(-Qii(box));

      % Get the transition probabilities for the box
      probs = P(box,:);

      % Draw a new state/box and update
      box = find(rand(1) < cumsum(probs),1);
    end
    mfpt(startbox, n) = t;
    nmove(startbox, n) = moves;

  end
end

tau_sim = mean(mfpt,2);
