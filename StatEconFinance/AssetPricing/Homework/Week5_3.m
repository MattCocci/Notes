mu1    = 0.08;
sigma1 = 0.16;

mu2    = 0.08;
sigma2 = 0.24;

c1 = mu1/(sigma1^2 + mu1^2);
c2 = mu2/(sigma2^2 + mu2^2);

m1 = 0.5*(c1+c2)*mu1;
m2 = 0.5*(c1^2)*(sigma1^2 + mu1^2) + 0.5*(c2^2)*(sigma2^2 + mu2^2);
s2 = m2 - (m1^2);
m1/sqrt(s2)

cz2 = 2*0.08/( ((mu1^2)/(mu2)) * (mu2^2 + sigma2^2)/(mu1^2 + sigma1^2) + mu2);
cz1 = (mu1/mu2)*(mu2^2 + sigma2^2)/(mu1^2 + sigma1^2)*cz2;

% check
0.5*cz1*mu1 + 0.5*cz2*mu2
