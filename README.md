# 3D_reconstruction

## System Code Structure

### 1. Image Fusion

The `image_fusion` directory contains 20 different codes for multi-focus image fusion. These are primarily written in MATLAB and Python. Upon execution, they produce fused results of several images with different depths of field.

### 2. SFF and Guided Filter

This section includes codes for depth information recovery (`SFFDemo1227`) and guided filter optimization. Here's a breakdown of the files:

- **SFFDemo1227**: Implements 37 methods to recover depth information from multi-focus image sequences.
- **G_repair**: Utilizes guided filtering to enhance initial depth maps. Requires selecting a guide image and a target image.
- **show_depth**: Visualizes the 3D information of 2D images.
- **compare_depth**: Compares different depth images to derive optimized results.
- Other directories contain specific implementations of functions related to these processes.
