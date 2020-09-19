
% Functions representing the different regions
y_milstein = @(x) -1+sqrt(1-2*x*(2+x));
y_em = @(x) 1-(1+x)^2;
y_sde = @(x) -2*x;

x = -2:0.01:0;

close all
figure()
hold on

% Plot the different regions
h(1) = area(x, arrayfun(y_sde, x));
h(2) = area(x, arrayfun(y_em, x));
h(3) = area(x, arrayfun(y_milstein, x));

% Add some extra area for the SDE MS Stable region
h(4) = area([-4 -2], [4 4]);

% Colors and labels
colors = {[1 0 1]; [183/255 65/255 14/255]; [0 0 1]; [1 0 1]};
for i_ = 1:4
  set(h(i_), 'FaceColor', colors{i_});
  child = get(h(i_), 'Children');
  set(child, 'EdgeColor', 'none');
end
set(gca, 'xlim', [-4 0])
set(gca, 'FontSize', 16)
hold off
xlabel('\lambda \Delta t')
ylabel('\mu^2 \Delta t')
lgd = {'SDE M.S. Stable'; 'EM M.S. Stable'; 'Milsten M.S. Stable'};
legend(lgd{:})
