data = dlmread('gmm_data.txt');

% consumption growth and returns. Consumption growth is gross, returns are net (not percent) and excess (except rf)
headers = {'date','dc','rmrf','smb','hml','rf'};
[T,~] = size(data);

% Question 1.1
X = 100*[data(:,2)-1 data(:,3:5)];
mean(X)
std(X)
corr(X)

% Question 1.2
excess = {'rmrf', 'smb', 'hml'};
for n = 1:length(excess)
  Re      = excess{n};
  ReCol   = find(strcmp(headers, Re));
  gT.(Re) = @(gamma) mean( (data(:,2).^(-gamma)) .* data(:,ReCol) ); 
  figure()
  support = 50:0.1:150;
  plot(support, arrayfun(gT.(Re), support));
  title(Re)
  ylim([-0.02 0.02])
end

% Question 1.3
dc = data(:,2);
Re = data(:, [3 5]);
g  = @(gamma) [gT.rmrf(gamma); gT.hml(gamma)];
gamma = fminsearch(@(gamma) [g(gamma)]'*eye(2)*g(gamma), 50);
keyboard

% Question 1.5
d = -mean(repmat((log(dc) .* dc.^(-gamma)), 1, 2) .* Re)';
a = d'*eye(2);
S = cov(repmat(dc.^(-gamma), 1, 2) .* Re);
v = (1/T)*inv(a*d)*a*S*a'*(inv(a*d)');

% Question 1.6
gcov = (1/T)*(eye(2) - d*inv(a*d)*a)*S*(eye(2) - d*inv(a*d)*a)';
g(gamma)'*gcov\g(gamma)

% Question 1.7
x = dc .^ (-gamma);
figure()
hold on
scatter(x, data(:,3), 'r')
scatter(x, data(:,5), 'b')

% Question 2.1
gamma2 = fminsearch(@(gamma) [g(gamma)]'*inv(S)*g(gamma), gamma);
d2 = -mean(repmat((log(dc) .* dc.^(-gamma2)), 1, 2) .* Re)';
a2 = d2'*inv(S);

% Question 2.3
v2 = (1/T)*inv(d2'*inv(S)*d2)

% Question 2.4
gT1   = g(gamma);
gT2   = g(gamma2);
gcov2 = (1/T)*(S-d*inv(d'*inv(S)*d)*d');

% Question 2.5
T*gT2'*inv(S)*gT2
