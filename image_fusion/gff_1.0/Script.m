clc,clear
%%%% gray image fusion
I = load_images( 'E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\',1); 
F = GFF(I);
imshow(F);
%%%% color image fusion
% I = load_images( 'E:/research/boxes',1); 
% F = GFF(I);
 figure,imshow(F);
 imwrite(F,['E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\17_GFF.bmp']);