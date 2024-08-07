% This code is in association with the following paper
% "Multi-focus image fusion using boosted random walks-based algorithm with two-scale focus maps"
% Authors: Jinlei Ma, Zhiqiang Zhou, Bo Wang, Lingjuan Miao, Hua Zong.
% Code edited by Jinlei Ma, email: majinlei121@163.com

% Script_RandomWalk.m aims to implement the image fusion using random walk,
% corresponding to Section 2.2 Estimation using random walks of the paper.

clear all
close all

% Multi-focus source images, range in [0,1]
I1 = double(imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\4\input\1.bmp'))/255;
I2 = double(imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\4\input\2.bmp'))/255;

%figure;imshow(I1);
%figure;imshow(I2);

% TwoScale fusion
% tic
[FocusMap,Fused] = TwoScale_Fusion_RW(I1,I2);
% toc

imwrite(Fused,['E:\research\box_100_result\34_RW.bmp']);

% Image show
% figure;imshow(FocusMap);
% figure;imshow(Fused);

for K = 3:100
    image_input1=imread('E:\research\box_100_result\34_RW.bmp');
    image_input2=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\4\input\', num2str(K) ,'.bmp'));
    [FocusMap,Fused] = TwoScale_Fusion_RW(I1,I2);
    imwrite(Fused,['E:\research\box_100_result\34_RW.bmp']);
 fprintf('K')
    
end