clear all
close all

I1 = imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\1.bmp');
I2 = imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\1.bmp');

tic
I1 = im2double(I1);
I2 = im2double(I2);
img1 = I1;
img2 = I2;

% figure;imshow(img1);
% figure;imshow(img2);

if size(I1,3) == 3
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
end

s1 = 5;%5
s2 = 11;%11
s3 = 17;%17

[map1,map2,map3] = Multiscale_SML(I1,I2,s1,s2,s3);



r1 = 5;%5
eps1 = 10^(-2);%0.01

r2 = 14;%14
eps2 = 10^(-3);

r3 = 21;%21
eps3 = 10^(-4);

[map1_guided,map2_guided,map3_guided] = Multiscale_Guided(I1, map1, map2, map3, r1, eps1, r2, eps2,r3, eps3);




[X,Y,Z]=size(I1);
sigma = 0.01;

[x1,x2,x3,y1,y2,y3] = solvedirichletboundary(map1_guided,map2_guided,map3_guided,sigma,I1);

map = zeros(size(map1_guided));
map(x1 >= x2 & x1 >= x3) = map1_guided(x1 >= x2 & x1 >= x3);
map(x2 >= x1 & x2 >= x3) = map2_guided(x2 >= x1 & x2 >= x3);
map(x3 >= x1 & x3 >= x2) = map3_guided(x3 >= x1 & x3 >= x2);

toc

r = 3;
eps = 0.01;
final_map = guidedfilter(I1, map, r, eps);
% figure;imshow(final_map);


map = final_map;
if size(img1,3) == 1
    fused = map.*img1 + (1-map).*img2;
else
    fused(:,:,1) = map.*img1(:,:,1) + (1-map).*img2(:,:,1);
    fused(:,:,2) = map.*img1(:,:,2) + (1-map).*img2(:,:,2);
    fused(:,:,3) = map.*img1(:,:,3) + (1-map).*img2(:,:,3);
end

imwrite(fused,['E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\22_MSF.bmp']);


for K = 3:100
    I1 = imread('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\22_MSF.bmp');
I2 = imread(strcat('E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\input\', num2str(K) ,'.bmp'));

tic
I1 = im2double(I1);
I2 = im2double(I2);
img1 = I1;
img2 = I2;

% figure;imshow(img1);
% figure;imshow(img2);

if size(I1,3) == 3
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
end

s1 = 5;%5
s2 = 11;%11
s3 = 17;%17

[map1,map2,map3] = Multiscale_SML(I1,I2,s1,s2,s3);



r1 = 5;%5
eps1 = 10^(-2);%0.01

r2 = 14;%14
eps2 = 10^(-3);

r3 = 21;%21
eps3 = 10^(-4);

[map1_guided,map2_guided,map3_guided] = Multiscale_Guided(I1, map1, map2, map3, r1, eps1, r2, eps2,r3, eps3);




[X,Y,Z]=size(I1);
sigma = 0.01;

[x1,x2,x3,y1,y2,y3] = solvedirichletboundary(map1_guided,map2_guided,map3_guided,sigma,I1);

map = zeros(size(map1_guided));
map(x1 >= x2 & x1 >= x3) = map1_guided(x1 >= x2 & x1 >= x3);
map(x2 >= x1 & x2 >= x3) = map2_guided(x2 >= x1 & x2 >= x3);
map(x3 >= x1 & x3 >= x2) = map3_guided(x3 >= x1 & x3 >= x2);

toc

r = 3;
eps = 0.01;
final_map = guidedfilter(I1, map, r, eps);
% figure;imshow(final_map);


map = final_map;
if size(img1,3) == 1
    fused = map.*img1 + (1-map).*img2;
else
    fused(:,:,1) = map.*img1(:,:,1) + (1-map).*img2(:,:,1);
    fused(:,:,2) = map.*img1(:,:,2) + (1-map).*img2(:,:,2);
    fused(:,:,3) = map.*img1(:,:,3) + (1-map).*img2(:,:,3);
end

imwrite(fused,['E:\research\A_FOCUS_Data\4DLightFieldDataset_PSF\test\6\100\22_MSF.bmp']);
    
end




























