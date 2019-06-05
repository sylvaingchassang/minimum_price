function [est,est1,se]=cic(Y00A,Y01A,Y00B,Y01B,Y10A,Y10B,Y11,qq,bootstrap);

% GENERAL INFORMATION
% this program calculates the four sets of cic estimates
% (for the continuous, discrete conditional independence, lower and upper bound)
% if required it also calculates bootstrap standard errors

% INPUT
% Y00A is vector of outcomes in (0,0) control group A
% Y01A is vector of outcomes in (0,1) control group A
% Y00B is vector of outcomes in (0,0) control group B
% Y01B is vector of outcomes in (0,1) control group B
% Y10 is vector of outcomes in (1,0) treatment group
% Y11 is vector of outcomes in (1,1) treatment group
% qq is a vector of quantiles for which the quantile effects will be calculated

% bootstrap is an indicator whether bootstrap standard errors should be calculated
% if positive then bootstrap standard errors will be calculated with
% number of bootstrap replications equal to the value of bootstrap.

% OUTPUT
% est is 4-dimensional vector with estimates
% 1. continuous
% 2. discrete with conditional independence
% 3. lower bound
% 4. upper bound
% se is 4-dimensional vector with estimates of standard errors
% 1. continuous
% 2. discrete with conditional independence
% 3. lower bound
% 4. upper bound

% preliminary manipulation of the data
YSA=supp([Y00A;Y01A;Y10A;Y11]); % vector of distinct support points
NYSA=length(YSA);             % number of points of support           
YS00A=supp(Y00A);             % vector of distinct support points for Y00A
NYS00A=length(YS00A);
YS01A=supp(Y01A);             % vector of distinct support points for Y01A
NYS01A=length(YS01A);

YSB=supp([Y00B;Y01B;Y10B;Y11]); % vector of distinct support points
NYSB=length(YSB);             % number of points of support           
YS00B=supp(Y00B);             % vector of distinct support points for Y00B
NYS00B=length(YS00B);
YS01B=supp(Y01B);             % vector of distinct support points for Y01B
NYS01B=length(YS01B);


YS10A=supp(Y10A);             % vector of distinct support points for Y10A
NYS10A=length(YS10A);

YS10B=supp(Y10B);             % vector of distinct support points for Y10
NYS10B=length(YS10B);

YS11=supp(Y11);             % vector of distinct support points for Y11
NYS11=length(YS11);

f00A=prob(Y00A,YSA);           % vector of probabilities
f01A=prob(Y01A,YSA);           % vector of probabilities

f00B=prob(Y00B,YSB);           % vector of probabilities
f01B=prob(Y01B,YSB);           % vector of probabilities

f10A=prob(Y10A,YSA);           % vector of probabilities
f11A=prob(Y11,YSA);           % vector of probabilities

f10B=prob(Y10B,YSB);           % vector of probabilities
f11B=prob(Y11,YSB);           % vector of probabilities



% continuous estimate
[est_conA,est_con1A]=cic_con(f00A,f01A,f10A,f11A,qq,YSA,YS01A);
estA=est_conA;
est1A=est_con1A;


display(estA)


[est_conB,est_con1B]=cic_con(f00B,f01B,f10B,f11B,qq,YSB,YS01B);
estB=est_conB;
est1B=est_con1B;

display(estB)

est = .5*(estA+estB) % difference vector
est1 = .5*(est1A+est1B) % level vector

% standard error calculations
se=0*est;

% standard error for conditional independence
% this standard error is based on numerical differentiation
% in combination with the delta method.
% the estimator is a function of f00, f01, f10, f11.

