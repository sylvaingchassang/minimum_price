function out=ols(y,x);

% GENERAL INFORMATION
% this function estimates the least squares coefficients and calculates the
% standard errors.
% the variance of the errors is estimated as sum_i eps_i^2/(n-k)

% INPUT
% a n-vector of outcomes y
% a n by k matrix of regressors x

% OUTPUT
% a K by 3 matrix with 
% the first column equal to the least squares coefficients
% the second column equal to the standard errors
% the third column equal to the tstatistics
 
[n,k]=size(x);
beta=inv(x'*x)*(x'*y);    % least squares coefficients
eps=y-x*beta;             % residuals
sig=eps'*eps/(n-k);       % estimated error variance 
var=inv(x'*x)*sig;        % homoskedastic variance estimate
sd=sqrt(diag(var));       % vector of standard errors
sse=eps'*eps;
ss=(y-mean(y))'*(y-mean(y));
rsq=1-sse/ss;             % r-squared (not used)
out=[beta,sd,beta./sd];