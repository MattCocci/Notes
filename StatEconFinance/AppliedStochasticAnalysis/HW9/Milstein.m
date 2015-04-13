function X_t1 = Milstein(X_t0, t0, dt, dW, b, sigma, dsigma)

  X_t1 = X_t0 + b( X_t0, t0 )*dt + sigma( X_t0, t0 )*dW ...
          + (1/2)*sigma( X_t0, t0 ) * dsigma( X_t0, t0) * ((dW)^2-dt);

end
