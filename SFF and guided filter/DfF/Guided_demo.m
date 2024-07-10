path = 'I:\A_FOCUS_Data\4DLightFieldDataset_PSF\test\';
param.eps = 0.001;
param.r = 10;

    k=2;
    C_path = strcat(path, num2str(k),'\C\');
    L_path = strcat(path, num2str(k),'\label\');
    Depth_img = double(imread(strcat(C_path, '1.bmp')));
    Fused_img = double(imread(strcat(L_path, 'fusion.png')));
    %CheightTemp = CostAggGuided(Depth_img, Fused_img, param);
    CheightTemp = weighted_median_filter(Depth_img, Fused_img, param);
    imwrite(uint8(CheightTemp(:,:,1)),strcat(C_path, 'G_new.bmp'));

