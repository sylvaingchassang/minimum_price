function fdensity=fden(y,Y);

% GENERAL INFORMATION
% this function estimates a univariate density function using kernel methods
% the kernel function is the Epanechnikov kernel
% the bandwidth is the optimal bandwith based on Silverman's rule of thumb

% INPUT
% the input is an N vector of observations Y
% and the a scalar y where the density is to be estimated

% OUTPUT
% the output is a scalar with the value of the estimated density

h=1.06*std(Y)*(length(Y)^(-1/5));  % Silverman optimal bandwidth
d=(Y-y)/h;
kd=(abs(d)<sqrt(5)).*(1-d.*d/5)*(3/(4*sqrt(5)));
   % epanechnikov kernel
fdensity=mean(kd/h);   