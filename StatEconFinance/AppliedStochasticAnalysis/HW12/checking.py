import sympy as sp

A, x, y, s2 = sp.symbols('A x y s2')

xpart = sp.exp(-(1/s2)*(x**2 - 2*x*y))
ypart = sp.exp(-(1/s2)*(y**2 - 2*x*y))
rho   = xpart * ypart

summ = 2*rho + (x-y)*rho.diff(x) + (y-x)*rho.diff(y) + (s2/2)*rho.diff(x).diff(x) + (s2/2)*rho.diff(y).diff(y)

