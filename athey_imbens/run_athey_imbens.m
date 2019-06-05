clear all
cd /Users/juan/Dropbox/CollusionAuctions/minimumPrices/final_files_JPE/final_data_files/athey_imbens
my_dir='/Users/juan/Dropbox/CollusionAuctions/minimumPrices/final_files_JPE/final_data_files/athey_imbens';
%[my_dir,name,ext] = fileparts(my_dir);
dir_data=strcat(my_dir,'/data');
dir_output=strcat(my_dir,'/output');
files=dir('data');
files = {files([files.isdir]).name};
files = files(~ismember(files,{'.','..'}));
for i=1:length(files) % i= 1
    display('file name')
    display(files{i})
    name=sprintf(files{i});
    %control data, control A
    y00A=strcat(dir_data,'/',name,'/Y00A.csv');
    y00A=csvread(y00A,1); %YmnX corresponds to Y_group_time_controlcity
    y00A=y00A(:,2);
    y01A=strcat(dir_data,'/',name,'/Y01A.csv');
    y01A=csvread(y01A,1);
    y01A=y01A(:,2);
    %control data, control B
    y00B=strcat(dir_data,'/',name,'/Y00B.csv');
    y00B=csvread(y00B,1); %YmnX corresponds to Y_group_time_controlcity
    y00B=y00B(:,2);
    y01B=strcat(dir_data,'/',name,'/Y01B.csv');
    y01B=csvread(y01B,1);
    y01B=y01B(:,2);
    %treatment data
    y10A=strcat(dir_data,'/',name,'/Y10A.csv');
    y10A=csvread(y10A,1);
    y10A=y10A(:,2);
    
    y10B=strcat(dir_data,'/',name,'/Y10B.csv');
    y10B=csvread(y10B,1);
    y10B=y10B(:,2);
    
    
    y11=strcat(dir_data,'/',name,'/Y11.csv');
    y11=csvread(y11,1);
    y11=y11(:,2);
    qq=linspace(0.05,0.95,19)';
    %qq=linspace(0.1,0.9,9)';
    filename=strcat(dir_output,'/',name,'/');
    [est,est1,se] = main(y00A,y01A,y00B,y01B,y10A,y10B,y11,qq,filename);
end
