clc;
close all;
clear all;

for num = 5
    
imgPath =strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\input\'); % ͼ���·��
resPath = strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num), '\input_rayleigh\'); 
imgDir = dir([imgPath '*.bmp']); % ��������ͼƬ


for i = 1:length(imgDir)
    X = double(imread(strcat(imgPath,imgDir(i).name)));
    %Y1=add_noise(x,'gaussian',0,10);
    Y1=add_noise(X,'rayleigh',30);
    imwrite(Y1,strcat(resPath,imgDir(i).name(1:end-4) ,'_rayleigh.bmp')); 
end
end
