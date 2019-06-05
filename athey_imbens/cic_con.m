function [est,est1]=cic_con(f00,f01,f10,f11,qq,YS,YS01);

% GENERAL INFORMATION
% this function calculates the continuous cic estimator. We first
% estimate the cdf of Y^N_11 using equation (9) in the paper and
% then use that to calculate the average effect of the treatment

% INPUT
% f00 is vector of probabilities in (0,0) group
% f01 is vector of probabilities in (0,1) group
% f10 is vector of probabilities in (1,0) group
% f11 is vector of probabilities in (1,1) group
% qq is vector of quantiles at which the estimate needs to be calculated 
% in addition to the average effect
% YS is vector of support points
% YS01 is vector of support points for Y01
% f00, f01, f10, f11 and YS all have the same length, YS01 may be shorter

% OUTPUT
% est is scalar with continuous cic estimates


F00=cumsum(f00); % cumulative distribution functions
F01=cumsum(f01); % cumulative distribution functions
F10=cumsum(f10); % cumulative distribution functions
F11=cumsum(f11); % cumulative distribution functions

ccc=min(max(abs(cumsum(f00)-cumsum(f01)))/1000,0.000000001);
% tolerance that will be used to distinguish between probabilities

% for each value of y in YS01, which is the support of Y01 
% we calculate 
% 1. F_01(y)
% 2. F_00^-1(F_01(y)))
% 3. FCO(y)=F_10(F^-1_00(F_01(y)))

ZZ=zeros(length(YS01),1);
ns01=length(YS01);
FCO=ZZ;
for i=1:length(YS01);
    y=YS01(i,1);
    F01y=cdf(y,F01,YS);
    F00invF01y=cdfinv(F01y,F00,YS);    
    F10F00invF01y=cdf(F00invF01y,F10,YS);
    FCO(i,1)=F10F00invF01y;
end,
 
% adjusting the estimates of the cdf's of Y^N_11 
% at values larger than or equal to the maximum of Y01
% at such values the cdf's will be set equal to one.
FCO(ns01,1)=1;

% continuous mean estimate
est=(F11-[0;F11(1:length(YS)-1,1)])'*YS-(FCO-[0;FCO(1:length(YS01)-1,1)])'*YS01;

% quantile estimates
Nq=length(qq);
est=[est,zeros(1,Nq)];
for i=1:Nq,
    est(1,1+i)=cdfinv(qq(i,1),F11,YS)-cdfinv(qq(i,1),FCO,YS01);
end
 
est1=zeros(2,Nq);
for i=1:Nq,
    est1(1,1+i)=cdfinv(qq(i,1),F11,YS);
    est1(2,1+i)=cdfinv(qq(i,1),FCO,YS01);
end
    

