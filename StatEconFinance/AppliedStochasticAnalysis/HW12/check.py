import sympy as sp

x, y, s2, a, gam, mu, C, c, d = sp.symbols('x y s2 a gam mu C c d')

# Early
rho  = sp.exp(-(1/(s2))*((x-y)**2))
drho = rho.diff(x)
-(1-y)*rho.subs(x,1) - (s2/2)*drho.subs(x,1)

# Question 5a
rhs = -(gam/mu)*a + 1/a
rho = sp.exp(sp.integrate(rhs, a)).simplify()
rhonorm = (gam/mu)*a*sp.exp(-(gam/(2*mu))*(a**2))

# Question 5b
b = (1/4.)*(a+d)**2

target = b.diff(a).diff(a) + (-gam*a + mu/a)*b.diff(a)


#execfile('check.py')
