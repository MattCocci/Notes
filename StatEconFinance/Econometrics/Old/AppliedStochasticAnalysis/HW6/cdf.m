function [ecdf] = cdf(x, grid)

  ecdf = nan(length(grid),1);
  for g = 1:length(grid)
    ecdf(g) = quantile(x, grid(g));
  end

end
