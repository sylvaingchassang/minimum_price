function [est,est1,se] = main( y00A,y01A,y00B,y01B,y10A,y10B,y11,qq,filename)
%%take as input the data (ygt), the quantiles for which to compute the
%%A and B broups correspond to samples from different control groups (A and
%%B groups for the treatment group correspond to the time frames for which
%%A and B control group data is available)
%%estimator (qq), and the location where the results are to be saved (filename). 


%%est is a Nq+1 vector and contains [avg effect, difference in quantiles]

%%est1 is a 2xNq vector and contains [realized quantiles of  F11, counterfactual quantiles]

%%se contains bootstrapped standard errors for est

%%Finally the program saves the data as .csv in the folder specified in
%%filename. Cic estimates are stored in a unique table and saved as
%%'cic_level'. 

bootstrap=1000;
Nq1=length(qq)+1;
%% LEVEL
% cic estimates

tabel2=zeros(5,Nq1);

[est,est1,se]=cic(y00A,y01A,y00B,y01B,y10A,y10B,y11,qq,bootstrap);

tabel2(2,:)=est;
tabel2(1,2:Nq1)=qq;
tabel2(4,:)=est1(1,:);
tabel2(5,:)=est1(2,:);
tabel2(3,:)=se(2,:);
csvwrite(strcat(filename,'Cic_level_treated.csv'),tabel2);


end

