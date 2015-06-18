import matplotlib.pyplot as plt


# Define classes and updating schemes
execfile("setup.py")

# Initialize GBM
x0  = np.random.normal()
lam = 2
mu  = 1
t0  = 0
T   = 10

# Set up partition
step_sizes = np.cumprod(0.1*np.ones(5))
nsizes     = len(step_sizes)

# Plot sample paths
allpaths = []
for dt in step_sizes:
  print "Using step size " + str(dt)

  # Initialize a new instance of X
  X = GBM(x0, lam, mu)

  # initialize a vector of all left endpoints of the subintervals
  P = np.linspace(t0, T, num=round((T-t0)/dt), endpoint=False)

  # Loop over all left endpoints, update, and store the new value
  paths = np.nan*np.ones((len(P)+1,3))
  paths[0,:] = x0 * np.ones(3)
  for t in range(len(P)):
    X.UpdateAll(P[t], dt)
    paths[t+1,:] = X.GetXAll()

  allpaths.append(paths)

