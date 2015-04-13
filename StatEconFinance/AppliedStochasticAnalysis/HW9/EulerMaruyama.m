function X = EulerMaruyama(X, P, dt, Nt, dWs, b, sigma)

  X(t+1) = X(t) + b( X(t),P(t) )*dt + sigma( X(t),P(t) )*dWs(t);

end
