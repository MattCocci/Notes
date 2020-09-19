# Plot some paths
colors = ['b', 'r', 'g']
for s in range(len(step_sizes)):
  fig, ax = plt.subplots(nrows=int(np.ceil(len(step_sizes)/2.0)), ncols=2)
  r = int(np.floor(s/2.))
  c = 1-np.mod(s,2)
  for m in range(allpaths[s].shape[1]):
    ax[r,c].plot(np.log(allpaths[s][:,m]))

  plt.show()
