clc;
close all;
clear all

num = 4;

%% 循环部分
imgPath =strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\C_G\'); % 图像库路径
imgDir = dir([imgPath '*.bmp']); % 遍历所有图片

for i = 1:length(imgDir) % 遍历结构体就可以一一处理图片了
%img = imread([imgPath imgDir(i).name]); %读取每张图片

X = imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\label\depth_100_r.bmp'));     % 真实深度图        
Y = imread(strcat(imgPath,imgDir(i).name));  % 预测深度图
%Y = imread(strcat(imgPath,imgDir(i).name));  

width=size(X,2) ;%获取图像宽
length=size(X,1); %获取图像长
N = width * length;

%使得图像每个像素值为浮点型
X = double(X);
Y = double(Y);
 
A = Y-X;
B = X.*Y;

%% 运算
M1  = abs(Y-X)./X;  
AbsRel =sum(M1(:))/N ;              %绝对相对误差

M2 = (abs(Y-X).^2)./X; 
SqRel =sum(M2(:))/N ;                 %平方相对误差

M3 = (abs(Y-X).^2);
RMS = sqrt((sum(M3(:))/N));           %均方根误差

M4 = abs(log10(Y)-log10(X)).^2;
%%去除inf 很重要！！！ 
data11=isinf(M4);
[inf_r, inf_c]=find(data11==1);
M4(inf_r,:)=[];
logRMS = sqrt(sum(sum(M4))/N) ;  %对数均方根误差

thr = 1.25;  %阈值: 1.25 OR 1.25^2  OR 1.25^3
M5 = X./Y;
M6 = Y./X;
M7 = max(M5,M6);
correct = sum(M7(:)<thr)/N;  %精确度

%% 展示结果
% display(AbsRel);
% display(SqRel);
% display(RMS);
% display(logRMS);
% display(strcat('准确度 = ',num2str(correct*100),'%'));


%% 写入文件
% 写入名称
name_res = strcat(imgDir(i).name);
range_name = strcat('A',num2str(i+1));
writematrix(name_res,strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\compare_4.xls'),'Sheet',3,'Range',range_name)

% 写入数据
data = [AbsRel,SqRel,RMS,logRMS,correct];
range_data = strcat('B',num2str(i+1),":F",num2str(i+1));
writematrix(data,strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\compare_4.xls'),'Sheet',3,'Range',range_data)
end