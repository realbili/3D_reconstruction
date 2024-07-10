clc;
close all;
clear all;

for num = 6
    
imgPath =strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\', num2str(num),'\C_G\'); % ͼ���·��
imgDir = dir([imgPath '_G_.bmp']); % ��������ͼƬ

for i = 1:length(imgDir)
%     BaseName = strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\',num2str(num),'\C\');
%     str = strcat(BaseName, 'CONT.bmp');
    [Img(:,:), map] =imread(strcat(imgPath,imgDir(i).name));
    
    %[Img(:,:), map] = imread(str);
    I=Img';
    %I=255-Img;
    f=double(I);
    [y,x]=size(I);     
    [X,Y]=meshgrid(1:x,1:y); % ������������
    colormap('jet')
    surf(X,Y,f');                % ��ͼ
    axis([0,500,0,500,0,110]); %0��255
    grid off;
    axis on;
    view(45, -75);
    shading interp  
    saveas(gcf, strcat(imgPath, imgDir(i).name,'_show_RE.jpg'));   
end
end
%% ��άչʾ
% z=imread("E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\888\C\CONT.bmp")
% close(gcf), figure
% surf(z), shading flat , %colormap copper
% set(gca, 'zdir', 'reverse', 'xtick', [], 'ytick', [])
% axis tight, grid off, box on
%zlabel('pixel depth (mm)')
%title('Full depthmap')
%colorbar

