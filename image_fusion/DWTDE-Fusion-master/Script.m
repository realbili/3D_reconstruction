clc;close all;clear;

A=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\1.bmp');      
B=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\2.bmp');
%figure;imshow(A);figure;imshow(B);

% if size(A)~=size(B)
%     error('two images are not the same size.');
% end

level=3;

tic;
if size(A,3)==1  %for gray images
    F=DWTDE_Fusion(A,B,level); 
else             %for color images
    F=A;
    for i=1:3
        F(:,:,i)=DWTDE_Fusion(A(:,:,i),B(:,:,i),level);
    end
end
toc;

%figure;imshow(F);
imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\11_DWTDE.bmp');

for K = 3:100
    A=imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\11_DWTDE.bmp');      
B=imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\', num2str(K) ,'.bmp'));
%figure;imshow(A);figure;imshow(B);

% if size(A)~=size(B)
%     error('two images are not the same size.');
% end

level=3;

tic;
if size(A,3)==1  %for gray images
    F=DWTDE_Fusion(A,B,level); 
else             %for color images
    F=A;
    for i=1:3
        F(:,:,i)=DWTDE_Fusion(A(:,:,i),B(:,:,i),level);
    end
end
toc;

%figure;imshow(F);
imwrite(F,'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\11_DWTDE.bmp');
    
end
