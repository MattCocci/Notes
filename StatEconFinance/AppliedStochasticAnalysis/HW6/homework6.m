
%% Question 4a

N   = 100000000;
rs  = [3 5 10 20 25 30];
I   = nan(1, length(rs));
mus = rs + 1.5;

x         = randn(N,1);
phi_denom = normpdf(x);
for i_ = 1:length(rs)
  r = rs(i_);
  mu = mus(i_);
  I(i_) = mean( ((x+mu).^2 .* (x+mu > r) .* normpdf(x+mu)) ...
                ./ phi_denom );
  I(i_) = I(i_) / mean(x > r);
end
