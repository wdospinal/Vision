handler = functions_helper();
image = imread('test.jpg');
[R G B] = handler.get_rgb_channels(image);
% I = handler.histogram_expansion(im2double(R));
% I2 = imadjust(im2double(R));
% 
% imhist(I); figure, imhist(I2);

%I = handler.average_filter(R, 3, 3);
%imshow(I);