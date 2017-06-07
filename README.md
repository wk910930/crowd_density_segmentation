# Crowd Density & Segmentation Prediction

This project is the implementation and extension of the previous work, which is based on patches. For more details, please refer to the original [paper](http://www.ee.cuhk.edu.hk/~xgwang/papers/zhangLWYcvpr15.pdf).

### Citation

Please cite the original paper in your publications if it helps your research:

```
@inproceedings{zhang2015cross,
  title={Cross-scene crowd counting via deep convolutional neural networks},
  author={Zhang, Cong and Li, Hongsheng and Wang, Xiaogang and Yang, Xiaokang},
  booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
  pages={833--841},
  year={2015}
}
```

### Requirements: software

[Caffe](http://caffe.berkeleyvision.org/) and MATLAB 2014a or above are required. **Notice:** A modified version of Caffe is requried.

### Installation

1. Clone the repository

```Shell
# Make sure to clone with --recursive
git clone https://github.com/wk910930/crowd_density_segmentation.git
```

2. Build Caffe (Code is **private** for now)

```Shell
# Currently the code is not allowed to be public.
```

### Prepare training data

We will call the directory that you cloned `$CROWD_ROOT`. Place your own data under the [data](data).

1. Generate density map for each frame
    * Go to the [scripts](scripts) folder.
    ```Shell
    cd $CROWD_ROOT/scripts
    ```
    * Open MATLAB (desktop or terminnal, both are okay) and run the [gen_density_map.m](gen_density_map.m).
