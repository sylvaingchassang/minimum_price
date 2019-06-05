function YS=supp(Y);

% GENERAL INFORMATION
% this constructs a vector Y with all the support points of the
% vector Y

% INPUT
% a N-vector of observations Y

% OUTPUT
% an M vector of ordered support points, with M equal to the number of distinct
% values in Y

YS=[];
while length(Y)>0,
      YS=[YS;min(Y)];
      Y=Y(Y>min(Y),1);
      end,