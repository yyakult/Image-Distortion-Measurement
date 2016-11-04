function [MSE_nearest, MSE_bilinear, MSE_bicubic] = MSE(filename, lat1, lng1, lat2, lng2, W_DownSample, H_DownSample)
% *********************************************************
% filename: the filename of the image
% lat1: latitude of p1. 
% lng1: longtitude of p1
% lat2: latitude of p2
% lng2: longtitude of p2
% 
% latitude in (-90,90]
% longtitude in (-180,180]
%   +-----------------------------------+ (90)
%   |                                   |
%   |          p1                       |
%   |           +-------+               |
%   |           |       |               |0
%   |           +-------+               |
%   |                    p2             |
%   |                                   |
%   +-----------------------------------+ (-90)
%  (-180)             0                (180)
%
% p1(lat1, lng1)--->(x1, y1)    x in [1, H]
% p2(lat2, lng2)--->(x2, y2)    y in [1, W]
% *********************************************************
I_origin = imread(filename);
[H,W,N] = size(I_origin);

x1 = floor((1 - double(lat1 + 90.0) / 180.0) * H) + 1;
y1 = floor((double(lng1 + 180.0) / 360.0) * W) + 1; 
x2 = floor((1 - double(lat2 + 90.0) / 180.0) * H);
y2 = floor((double(lng2 + 180.0) / 360.0) * W);

I = I_origin(x1:x2, y1:y2, :);
%imshow(I);

[h,w,n] = size(I);

I_NEARESR = imresize(I,[floor(h*H_DownSample) floor(w*W_DownSample)],'nearest');
I_BILINEAR = imresize(I,[floor(h*H_DownSample) floor(w*W_DownSample)],'bilinear');
I_BICUBIC = imresize(I,[floor(h*H_DownSample) floor(w*W_DownSample)],'bicubic');

I_NEARESR_SU = imresize(I_NEARESR,[h w],'nearest');
I_BILINEAR_SU = imresize(I_BILINEAR,[h w],'bilinear');
I_BICUBIC_SU = imresize(I_BICUBIC,[h w],'bicubic');

I = double(I);
I_NEARESR_SU = double(I_NEARESR_SU);
I_BILINEAR_SU = double(I_BILINEAR_SU);
I_BICUBIC_SU = double(I_BICUBIC_SU);

MSE_nearest = sum( sum(sum((I-I_NEARESR_SU).^2))/(w*h) ) / 3;
MSE_bilinear = sum( sum(sum((I-I_BILINEAR_SU).^2))/(w*h) ) / 3;
MSE_bicubic = sum( sum(sum((I-I_BICUBIC_SU).^2))/(w*h) ) / 3;

%PSNR=20*log10(MAX/sqrt(MES));




