clc;
clear all;
count=1;  % 融合图像数
% load p3;
width_F = 7;
for i=1:count
    %       BaseName = 'C:\Users\yant\Desktop\show\1\';
    BaseName = 'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\888\C\';
    str = strcat(BaseName, '3DSF', '.bmp');
    [Img(:,:,i), map] = imread(str);
    
    I=101-Img;
    I=I';
    % I=Img;
    %I=Depth2;
    % I = medfilt2(I, [width_F width_F]);
    %str = strcat(BaseName, '10', '.bmp');
    % imwrite(uint8(I),str);
    % I = imresize(I,0.5,'bicubic');
    f=double(I);
    f=fft2(f);
    f=fftshift(f);
    [m,n]=size(f);  %
    d0=40;
    m1=fix(m/2);
    n1=fix(n/2);
    for M=1:m
        for N=1:n
            d=sqrt((M-m1)^2+(N-n1)^2);
            h(M,N)=exp(-d^2/2/d0^2);
        end
    end
    g=f.*h;
    g=ifftshift(g);
    g=ifft2(g);
    g=real(g);
    figure(i+1);
    Radiu=floor(width_F/2);
    [y,x]=size((g(Radiu:end-Radiu+1,Radiu:end-Radiu+1)));                 % 取出图像大小
    [X,Y]=meshgrid(1:x,1:y); % 生成网格坐标
    pp=double((g(Radiu:end-Radiu+1,Radiu:end-Radiu+1)));              % uint8 转换为 double
    c=zeros(size(pp));%获得o阵大小和x相同
    %       str = strcat(BaseName, '47', '.bmp');
    % imwrite(uint8(g),str);
    %   ma=double(max(max(pp)));
    % mi=double(min(min(pp)));
    %pp=(255/(ma-mi))*pp-(255*mi)/(ma-mi);
    %imwrite(uint8(pp),str);
    % Loadimg = imread('D:\Data\8.bmp');
    % Loadimg=flipdim(Loadimg,1);
    %Grayimg = double(Loadimg(1:1:end,1:1:end));
    
    % [rows,cols]=size(Grayimg);
    % r1=zeros(rows,cols);
    % g1=zeros(rows,cols);
    % b1=zeros(rows,cols);
    % r1=double(Grayimg);
    %g1=double(Grayimg);
    % b1=double(Grayimg);
    %  rgb=cat(3,r1,g1,b1);
    % c(:,:,1) = double(rgb(:,:,1)/255.0);
    %  c(:,:,2) = double(rgb(:,:,1)/255.0);
    % c(:,:,3) = double(rgb(:,:,1)/255.0);
    colormap('jet')
    %  surf(X,Y,pp,c);                % 画图
    surf(X,Y,pp);                % 画图
    %plot3(X,Y,pp,'b.');
    grid on;
    %     mesh(X,Y,pp);
    % zlim([50 100]); % F1专用
    % view(-37,58);%样本p3的位置
    % view(-28,78);%样本p1的位置
    % view(-30,74);%样本p4的位置
    %   view(-22,77);%样本p5的位置
    view(-22,77);
    % view(160, 80);
    %     view(0,90);
    shading interp
    axis off
    hold on; % hold on主要是用于添加新绘图的时候保留当前绘图
end

