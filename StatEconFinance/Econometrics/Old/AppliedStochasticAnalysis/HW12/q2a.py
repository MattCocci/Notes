import sympy as sp

A, x, y, s2, C = sp.symbols('A x y s2 C')

# Define rho
rho = C*sp.exp(-(1/(s2))*((x-y)**2))

# Check derivatives
drho = (rho.diff(x)/rho).simplify()

# Find the integrating constant
#Cnum = sp.integrate(sp.integrate(rho, (y,0,1)), (x,0,1))

# Check the reflecting boundary conditions
def J(rho):
  return -(x-y)*rho - (s2/2)*rho.diff(x), -(y-x)*rho - (s2/2)*rho.diff(y)

# Edge (x,0)
n = (0, -1)
print sum(a.subs(y,0)*b for a,b in zip(J(rho), n)).simplify()

# Edge (x,1)
n = (0, 1)
print (sum(a.subs(y,1)*b for a,b in zip(J(rho), n))).simplify()

# Edge (0,y)
n = (-1, 0)
print sum(a.subs(x,0)*b for a,b in zip(J(rho), n)).simplify()

# Edge (1,y)
n = (1, 0)
print sum(a.subs(x,1)*b for a,b in zip(J(rho), n)).simplify()



#rho = C*sp.exp( -(1/(2*s2))*( (x-0.5)**2 - (y-0.5)**2 ) )
#deq = 2*rho + (x-y)*rho.diff(x) + (y-x)*rho.diff(y) + s2*rho.diff(x,2) + s2*rho.diff(y,2)
