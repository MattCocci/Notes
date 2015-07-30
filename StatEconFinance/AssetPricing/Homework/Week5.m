%% Question 1
mu    = 1.10;
sigma = 0.2;
Rf    = 1.05;
Rweight = Rf/(Rf^2 + sigma^2 + mu^2)

%% Question 2
Rweight2 = 1/(Rf^2 + sigma^2 + mu^2)

%% Question 3
factorsHeader = {'Mkt-RF';'SMB';'HML';'RF'};
factors = dlmread('./assetpricing_data_ff_factors.txt');

portfoliosHeader = {...
  'SMB1-HML1'; 'SMB1-HML2'; 'SMB1-HML3'; 'SMB1-HML4'; 'SMB1-HML5';...
  'SMB2-HML1'; 'SMB2-HML2'; 'SMB2-HML3'; 'SMB2-HML4'; 'SMB2-HML5';...
  'SMB3-HML1'; 'SMB3-HML2'; 'SMB3-HML3'; 'SMB3-HML4'; 'SMB3-HML5';...
  'SMB4-HML1'; 'SMB4-HML2'; 'SMB4-HML3'; 'SMB4-HML4'; 'SMB4-HML5';...
  'SMB5-HML1'; 'SMB5-HML2'; 'SMB5-HML3'; 'SMB5-HML4'; 'SMB5-HML5';...
};
portfolios = dlmread('./assetpricing_data_ff_25.txt');

ffexcess = portfolios(:,2:end) - repmat(factors(:,end), 1, 25);
Sigma = cov(ffexcess);
mu    = mean(ffexcess);
Remv  = 100*ffexcess*(inv(Sigma)*mu');
[T,N] = size(ffexcess);

%% Question 4
Restar = 100*[mean(ffexcess)*inv((1/T)*(ffexcess'*ffexcess))*ffexcess']';

%% Question 6
deltas = -1:0.1:1;
frontierRemvMean = arrayfun(@(d) mean(d*Remv), deltas);
frontierRemvStd  = arrayfun(@(d) std(d*Remv), deltas);
frontierRestarMean = arrayfun(@(d) mean(d*Restar), deltas);
frontierRestarStd  = arrayfun(@(d) std(d*Restar), deltas);

figure()
hold on
plot(frontierRemvStd, frontierRemvMean, 'b');
plot(frontierRestarStd, frontierRestarMean, 'r');
text(std(Remv), mean(Remv), 'Remv')
text(std(Restar), mean(Restar), 'Restar')
text(std(factors(:,2)), mean(factors(:,2)), 'rmrf')
text(std(factors(:,3)), mean(factors(:,3)), 'smb')
text(std(factors(:,4)), mean(factors(:,4)), 'hml')
for n = 1:size(ffexcess,2)
  if n == 1
    text(std(ffexcess(:,n)), mean(ffexcess(:,n)), portfoliosHeader{n})
  end
end
hold off

%% Question 9
betas = nan(25,1);
means = nan(25,1);
cross = nan(25,1);
const = ones(length(Restar),1);
X     = [const Restar];
for n = 1:25
  b = inv(X'*X)*X'*ffexcess(:,n);
  means(n) = mean(ffexcess(:,n));
  betas(n) = b(2);
  cross(n) = mean(Restar .* ffexcess(:,n));
end
figure()
plot(betas, means)
xl = xlim();
yl = ylim();
xlim([0 xl(2)]);
ylim([0 yl(2)]);
