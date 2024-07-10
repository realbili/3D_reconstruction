clear all, clc, close all
%% Load the variables of the focus sequence:

%load imdata.mat
t1=clock;
width = 512;
height = 512;
count = 100;
imdata.ROI = [1,1,width,height];   %region of interest 感兴趣区域 一维数组，四个元素 
Imgcount = 1;
% 基本路径设置
for j = 6  %图片集个数
    BaseName = 'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\';
    %BaseName = 'I:\A_FOCUS_Data\Aligned\bucket\';
    BaseNameSave = strcat(BaseName, num2str(j),'\input\');
    %BaseNameSave = 'I:\A_FOCUS_Data\Aligned\bucket\';
    BaseNameCompare = strcat(BaseName, num2str(j), '\C\');
    if exist(BaseNameCompare,'file')
        rmdir(BaseNameCompare,'s');
    end
    mkdir(BaseNameCompare);
    % 对图片进行遍历
    for i = 1:count  %每个图片集图片数
        str = strcat(BaseNameSave, num2str(i), '.bmp');
        imdata.images{1,i} = str;  %导入图片的地址 str类型
    end
    imdata.z = zeros(width,width);   %W*W的全0矩阵
    imdata.focus = zeros(1,count);   %1*count的全0矩阵

    
    for jj = 1:37
        switch jj
            case 1
                resultname = 'ACMO';
            case 2
                resultname = 'BREN';
            case 3
                resultname = 'CHEB';
            case 4
                resultname = 'CONT';
            case 5
                resultname = 'CURV';
            case 6
                resultname = 'DCTE';
            case 7
                resultname = 'DCT';
             case 8
                resultname = 'DCTM';
            case 9
                resultname = 'EIGV';
            case 10
                resultname = 'GDER';
            case 11
                resultname = 'GLVA';
            case 12
                resultname = 'GLLV';
            case 13
                resultname = 'GLVN';
            case 14
                resultname = 'GLVM';
             case 15
                resultname = 'GRAE';
            case 16
                resultname = 'GRAT';
            case 17
                resultname = 'GRAS';
            case 18
                resultname = 'HELM';
            case 19
                resultname = 'HISE';
            case 20
                resultname = 'HISR';
             case 21
                resultname = 'LAPE';
            case 22
                resultname = 'LAPM';
            case 23
                resultname = 'LAPV';
            case 24
                resultname = 'RDF';
            case 25
                resultname = 'LAPD';
            case 26
                resultname = 'SMML';
            case 27
                resultname = 'MDML';
            case 28
                resultname = 'LAP3D';
            case 29
                resultname = '3DSF';
            case 30
                resultname = 'SF';
            case 31
                resultname = 'TEN';
            case 32
                resultname = 'TENV';
             case 33
                resultname = 'VOLS';
            case 34
                resultname = 'NSWT';
            case 35
                resultname = 'WAVV';
            case 36
                resultname = 'WAVELET';
            case 37
                resultname = 'CURVELET';        
                
%            case 1
%                 resultname = 'SF';  (33)
%             case 2
%                 resultname = 'TEN'; (34)
%             case 3
%                 resultname = 'LAPD';(26)
%             case 4
%                 resultname = 'MDML';(28)
%             case 5
%                 resultname = 'SMML';(27)
%             case 6
%                 resultname = 'CURVELET';(40)
%             case 7
%                 resultname = 'NSWT';(37)

        end
        [z, r] = sff1227(imdata.images, 'fmeasure',resultname, 'filter',9);
        val = max(max(z));
        val = val+1;
        res = val-z;
        str = strcat(BaseNameCompare,resultname, '.bmp');
        imwrite(uint8(res),str);
    end
end
t2=clock;
etime(t2,t1)
%% Carve depthmap by removing pixels with R<20 dB:  
%信噪比修正
zc = z;
zc(r<20) = nan;
Final = sum(r(:))./width*width;

%% Display the result:
% close(gcf), figure
% subplot(1,2,1), surf(z), shading flat , %colormap copper
% set(gca, 'zdir', 'reverse', 'xtick', [], 'ytick', [])
% axis tight, grid off, box on
% zlabel('pixel depth (mm)')
% title('Full depthmap')
% colorbar
% 
% subplot(1,2,2), surf(zc), shading interp, %colormap copper
% set(gca, 'zdir', 'reverse', 'xtick', [], 'ytick', [])
% axis tight, grid off, box on
% zlabel('pixel depth (mm)')
% title('Carved depthmap (R<20dB)')
% colorbar

% References:
% [1] S.K. Nayar and Y. Nakagawa, PAMI, 16(8):824-831, 1994.
% [2] S. Pertuz, D. Puig, M. A. Garcia, Reliability measure for shape-from
% focus, IMAVIS, 31:725?34, 2013.