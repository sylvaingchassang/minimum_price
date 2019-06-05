function FINVY=cumdfinv(y,X)    

% GENERAL INFORMATION
% this function estimates the cumulative distribution function based
% on a vector of observations X at a point y

% INPUT
% y is scalar
% X is vector

% OUTPUT
% FYINVY is the empirical distribution of x evaluated at y

cc=0.000001;
if (y>cc)&(y<1-cc),
   RANK=floor(length(X)*y+1-cc/2);
       % RANK is smallest integer larger than length(X)*y
       % e.g., if length(X)=10, y=0.34 then RANK=floor(4.4-0.0000005)=4;
       % if length(X)=10, y=0.3 then RANK=floor(4-0.0000005)=3;
   SX=sort(X);
   FINVY=SX(RANK);
   else
      if y<=cc,
         FINVY=min(X);
         else,
         FINVY=max(X);
         end
   end      
