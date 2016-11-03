1 Image Distortion Measurement
================

-

测量局部全景图片的失真和下采样、纬度的关系。

* 实验一：对同一个区域图像进行不同程度的下采（w、h方向），然后构建 **宽-高-失真** 曲线
* 实验二：对不同区域的图像（相同经度、不同纬度）进行相同程度的下采，然后构建 **纬度-失真** 曲线

MSE.m 使用示例：

在全景图像的中心区域进行宽、高二分之一下采后，计算三种不同插值方法的失真：

```
[nearest, bilinear, bicubic] = MSE(file, 45, -45, -45, 45, 0.5, 0.5);
```

