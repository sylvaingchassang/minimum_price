function [Y00,Y01,Y10,Y11,DY00,DY01,DY10,DY11,BY00,BY01,BY10,BY11]=gen(beta00,beta01,beta10,beta11,N00,N01,N10,N11)

% GENERAL INFORMATION
% this program generates data for the simulations
% it generates data for the continuous, discrete and binary data sets simultaneously

% INPUT
% Ygt for g=0,1, t=0,1 has a continuous density on [0,1] that is linear with slope coefficient 
% equal to betagt. This determines the density
% Ngt for g=0,1, t=0,1 gives the number of observations in each of the four groups

% OUTPUT
% Ygt for g=0,1, t=0,1 is a vector of length Ngt with draws from the density
% f(y)=alpha_gt+beta_gt* y, where the beta_gt is an input and the alpha_gt
% is determined by the fact that the density integrates out to one.
% Dgt is constructed by rounding Ygt up to the next 0.1
% Bgt is constructed by rounding up Ygt to the next 0.5, so it takes the
% values 0.5 and 1.


ND=10;  % number of discrete outcomes
B0=0.5; % binary version is based on cutoff point B0
NB=2;

% Y00
u=rand(N00,1);
beta=beta00;
alpha=1-beta/2;
a=beta;
b=2*alpha;
c=-2*u;
Y00=(-b+sqrt(b*b-4*a*c))/(2*a);

% Y01
u=rand(N01,1);
beta=beta01;
alpha=1-beta/2;
a=beta;
b=2*alpha;
c=-2*u;
Y01=(-b+sqrt(b*b-4*a*c))/(2*a);

% Y10
u=rand(N10,1);
beta=beta10;
alpha=1-beta/2;
a=beta;
b=2*alpha;
c=-2*u;
Y10=(-b+sqrt(b*b-4*a*c))/(2*a);

% Y11
u=rand(N11,1);
beta=beta11;
alpha=1-beta/2;
a=beta;
b=2*alpha;
c=-2*u;
Y11=(-b+sqrt(b*b-4*a*c))/(2*a);

DY00=floor(ND*Y00+1)/ND;
DY01=floor(ND*Y01+1)/ND;
DY10=floor(ND*Y10+1)/ND;
DY11=floor(ND*Y11+1)/ND;

BY00=floor(NB*Y00+1)/NB;
BY01=floor(NB*Y01+1)/NB;
BY10=floor(NB*Y10+1)/NB;
BY11=floor(NB*Y11+1)/NB;

