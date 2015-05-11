import sympy as sp

A, x, y, s2 = sp.symbols('A x y s2')

rho = C*sp.exp(-(1/(s2))*((x-y)**2))
#rho = C*sp.exp( -(1/(2*s2))*( (x-0.5)**2 - (y-0.5)**2 ) )
deq = 2*rho + (x-y)*rho.diff(x) + (y-x)*rho.diff(y) + s2*rho.diff(x,2) + s2*rho.diff(y,2)
