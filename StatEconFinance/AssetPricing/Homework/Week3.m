close all


u = @(c,X,gamma) ((c-X)^(1-gamma))/(1-gamma);
figure()
hold on
support = 0.01:0.01:5;
plot(support, arrayfun(@(c) u(c,0,2), support), 'b')
plot(support, arrayfun(@(c) u(c,1,2), support), 'r')
hold off

rra = @(c,x,gamma) gamma*c/(c-x);
arrayfun(@(c) rra(c,1,2), [101 11 2 1.1])

S  = @(c,X) (c-X)/c;
rf = @(delta,mu,sigma,gamma,c,X) delta + gamma*mu/S(c,X) - 0.5*(gamma*(gamma+1))*(sigma^2)/(S(c,X)^2);
plot(arrayfun(@(c) rf(0,0.01,0.02,2,c,1), 1.01:0.01:3))

sharpe = @(gamma,c,X) gamma*c/(c-X);
plot(arrayfun(@(c) sharpe(2,c,1), 1.01:0.01:3))

delta = 0.01 - 100*0.02 + 0.5*(100^2)*(0.02^2)

