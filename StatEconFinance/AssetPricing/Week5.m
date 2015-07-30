mu_p    = @(a,b) a*3 + b*10;
sigma_p = @(a,b,rho) sqrt((a^2)*(10^2) + (b^2)*(15^2) + 2*a*b*rho*10*15);

figure()
hold on
for rho = 0

  a = -2:0.05:2;
  b = 1-a;

  for n = 1:length(a)
    x(n) = sigma_p(a(n),b(n),rho);
    y(n) = mu_p(a(n),b(n));
  end

  plot(x,y);
end
hold off

