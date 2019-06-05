function FY=cumdf(y,X)    

% GENERAL INFORMATION
% this function estimates the cumulative distribution function based
% on a vector of observations X at a point y

% INPUT
% y is scalar
% X is vector

% OUTPUT
% FY is the empirical distribution of x evaluated at y

cc=0.00001;
FY=mean(X <= y+cc);
