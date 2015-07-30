data = dlmread('gmm_data.txt');

% consumption growth and returns. Consumption growth is gross, returns are net (not percent) and excess (except rf)
headers = {'date','dc','rmrf','smb','hml','rf'};
[T,~] = size(data);

% Question 1.2
excess = {'rmrf', 'smb', 'hml'};
for n = 1:length(excess)
  Re      = excess{n};
  ReCol   = find(strcmp(headers, Re));
  gT.(Re) = @(gamma) mean( (data(:,2).^(-gamma)) .* data(:,ReCol) ); 
end

% Question 1.3
dc = data(:,2);
Re = data(:, [3]);
g  = @(gamma) [gT.rmrf(gamma)];
gamma = fminsearch(@(gamma) [g(gamma)]'*eye(1)*g(gamma), 50);

% Question 1.5
d = -mean(repmat((log(dc) .* dc.^(-gamma)), 1, 1) .* Re)';
a = d'*eye(1);
S = cov(repmat(dc.^(-gamma), 1, 1) .* Re);
v = (1/T)*inv(a*d)*a*S*a'*(inv(a*d)');

clear
rho = 0.05;
g = 2;
c = 10;
h = 5;
mu = 0.01;
sigma = 0.05;
rho + g*c*mu/(c-h) - g*(g+1)*(sigma^2)*(c^2)/(2*(c-h)^2)

g*(c/(c-h))*sigma

