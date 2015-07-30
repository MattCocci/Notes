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

last     = find(portfolios(:,1) == 198912);
ffexcess = portfolios(:,2:end) - repmat(factors(:,end), 1, 25);
ffe      = ffexcess(last+1:end,:);
Sigma    = cov(ffexcess(1:last,:));
mu       = mean(ffexcess(1:last,:));
winsamp  = inv(Sigma)*mu';
Remv     = 100*ffe*(inv(Sigma)*mu');
[T,N]    = size(ffexcess);

%% Question 4
Restar = 100*[mean(ffe)*inv((1/T)*(ffe'*ffe))*ffe']';

%% Question 6
deltas = -0.5:0.1:0.5;
frontierRemvMean = arrayfun(@(d) mean(d*Remv), deltas);
frontierRemvStd  = arrayfun(@(d) std(d*Remv), deltas);
frontierRestarMean = arrayfun(@(d) mean(d*Restar), deltas);
frontierRestarStd  = arrayfun(@(d) std(d*Restar), deltas);

figure()
hold on
plot(frontierRemvStd,   frontierRemvMean, 'b');
plot(frontierRestarStd, frontierRestarMean, 'r');
text(std(Remv), mean(Remv), 'Remv')
text(std(Restar), mean(Restar), 'Restar')
text(std(factors(last+1:end,2)), mean(factors(last+1:end,2)), 'rmrf')
text(std(factors(last+1:end,3)), mean(factors(last+1:end,3)), 'smb')
text(std(factors(last+1:end,4)), mean(factors(last+1:end,4)), 'hml')
for n = 1:size(ffexcess,2)
    plot(std(ffe(:,n)), mean(ffe(:,n)), 'o')
end
hold off


%% Question 13
betas = nan(25,1);
means = nan(25,1);
cross = nan(25,1);
const = ones(length(Remv),1);
X     = [const Remv];
for n = 1:25
  b = inv(X'*X)*X'*ffe(:,n);
  means(n) = mean(ffe(:,n));
  betas(n) = b(2);
  cross(n) = mean(Remv .* ffe(:,n));
end
figure()
plot(betas, means)
xl = xlim();
yl = ylim();
xlim([0 xl(2)]);
ylim([0 yl(2)]);
