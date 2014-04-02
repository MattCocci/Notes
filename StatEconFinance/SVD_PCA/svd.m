%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate graphs for SVD intuition

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Basic Grid and Plot
A_diag = [3, 0; 0, 1];

[XX, YY] = meshgrid(-10:10, -10:10);
ax1 = [-10,10];
ax2 = [0,0];
x = [1; 1];

plot(XX, YY, 'color', [0.5, 0.5, 0.5])
hold on
plot(YY, XX, 'color', [0.5, 0.5, 0.5])
plot(ax1,ax2,'k', 'LineWidth', 2)
plot(ax2,ax1,'k', 'LineWidth', 2)
quiver(x(1),x(2), 'LineWidth', 3)
hold off
x_lim = xlim;
y_lim = ylim;


%% Diagonal Matrix Case

figure()
grid_new1 = A_diag*([XX(:), YY(:)]');
grid_new2 = A_diag*([YY(:), XX(:)]');
plot(reshape(grid_new1(1,:), size(XX)), ...
    reshape(grid_new1(2,:), size(YY)), ...
    'color', [0.5, 0.5, 0.5])
hold on
plot(reshape(grid_new2(1,:), size(XX)), ...
    reshape(grid_new2(2,:), size(YY)), ...
    'color', [0.5, 0.5, 0.5])
plot(ax1,ax2,'k', 'LineWidth', 2)
plot(ax2,ax1,'k', 'LineWidth', 2)
hold off
axis([x_lim, y_lim])


