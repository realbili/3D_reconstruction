function [rdflabel, rdf_labels,im_all_in_focus] = zjf_RDF_DFF(pathval, numimg, show_fig, use_fast_jwmf, use_rdf_agg, file_type)
%ZJF_RDF_DFF 此处显示有关此函数的摘要
%   此处显示详细说明
% pathval 图像路径 示例 G:\zjf_data\zjf_Simulation\no_noise\1\input\
% numing 图像数量 100
% show_fig 是否展示效果 1
% use_fast_jwmf 1
% use_rdf_agg 1
% file_type 文件类型 示例 '.bmp'
%% load imags
imgs = cell(1, numimg);
imgarr = cell(1, numimg);
maskarr = cell(1, numimg);
for i = 1:numimg
    img = imread(strcat(pathval, num2str(i), file_type));
    I3(:,:,1) = img;
    I3(:,:,2) = img;
    I3(:,:,3) = img;
    imgs{i} = imresize(I3, 0.5);
    imgarr{i} = im2double(imgs{i});
    maskarr{i} = ones(size(imgs{i}(:, :, 1)));
end

%% homography align images
[imgarr, maskarr, ~] = homographyAlign(imgs, 1, numimg, pathval, 0);

%% calculate focus
focrdf = RDFCalcFoc(imgarr, maskarr, 1, 2, 2, numimg );
[~, rdflabel] = max(focrdf, [], 3);
aifrdf = imgLabel(rdflabel, imgarr, numimg);
% 此处是  Label initial RDF
if show_fig
    figure; imagesc(rdflabel); title('Label initial RDF');
end

%% aggregate cost
tic
param.eps = 0.001;
if use_rdf_agg
    param.r.r = 10;
    param.r.t = 5;
    param.r.d = 0.5;
    [rdfagg] = CostAggRDF(focrdf, im2double(aifrdf), param);
else
    param.r = 10;
    if use_parallel
        [rdfagg] = CostAggGuided_par(focrdf, im2double(aifrdf), param);
    else
        [rdfagg] = CostAggGuided(focrdf, im2double(aifrdf), param);
    end
end
toc

[~, rdfagglabel] = max(rdfagg, [], 3);
aifrdfagg = imgLabel(rdfagglabel, imgarr, numimg);
if show_fig
    figure; imagesc(rdfagglabel); title('Label aggregated');
end

%% filter result
r = ceil(max(size(aifrdf, 1), size(aifrdf, 2)) / 40);
eps = 0.01^2;
tic
if use_fast_jwmf
    rdf_labels = jointWMF(rdfagglabel, im2double(aifrdfagg), 3, 0.2, 256, 30);
else
    rdf_labels = weighted_median_filter(double(rdfagglabel),im2double(aifrdfagg), 1:numimg, r, eps);
end
toc
im_all_in_focus = imgLabel(rdf_labels, imgarr, numimg);

if show_fig
    figure; imshow(im_all_in_focus);  
%   imwrite(im_all_in_focus, 'fusion.tif');
    title('RDF all in focus image');
    figure; imshow(rdf_labels / 100);  
    title('RDF result');
end

end