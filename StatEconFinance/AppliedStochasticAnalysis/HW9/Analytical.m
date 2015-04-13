function X = Analytical(X, P, dt, Nt, dWs, soln)

    X(t+1) = soln( X(t), dt, dWs(t) );

end
