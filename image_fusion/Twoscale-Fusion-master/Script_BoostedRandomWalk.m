% This code is in association with the following paper
% "Multi-focus image fusion using boosted random walks-based algorithm with two-scale focus maps"
% Authors: Jinlei Ma, Zhiqiang Zhou, Bo Wang, Lingjuan Miao, Hua Zong.
% Code edited by Jinlei Ma, email: majinlei121@163.com

% Script_BoostedRandomWalk.m aims to implement the image fusion using boosted random walk,
% corresponding to Section 2.3 Boosting of random walks-based algorithm of the paper.

clear all
close all

for num = 1:6

% Multi-focus source images, range in [0,1]
I1 = double(imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' , num2str(num) , '\input\1.bmp')))/255;
I2 = double(imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\input\2.bmp')))/255;


% TwoScale fusion
% tic
[FocusMap,Fused] = TwoScale_Fusion(I1,I2);
% toc

imwrite(Fused,[strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\100\34_BRW.bmp')]);

for K = 3:100
    image_input1=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\100\34_BRW.bmp'));
    image_input2=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\input\', num2str(K) ,'.bmp'));
    [FocusMap,Fused] = TwoScale_Fusion(I1,I2);
    imwrite(Fused,[strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\100\34_BRW.bmp')]);
   % fprintf('K')
end
end