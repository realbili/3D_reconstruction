import os
from skimage import io
from nets.sesf_net import SESF_Fuse



def main(input_dir, output_dir,num):
    """
    Image Fusion
    :param input_dir: str, input dir with all images stores in one folder
    :param output_dir: str, output dir with all fused images
    :return:
    """
    sesf = SESF_Fuse("cse")
    images_name = sorted(list({item[:-6] for item in os.listdir(input_dir)}))
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    for image_name in images_name:
        print("Fusing {}".format(image_name))
        img1 = io.imread(os.path.join('{0}1.bmp'.format(input_dir)))
        img2 = io.imread(os.path.join('{0}2.bmp'.format(input_dir)))
        fused = sesf.fuse(img1, img2)
        io.imsave(os.path.join(output_dir + "31_SESF.bmp"), fused)

    for i in range(3,100):
        images_name = sorted(list({item[:-6] for item in os.listdir(input_dir)}))
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
        for image_name in images_name:
            print("Fusing {}".format(image_name))
            img1 = io.imread(os.path.join('E:/research/A_FOCUS_Data/4DLightFieldDataset_PSF/test/' + str(num) + '/100/31_SESF.bmp'))
            img2 = io.imread(os.path.join('{0}{1}.bmp'.format(input_dir,i)))
            fused = sesf.fuse(img1, img2)
            io.imsave(os.path.join(output_dir + "31_SESF.bmp"), fused)



if __name__ == "__main__":
    num = 1
    input_dir = os.path.join('E:/research/A_FOCUS_Data/4DLightFieldDataset_PSF/test/' + str(num) + '/input/')
    output_dir = os.path.join('E:/research/A_FOCUS_Data/4DLightFieldDataset_PSF/test/' + str(num) + '/100/')
    main(input_dir, output_dir,num)
