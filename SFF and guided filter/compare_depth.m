clc;
close all;
clear all

num = 4;

%% ѭ������
imgPath =strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\C_G\'); % ͼ���·��
imgDir = dir([imgPath '*.bmp']); % ��������ͼƬ

for i = 1:length(imgDir) % �����ṹ��Ϳ���һһ����ͼƬ��
%img = imread([imgPath imgDir(i).name]); %��ȡÿ��ͼƬ

X = imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\label\depth_100_r.bmp'));     % ��ʵ���ͼ        
Y = imread(strcat(imgPath,imgDir(i).name));  % Ԥ�����ͼ
%Y = imread(strcat(imgPath,imgDir(i).name));  

width=size(X,2) ;%��ȡͼ���
length=size(X,1); %��ȡͼ��
N = width * length;

%ʹ��ͼ��ÿ������ֵΪ������
X = double(X);
Y = double(Y);
 
A = Y-X;
B = X.*Y;

%% ����
M1  = abs(Y-X)./X;  
AbsRel =sum(M1(:))/N ;              %����������

M2 = (abs(Y-X).^2)./X; 
SqRel =sum(M2(:))/N ;                 %ƽ��������

M3 = (abs(Y-X).^2);
RMS = sqrt((sum(M3(:))/N));           %���������

M4 = abs(log10(Y)-log10(X)).^2;
%%ȥ��inf ����Ҫ������ 
data11=isinf(M4);
[inf_r, inf_c]=find(data11==1);
M4(inf_r,:)=[];
logRMS = sqrt(sum(sum(M4))/N) ;  %�������������

thr = 1.25;  %��ֵ: 1.25 OR 1.25^2  OR 1.25^3
M5 = X./Y;
M6 = Y./X;
M7 = max(M5,M6);
correct = sum(M7(:)<thr)/N;  %��ȷ��

%% չʾ���
% display(AbsRel);
% display(SqRel);
% display(RMS);
% display(logRMS);
% display(strcat('׼ȷ�� = ',num2str(correct*100),'%'));


%% д���ļ�
% д������
name_res = strcat(imgDir(i).name);
range_name = strcat('A',num2str(i+1));
writematrix(name_res,strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\compare_4.xls'),'Sheet',3,'Range',range_name)

% д������
data = [AbsRel,SqRel,RMS,logRMS,correct];
range_data = strcat('B',num2str(i+1),":F",num2str(i+1));
writematrix(data,strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\compare_4.xls'),'Sheet',3,'Range',range_data)
end