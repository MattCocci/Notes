%% Question 2a
lambda = 1;
mu     = lambda^-1;
m      = 10;
N      = 10000;

% Empirical distribution drawing m exponentials and taking the max
draws  = max(exprnd(mu, m, N))';
pgrid  = 0:0.01:1;
ecdf   = cdf(draws, pgrid);

% Analytical CDF computed in 2a that should match ecdf above
xgrid  = 0:0.01:12;
F_Y    = @(x) (1-exp(-lambda*x))^m;
anscdf = arrayfun(F_Y, xgrid);

figure()
hold on
plot(ecdf, pgrid, 'b');
plot(xgrid, anscdf, 'r');
hold off

%% Question 2b

invF = @(u) -(1/lambda)*log(1-u^(1/m));
invtrans_draws = arrayfun(invF, rand(N,1));

% Empirical CDF for draws using the inv transform method
invtrans_cdf = cdf(invtrans_draws, pgrid);

% Plot
figure()
hold on
plot(ecdf, pgrid, 'b');
plot(invtrans_cdf, pgrid, 'g');
plot(xgrid, anscdf, 'r');
hold off

%% Question 3b 

xgrid = -4:0.001:4;
g = @(x) (1/sqrt(2*pi))*exp(-abs(x)+0.5);

figure()
hold on
plot(xgrid, normpdf(xgrid), 'b')
plot(xgrid, g(xgrid), 'r')
legend('p(x)', 'g(x)')
hold off
print(gcf, '-dpdf', 'Figures/q3a.pdf')


