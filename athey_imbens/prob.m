function pi=prob(Y,YS)

% GENERAL INFORMATION
% given a vector Y and a vector of support points YS
% this function calculates the sample proportions at
% each of the support points

% INPUT
% vector of support points YS
% vector of observations Y

% OUTPUT
% vector of frequencies pi, of length equal to the length of YS

NYS=length(YS);
mdys=min(abs(YS(2:NYS,1)-YS(1:NYS-1,1)))/2;
% as tolerance we use the minimum of the difference between support points
% divided by 2
pi=0*YS;
% first we count the number of values at each support point
for i=1:NYS,
    pi(i,1)=sum(abs(Y-YS(i,1))<(mdys/100));
    end    
% divide by the total number of points to convert counts to proportions
pi=pi/sum(pi);