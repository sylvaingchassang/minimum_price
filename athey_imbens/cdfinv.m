function FINVY=cdfinv(y,P,YS)    

% GENERAL INFORMATION
% this function calculates the inverse of a cumulative distribution function 
% for a discrete random variable with cumulative distribution function equal
% to P at the support points YS
% cc is a tolerance level set to avoid problems at the actual support points.

% INPUT
% y is scalar between zero and one.
% x is vector

% OUTPUT
% FINVY is the inverse of the empirical distribution of x evaluated at y

% EXAMPLE
% P=[0.1;0.3;0.6;0.7;1.0]
% YS=[1;2;3;4;5]
% if y=0.2 then FINVY=2
% if y=0.3 then FINVY=2
% if y=0.300001 then FINVY=3

cc=0.000001;
t=(1:length(YS))';
RANK=min(t(P>=y-cc));
FINVY=YS(RANK);

