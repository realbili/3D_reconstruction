close all;
clear all;
clc;

tic;
image_input1=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\7\input\1.bmp');
image_input2=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\7\input\2.bmp');
    %figure;imshow(image_input1);
    %figure;imshow(image_input2);

%     if size(image_input1)~=size(image_input2)
%         error('two images are not the same size.');
%     end

    mode=1;  %for multi-focus image fusion
    %mode=0;  %for multi-modal image fusion


    sigma = 0; %standard deviation of added noise, sigma<=0 means images are not corrupted by noise
    if sigma>0
        v=sigma*sigma/(255*255);
        image_input1=imnoise(image_input1,'gaussian',0, v );
        image_input2=imnoise(image_input2,'gaussian',0, v );
        figure;imshow(image_input1);
        figure;imshow(image_input2);
    end

img1=double(image_input1);
img2=double(image_input2);

addpath(genpath('ksvdbox'));
dic_size=256; % 256 or 128
load(['E:/research/image_fusion/1/ASR-Fusion-master/Dictionary/D_100000_' num2str(dic_size) '_8_0.mat']); %the first sub-dictionary 'D'
load(['E:/research/image_fusion/1/ASR-Fusion-master/Dictionary/D_100000_' num2str(dic_size) '_8_6.mat']); %other sub-dictionaries 'Dn' and the number is 'dic_number'
overlap = 7;                   
epsilon = 0.1; 
C = 1.15;

tic;
if size(img1,3)==1   %for gray images
    imgf=asr_fuse(img1,img2,D,Dn,dic_number,overlap,8*C*sigma+epsilon,mode);
else                 %for color images
    imgf=zeros(size(img1));  
    for i=1:3
        imgf(:,:,i)=asr_fuse(img1(:,:,i),img2(:,:,i),D,Dn,dic_number,overlap,8*C*sigma+epsilon,mode);
    end
end
toc;

image_fusion=uint8(imgf);
%figure;imshow(image_fusion);
imwrite(image_fusion,['E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\7\100\1_ASR.bmp']);


%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！儉桟悶！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！%
%filename=dir('E:/research/boxes/*.jpg');

for K = 3:100
    
image_input1=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\7\100\1_ASR.bmp');
image_input2=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\7\input\', num2str(K) ,'.bmp'));


% if size(image_input1)~=size(image_input2)
%     error('two images are not the same size.');
% end

% mode=1;  %for multi-focus image fusion
%mode=0;  %for multi-modal image fusion


sigma = 0; %standard deviation of added noise, sigma<=0 means images are not corrupted by noise
if sigma>0
    v=sigma*sigma/(255*255);
    image_input1=imnoise(image_input1,'gaussian',0, v );
    image_input2=imnoise(image_input2,'gaussian',0, v );
    figure;imshow(image_input1);
    figure;imshow(image_input2);
end

img1=double(image_input1);
img2=double(image_input2);

% addpath(genpath('ksvdbox'));
% dic_size=256; % 256 or 128
% load(['E:/research/image_fusion(review)/1/ASR-Fusion-master/Dictionary/D_100000_' num2str(dic_size) '_8_0.mat']); %the first sub-dictionary 'D'
% load(['E:/research/image_fusion(review)/1/ASR-Fusion-master/Dictionary/D_100000_' num2str(dic_size) '_8_6.mat']); %other sub-dictionaries 'Dn' and the number is 'dic_number'
% overlap = 7;                   
% epsilon = 0.1; 
% C = 1.15;

tic;
if size(img1,3)==1   %for gray images
    imgf=asr_fuse(img1,img2,D,Dn,dic_number,overlap,8*C*sigma+epsilon,mode);
else                 %for color images
    imgf=zeros(size(img1));  
    for i=1:3
        imgf(:,:,i)=asr_fuse(img1(:,:,i),img2(:,:,i),D,Dn,dic_number,overlap,8*C*sigma+epsilon,mode);
    end
end
toc;

image_fusion=uint8(imgf);
%figure;imshow(image_fusion);
imwrite(image_fusion,['E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\7\100\1_ASR.bmp']);
fprintf(num2str(K)+"\n");
end
toc;

