function FINVY=cdfinv_bracket(y,P,YS)    

% GENERAL INFORMATION
% this function estimates the inverse of a cumulative distribution function
% using the alternative definition  from equation (24) in the paper
% for a discrete random variable

% INPUT
% y is scalar between zero and one.
% P is cumulative probabilities at support points
% YS is vector of support points
% P and YS must be the same length

% OUTPUT
% FINVY is the (inverse) of the empirical distribution of x evaluated at y
% If the value of the inverse is minus infinity, the actual value used
% is the smallest support point minus 100 times the difference between the largest
% and the smallest support point

% EXAMPLE
% P=[0.1;0.3;0.6;0.7;1.0]
% YS=[1;2;3;4;5]
% if y=0.2 then FINVY=2
% if y=0.299999 then FINVY=2
% if y=0.3 then FINVY=3
% if y=0.300001 then FINVY=3


cc=0.000001;
NS=length(YS);    % number of points of support
t=(1:NS)';
if y>=P(1,1)-cc/2
   RANK=max(t(P<=y+cc));
   FINVY=YS(RANK);
   else
   FINVY=YS(1,1)-100*(1+YS(NS,1)-YS(1,1));
   end

