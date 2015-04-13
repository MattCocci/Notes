import numpy as np
import scipy as sp

# Define general functions that implement 1-step updates in different
# updating/discretization schemes: Euler-Maruyama, Milstein, and
# Analytically.
def StepEulerMaruyama(x0, t0, dt, dW, b, sigma):
  x1 = x0 + b(x0,t0)*dt + sigma(x0,t0)*dW
  return x1

def StepMilstein(x0, t0, dt, dW, b, sigma, dsigma):
  x1 = ( x0 + b(x0,t0)*dt + sigma(x0,t0)*dW
          + (1/2)*sigma(x0,t0)*dsigma(x0,t0)*(dW**2 - dt) )
  return x1

def StepAnalytical(x0, dt, dW, soln):
  x1 = soln(x0, dt, dW)
  return x1


## Define class for Geometric Brownian Motion
class GBM:
  def __init__(self, x0, mu, sig):
    """
      This will initialize a process X_t that satisfies

        dX_t = mu*X_t dt + sig*X_t dW_t

      It will store the drift term and the diffusion term

        b(X_t,t) = mu*X_t
        sigma(X_t,t) = sig*X_t

      respectively, as functions of X and t (so that we can pass them directly to StepEulerMaruyama and StepMilstein, which require such
      inputs.

      This function will also initialize the known solution for standard
      GBM, while also initializing starting points for the various
      different updating schemes. These will be referenced, updated, and
      stepped over.
    """
    self.b      = lambda x, t: mu*x  # Drift term, a function b(x,t)
    self.sigma  = lambda x, t: sig*x # Diffusion term, a function sigma(x,t)
    self.dsigma = lambda x, t: sig   # Deriv of diffsn term, a function sigma'(x,t)
    self.soln   = ( lambda x0, dt, dW:
                     x0*np.exp( (mu - (sig**2)/2)*dt + sig*dW ) )

    # Initialize starting points for algorithms
    self.X_EulerMaruyama = x0
    self.X_Milstein      = x0
    self.X_Analytical    = x0


  def UpdateAnalytical(self, t0, dt, dW):
    self.X_Analytical = StepAnalytical( self.X_Analytical, dt, dW, self.soln )

  def UpdateEulerMaruyama(self, t0, dt, dW):
    self.X_EulerMaruyama = StepEulerMaruyama( self.X_EulerMaruyama,
                                              t0, dt, dW, self.b, self.sigma )

  def UpdateMilstein(self, t0, dt, dW):
    self.X_Milstein = StepMilstein( self.X_Milstein, t0, dt, dW, self.b, self.sigma, self.dsigma )

  def UpdateAll(self, t0, dt):
    """
      Draw a appropriately scaled normal RV and use it to update under
      all discretization schemes. This will ensure that we use the same
      path of W_t so we can compare the schemes to each other and the
      true soln
    """

    # Generate a random draw and scale by sqrt(dt)
    dW = np.sqrt(dt)*np.random.normal()

    # Loop over the things to update and update
    self.UpdateAnalytical(t0, dt, dW)
    self.UpdateEulerMaruyama(t0, dt, dW)
    self.UpdateMilstein(t0, dt, dW)

  def GetXAll(self):
    return np.array([self.X_Analytical, self.X_EulerMaruyama, self.X_Milstein])


