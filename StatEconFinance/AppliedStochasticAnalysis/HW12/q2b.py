import sympy as sp

A, x, y, s2, C = sp.symbols('A x y s2 C')

# Define rho
def check(rho):
  return (-sp.sin(y)*rho.diff(x) - sp.sin(x)*rho.diff(y) /
          0.5*rho.diff(x,2) + 0.5*rho.diff(y,2)).simplify()

rho = sp.exp(sp.sin(x)**2) + sp.exp(sp.sin(y)**2)
