import sympy as sp

s = sp.Symbol('s')
t = sp.Symbol('t')
et = sp.Function('et')(t)
es = sp.Function('es')(s)

s1 = sp.diff(sp.integrate((t-s*t)*et, (t, 0, s)), s)
s2 = sp.diff(sp.integrate((s-s*t)*et, (t, s, 1)), s)
print s1
print s2

sprime = s1 + s2
print sprime

sprimeprime = sp.diff(sprime, s)
print sprimeprime
