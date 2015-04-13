
y_milstein = @(x) -1+sqrt(1-2*x*(2+x));
y_em = @(x) 1-(1+x)^2;
y_sde = @(x) -2*x;

x = -2:0.01:0;

close all
figure()
hold on
%plot(x, arrayfun(y_sde, x), 'Color', [1 0 1])
%plot(x, arrayfun(y_em, x), 'Color', [0.8 0.8 0])
%plot(x, arrayfun(y_milstein, x), 'Color', [0 0 1])
h(1) = area(x, arrayfun(y_sde, x));
h(2) = area(x, arrayfun(y_em, x));
h(3) = area(x, arrayfun(y_milstein, x));
h(4) = area([-4 -2], [4 4]);
colors = {[1 0 1]; [0.8 0.8 0]; [0 0 1]; [1 0 1]};
for i_ = 1:4
  set(h(i_), 'FaceColor', colors{i_});
  child = get(h(i_), 'Children');
  set(child, 'FaceAlpha', 0.4);
  set(child, 'EdgeColor', 'none');
end
set(gca, 'xlim', [-4 0])
hold off
xlabel('\lambda \Delta t')
ylabel('\mu^2 \Delta t')
lgd = {'SDE M.S. Stable'; 'EM M.S. Stable'; 'Milsten M.S. Stable'};
legend(lgd{:})
