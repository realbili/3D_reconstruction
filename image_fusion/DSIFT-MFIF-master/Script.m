close all;
clear all;
clc;


A=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\1\input\1.bmp');
B=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\1\input\2.bmp');

% if size(A)~=size(B)
%     error('two images are not the same size.');
% end

%figure,imshow(A);figure,imshow(B);

%key parameters
scale=48;
blocksize=8;
matching=1;

tic;
F=DSIFT_Fusion(A,B,scale,blocksize,matching);
toc;

%figure,imshow(F);
imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\9_MFIF.bmp');



for K = 3:100
    A=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\9_MFIF.bmp');
    B=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\', num2str(K) ,'.bmp'));

% if size(A)~=size(B)
%     error('two images are not the same size.');
% end

%figure,imshow(A);figure,imshow(B);

%key parameters
% scale=48;
% blocksize=8;
% matching=1;

tic;
F=DSIFT_Fusion(A,B,scale,blocksize,matching);
toc;

%figure,imshow(F);
imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\9_MFIF.bmp');
    
    
end
