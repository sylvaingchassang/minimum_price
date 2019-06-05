function FY=cdf(y,P,YS)    

% GENERAL INFORMATION
% this function calculates the cumulative distribution function at a scalar
% value y for a discrete random variable with cumulative distribution function P
% at the support points

% INPUT
% y is scalar
% P is cdf at support points
% ys is vector of support (same dimension as p)

% OUTPUT
% FY is the cumulative distribution function evaluated at y

NS=length(YS);
t=(1:NS)';
if y<min(YS)
   FY=0;
   else
   if y>=max(YS)
      FY=1;
      else
      cc=0.00001;
      Y=max(t(YS<=(y+cc)));
      FY=P(Y,1);
      end
   end   
FY=max(0,FY);
FY=min(1,FY);
   
   