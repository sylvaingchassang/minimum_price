function FY=cdf_bar(y,P,YS)    

% GENERAL INFORMATION
% this function calculates the probability that a random variable
% is less than y at a scalar value y for a discrete random variable 
% with cumulative distribution function P at the support points
% cc is a tolerance used, so that prob(Y<y) is calculated as prob(Y<y-cc) to
% make sure that we get the right number is y is in the support of Y

% INPUT
% y is scalar
% P is cdf at support points
% ys is vector of support (same dimension as p)

% OUTPUT
% FY is the cumulative distribution function evaluated at y

NS=length(P);
cc=0.00001;
t=(1:NS)';
if y<min(YS)+cc
   FY=0;
   else
   if y>max(YS)+cc
      FY=1;
      else
      Y=max(t(YS<y-cc));
      FY=P(Y,1);
      end
   end   