% if standard_error==1,
%    F00=cumsum(f00); % cumulative distribution functions
%    F01=cumsum(f01); % cumulative distribution functions
%    F10=cumsum(f10); % cumulative distribution functions
%    F11=cumsum(f11); % cumulative distribution functions
%    F00=F00/F00(length(F00),1);  % ensuring normalization to one
%    F01=F01/F01(length(F01),1);
%    F10=F10/F10(length(F10),1);
%    F11=F11/F11(length(F11),1);
%    
%    % A. continuous estimator
%    % 0. preliminaries
%    cc=0.00000001;
%    F00_10=zeros(NYS10,1);
%    F01invF00_10=zeros(NYS10,1);
%    for i=1:NYS10;
%        F00_10(i,1)=cdf(YS10(i,1),F00,YS);
%        F01invF00_10(i,1)=cdfinv(F00_10(i,1),F01,YS);
%        f01F01invF00_10(i,1)=fden(F01invF00_10(i,1),Y01);
%        end
%    % 1. contribution of Y00
%    P=zeros(NYS00,1);
%    for i=1:NYS00,
%        PY00=((YS00(i,1)<=YS10)-F00_10)./f01F01invF00_10;
%        P(i,1)=PY00'*f10(f10>cc);
%        end,
%    V00=sum(P.*P.*f00(f00>cc))/length(Y00);
%    % 2. contribution of Y01
%    P=zeros(NYS01,1);
%    for i=1:NYS01,
%        PY01=-((cdf(YS01(i,1),F01,YS)<=F00_10)-F00_10)./f01F01invF00_10;
%        P(i,1)=PY01'*f10(f10>cc);
%        end,
%    V01=sum(P.*P.*f01(f01>cc))/length(Y01);
%    % 3. contribution of Y10
%    P=F01invF00_10-F01invF00_10'*f10(f10>cc);
%    V10=sum(P.*P.*f10(f10>cc))/length(Y10);
%    % 4. contribution of Y11
%    P=YS11-YS'*f11;
%    V11=sum(P.*P.*f11(f11>cc))/length(Y11);
%    se_con=sqrt(V00+V01+V10+V11);
%    se(1,1)=se_con;       

if bootstrap>0,
   Nboot=bootstrap;
   boot_est=zeros(Nboot,4);
   N00A=length(Y00A);
   N01A=length(Y01A);
   N00B=length(Y00B);
   N01B=length(Y01B);
   
   N10A=length(Y10A);
   N10B=length(Y10B);
   N11=length(Y11);
   for i=1:Nboot;
       u=floor(N00A*rand(N00A,1)+1);
       Y00Aboot=Y00A(u,1);
       u=floor(N01A*rand(N01A,1)+1);
       Y01Aboot=Y01A(u,1);
       u=floor(N00B*rand(N00B,1)+1);
       Y00Bboot=Y00B(u,1);
       u=floor(N01B*rand(N01B,1)+1);
       Y01Bboot=Y01B(u,1);
       
       u=floor(N10A*rand(N10A,1)+1);
       Y10Aboot=Y10A(u,1);
       u=floor(N10B*rand(N10B,1)+1);
       Y10Bboot=Y10B(u,1);
       u=floor(N11*rand(N11,1)+1);
       Y11boot=Y11(u,1);
       
       YSAboot=supp([Y00Aboot;Y01Aboot;Y10Aboot;Y11boot]);
       YS01Aboot=supp(Y01Aboot);
       f00Aboot=prob(Y00Aboot,YSAboot); % vector of probabilities
       f01Aboot=prob(Y01Aboot,YSAboot); % vector of probabilities
       f10Aboot=prob(Y10Aboot,YSAboot); % vector of probabilities
       f11Aboot=prob(Y11boot,YSAboot); % vector of probabilities
       
       YSBboot=supp([Y00Bboot;Y01Bboot;Y10Bboot;Y11boot]);
       YS01Bboot=supp(Y01Bboot);
       f00Bboot=prob(Y00Bboot,YSBboot); % vector of probabilities
       f01Bboot=prob(Y01Bboot,YSBboot); % vector of probabilities
       f10Bboot=prob(Y10Bboot,YSBboot); % vector of probabilities
       f11Bboot=prob(Y11boot,YSBboot); % vector of probabilities
       
       [est_conA,~]=cic_con(f00Aboot,f01Aboot,f10Aboot,f11Aboot,qq,YSAboot,YS01Aboot); %est_conA is the difference vector
       [est_conB,~]=cic_con(f00Bboot,f01Bboot,f10Bboot,f11Bboot,qq,YSBboot,YS01Bboot);
       boot_est(i,1:1+length(qq))=.5*(est_conA+ est_conB);
       se_boot=std(boot_est);
   end    
   if Nboot>=100,                  % eventually bootstrap standard errors are 
                                   % calculated using the percentile method
      low=round(Nboot*0.025);
      high=round(Nboot*0.975);
      boot_est=sort(boot_est);
      se_boot=(boot_est(high,:)-boot_est(low,:))/(2*1.96);
   end
   display(se)
   display(se_boot)
   se=[se;se_boot];   
   display(se)
end
end