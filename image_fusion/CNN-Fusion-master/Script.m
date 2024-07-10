close all;
clear all;
clc;

A  = imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\1.bmp');
B  = imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\2.bmp');
if size(A)~=size(B)
    error('two images are not the same size.');
end
%figure,imshow(A);figure,imshow(B);

model_name = 'model/cnnmodel.mat';

F=CNN_Fusion(A,B,model_name);

%figure,imshow(F);
imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\5_CNN.bmp');



for K = 3:100
    A  = imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\5_CNN.bmp');
    B  = imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\', num2str(K) ,'.bmp'));
    if size(A)~=size(B)
    error('two images are not the same size.');
    end
    %figure,imshow(A);figure,imshow(B);

    model_name = 'model/cnnmodel.mat';

    F=CNN_Fusion(A,B,model_name);

    %figure,imshow(F);
    imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\5_CNN.bmp');
    
end