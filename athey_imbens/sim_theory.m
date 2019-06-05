% GENERAL INFORMATION
% calculations for popoulation (true) values of estimands
% data generating processes
% all densities are of the form f_y(y)=alpha+beta*y,
% for 0<y<1, with different values for the parameters
diary true_values_05dec6.txt

% values for slope coefficients in linear densities
beta00=-1.5;
beta01=0.5;
beta10=0.4;
beta11=1;

% implied intercepts in densities (follow from the fact
% that the densities integrate out to one)
alpha00=1-beta00/2;
alpha01=1-beta01/2;
alpha10=1-beta10/2;
alpha11=1-beta11/2;

% A. continuous data
% need to calculate only average effect for this dgp

% average given treatment
EY11=alpha11/2+beta11/3;     % can be calculated analytically

% average without treatment
% this cannot be calculated analytically, so we sample from Y10
% and transform to YN11, and average that
k=2;
tau_c=zeros(k,1);
for i=1:k,
    N=1000000;
    u=rand(N,1);
    a=beta10;
    b=2*alpha10;
    c=-2*u;
    Y10=(-b+sqrt(b*b-4*a*c))/(2*a);
    YN11=-alpha01/beta01+sqrt(alpha01*alpha01+2*beta01*(alpha00*Y10+beta00*Y10.*Y10/2))/beta01;
    EYN11=mean(YN11);
    tau_cont=EY11-EYN11;
    [i,tau_cont]
    tau_c(i,1)=tau_cont;
    end,
[mean(tau_c),std(tau_c),std(tau_c)/sqrt(k),10000*std(tau_c)/sqrt(k)]    


% output based on k=10,000, N=1,000,000
% -0.1093    0.0003    0.0000    0.0847
outt=[-0.1093 ,   0.0003 ,   0.0000 ,   0.0847]

% B. binary data
% can calculate these analytically
% fgt is vector of probabilities for Y_gt
f00=zeros(2,1);
f00(1,1)=alpha00/2+beta00/8;
f00(2,1)=1-f00(1,1);
f01=zeros(2,1);
f01(1,1)=alpha01/2+beta01/8;
f01(2,1)=1-f01(1,1);
f10=zeros(2,1);
f10(1,1)=alpha10/2+beta10/8;
f10(2,1)=1-f10(1,1);
f11=zeros(2,1);
f11(1,1)=alpha11/2+beta11/8;
f11(2,1)=1-f11(1,1);
YS=[0.5;1];
YS01=[0.5;1];
ff=[f00,f01,f10,f11,YS,YS01]
est_bin_upp=cic_upp(f00,f01,f10,f11,YS,YS01)
est_bin_low=cic_low(f00,f01,f10,f11,YS,YS01)
est_bin_dci=cic_dci(f00,f01,f10,f11,YS,YS01)

% C discrete data
% can calculate these analytically
% fgt is vector of probabilities for Y_gt
f00=zeros(10,1);
for i=1:10,
    up=i/10;
    down=(i-1)/10;
    f00(i,1)=alpha00*up+beta00*up*up/2-alpha00*down-beta00*down*down/2;
    f01(i,1)=alpha01*up+beta01*up*up/2-alpha01*down-beta01*down*down/2;
    f10(i,1)=alpha10*up+beta10*up*up/2-alpha10*down-beta10*down*down/2;
    f11(i,1)=alpha11*up+beta11*up*up/2-alpha11*down-beta11*down*down/2;
    end
YS=((1:10)')/10;
YS01=((1:10)')/10;
ff=[f00,f01,f10,f11,YS,YS01]
sum(ff)
est_dci_upp=cic_upp(f00,f01,f10,f11,YS,YS01)
est_dci_low=cic_low(f00,f01,f10,f11,YS,YS01)
est_dci_dci=cic_dci(f00,f01,f10,f11,YS,YS01)
diary off