import sympy as sp

x, y, s2, a, gam, mu, C, c, d, alpha, sigma = sp.symbols('x y s2 a gam mu C c d alpha sigma')

# Early
rho  = sp.exp(-(1/(s2))*((x-y)**2))
drho = rho.diff(x)
-(1-y)*rho.subs(x,1) - (s2/2)*drho.subs(x,1)

# Question 5a
def hermite(n, xh=x):
  Hn = ((-1.)**n)*(sp.exp(((x**2.)/2.))) * sp.diff(sp.exp(-(x**2.)/2.), x, n)
  Hn = Hn.subs(x, xh)
  return Hn.simplify().expand()

def L_OU(f):
  return -alpha*x*sp.diff(f,x,1) + 0.5*(sigma**2)*sp.diff(f,x,2)

def hermite_integrate(n):
  return sp.integrate( sp.exp(-(x**2))*(hermite(n)**2), x)

#def hermite_integrate_agst(n,m):
  #return sp.integrate(sp.exp(-x**2)*hermite(n)*hermite(m), (x,-sp.oo, sp.oo))

#def hermite_integrate(n):
  #return sp.integrate(sp.exp(-x**2/2)*hermite(n), (x,-sp.oo, sp.oo))


#def test(n):
  #xh = x*sp.sqrt(2*alpha/sigma**2)
  #fcn = (sp.factorial(n)**(-0.5))*hermite(n, x)
  ##div = L(fcn)/(fcn*alpha)
  #div = L(fcn)/(fcn)
  #return div.simplify()

def laguerre(n, xh=x):
  Ln = (sp.exp(x)/float(sp.factorial(n))) * sp.diff(sp.exp(-x)*(x**n), x, n)
  Ln = Ln.subs(x, xh)
  return Ln.simplify().expand()

#def laguerre_integrate(n,m):


#execfile('check.py')
