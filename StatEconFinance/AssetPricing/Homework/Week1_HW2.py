import sympy as sp
import numpy as np
import scipy.stats as st

mu, sigma, T = sp.symbols('mu sigma T')

ER   = sp.exp(T*mu)
ER2  = sp.exp(2*mu*T + (sigma**2)*T)
VarR = ER2 - ER**2
sdR  = (sp.sqrt(VarR)).simplify()

sharpe = ((ER - 1)/sdR).simplify()

ER_     = sp.lambdify((T,mu,sigma), ER)
sdR_    = sp.lambdify((T,mu,sigma), sdR)
sharpe_ = sp.lambdify((T,mu,sigma), sharpe)
def median_(T,mu,sigma): return np.exp(T*(mu-0.5*(sigma**2)))
def mode_(T,mu,sigma):   return np.exp(T*(mu -0.5*(sigma**2))-T*(sigma**2))
st.norm.cdf(0.5*np.sqrt(10)*0.2)

# New attemps
# Q1 E^(mu*T)
# Q2 E^(mu*T)*sqrt(E^((sigma^2)*T)-1)
# Q3 (1-E^(-mu*T))/(sqrt(E^((sigma^2)*T)-1))
# Q4 6.18 21.45 0.288
# Q5 82.2 127.8 0.643
# Q6 0.136
# Q7 Faster
# Q8 Faster
# Q9 Slower
# Q10 1.822 1.492 1 62.4

