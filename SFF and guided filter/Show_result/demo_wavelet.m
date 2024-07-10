clc;
clear all;
BaseName = 'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\888\label\';
% str = strcat(BaseName, '1127', '.bmp'); .
str = strcat('result1', '.bmp'); 
pp = wavelet(20, str);
[y,x] = size(pp);                 % 取出图像大小
[X,Y] = meshgrid(1:x,1:y);
axis([0,512,0,512,0,255]);
figure(1);
colormap('jet');

surf(X,Y,255-pp,'FaceAlpha',1);
view(-22,77);
grid on; % grid on后画的图。有网格。grid off 是关掉格�?
shading interp; % 对曲面或图形对象的颜色着色进行色彩的插�?�处理，使色彩平滑过�? 
hold on; % hold on主要是用于添加新绘图的时候保留当前绘�?

imwrite(uint8(pp), 'result.bmp');