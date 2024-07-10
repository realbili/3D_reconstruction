clc;
close all;
clear all;

 param.eps = 0.001;
 param.r = 10;

imgPath = 'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\4\C\';       % ��ʼ���ͼ
fusePath = 'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\4\100\'; %�ں�ͼ��
resPath = 'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\4\C_G\';     %�޸����ͼ
imgDir = dir([imgPath '*.bmp']); % ��������ͼƬ

for i = 1:length(imgDir) 
    Depth_img = double(imread(strcat(imgPath,imgDir(i).name)));
    Fused_img = double(imread(strcat(fusePath, 'depth_100_r.bmp')));
    CheightTemp = CostAggGuided(Depth_img, Fused_img, param);
    imwrite(uint8(CheightTemp(:,:,1)),strcat(resPath,imgDir(i).name ,'_G.bmp'));        %Net_UAD_G.bmp

end

%      Depth_img = double(imread(strcat(imgPath,'DCT.bmp')));
%      Fused_img = double(imread(strcat(fusePath, '17_GFF.bmp')));
%      CheightTemp = CostAggGuided(Depth_img, Fused_img, param);
%      imwrite(uint8(CheightTemp(:,:,1)),strcat(resPath,'_G_.bmp'));      

