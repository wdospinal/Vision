handler = functions_helper();
image = imread('test.jpg');
[R G B] = handler.get_rgb_channels(image);
I = handler.histogram_expansion(R);
I2 = imadjust(R);

imhist(I); figure, imhist(I2);