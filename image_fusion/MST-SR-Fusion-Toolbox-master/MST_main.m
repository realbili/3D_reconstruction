clear all;
close all;
clc;

addpath(genpath('dtcwt_toolbox'));
addpath(genpath('fdct_wrapping_matlab'));
addpath(genpath('nsct_toolbox'));

for num = 1:6

%[imagename1 imagepath1]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\input\1.bmp'));    
%[imagename2 imagepath2]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\input\2.bmp'));    

%figure;imshow(image_input1);
%figure;imshow(image_input2);

% if size(image_input1)~=size(image_input2)
%     error('two images are not the same size.');
% end

A=double(image_input1);
B=double(image_input2);

level=3;

tic;

if size(A,3)==1    %for gray images
    F = lp_fuse(A, B, level, 3, 3);       %LP               改动1
    %F = rp_fuse(A, B, level, 3, 3);      %RP
    %F = dwt_fuse(A, B, level);           %DWT
    %F = dtcwt_fuse(A,B,level);           %DTCWT
    %F = curvelet_fuse(A,B,level+1);      %CVT
    %F = nsct_fuse(A,B,[2,3,3,4]);        %NSCT
else               %for color images
    F=zeros(size(A));
    for i=1:3
        F(:,:,i) = lp_fuse(A(:,:,i), B(:,:,i), level, 3, 3);       %LP                改动2
        %F(:,:,i) = rp_fuse(A(:,:,i), B(:,:,i), level, 3, 3);      %RP
        %F(:,:,i) = dwt_fuse(A(:,:,i), B(:,:,i), level);           %DWT
        %F(:,:,i) = dtcwt_fuse(A(:,:,i),B(:,:,i),level);           %DTCWT
        %F(:,:,i) = curvelet_fuse(A(:,:,i),B(:,:,i),level+1);      %CVT
        %F(:,:,i) = nsct_fuse(A(:,:,i),B(:,:,i),[2,3,3,4]);        %NSCT
    end
end
toc;

%figure;imshow(uint8(F));
imwrite(uint8(F),[strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\100\24_LP.bmp')]);               %改动3

for K = 3:100
    image_input1=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\100\24_LP.bmp'));                 %改动4
    image_input2=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\input\', num2str(K) ,'.bmp'));    
    A=double(image_input1);
    B=double(image_input2);
    
    level=4;

tic;

if size(A,3)==1    %for gray images
    F = lp_fuse(A, B, level, 3, 3);       %LP                %改动5
    %F = rp_fuse(A, B, level, 3, 3);      %RP
    %F = dwt_fuse(A, B, level);           %DWT
    %F = dtcwt_fuse(A,B,level);           %DTCWT
    %F = curvelet_fuse(A,B,level+1);      %CVT
    %F = nsct_fuse(A,B,[2,3,3,4]);        %NSCT
else               %for color images
    F=zeros(size(A));
    for i=1:3
        F(:,:,i) = lp_fuse(A(:,:,i), B(:,:,i), level, 3, 3);       %LP                 %改动6
        %F(:,:,i) = rp_fuse(A(:,:,i), B(:,:,i), level, 3, 3);      %RP
        %F(:,:,i) = dwt_fuse(A(:,:,i), B(:,:,i), level);           %DWT
        %F(:,:,i) = dtcwt_fuse(A(:,:,i),B(:,:,i),level);           %DTCWT
        %F(:,:,i) = curvelet_fuse(A(:,:,i),B(:,:,i),level+1);      %CVT
        %F(:,:,i) = nsct_fuse(A(:,:,i),B(:,:,i),[2,3,3,4]);        %NSCT
    end
end
toc;

%figure;imshow(uint8(F));
imwrite(uint8(F),[strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\' ,num2str(num) , '\100\24_LP.bmp')]);                 %改动7
    
end

end

