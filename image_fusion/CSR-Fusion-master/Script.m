close all;
clear all;
clc;

% Load dictionary
load('dict.mat');  

% Load images
A=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\1.bmp');
B=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\2.bmp');
%figure,imshow(A)
%figure,imshow(B)

%key parameters
lambda=0.01; 
flag=1; % 1 for multi-focus image fusion and otherwise for multi-modal image fusion

%CSR-based fusion
tic;
F=CSR_Fusion(A,B,D,lambda,flag);
toc;

%figure,imshow(F);
imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\6_CSR.bmp');

for K = 3:100
%     load('dict.mat');  

    % Load images
    A=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\6_CSR.bmp');
    B=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\', num2str(K) ,'.bmp'));
    %figure,imshow(A)
    %figure,imshow(B)

    %key parameters
    lambda=0.01; 
    flag=1; % 1 for multi-focus image fusion and otherwise for multi-modal image fusion

    %CSR-based fusion
    tic;
    F=CSR_Fusion(A,B,D,lambda,flag);
    toc;

    %figure,imshow(F);
    imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\6_CSR.bmp');
    
end
