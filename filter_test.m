handler = functions_helper();
image = imread('test.jpg');
%image = imread('imagen.JPG');
[R G B] = handler.get_rgb_channels(image);
%prueba expancion histogram
%---------------------------
%I = handler.histogram_expansion(im2double(R));
%I2 = imadjust(im2double(R));

%prueba linear_transformation
%---------------------------
%I = handler.linear_transformation(R,2,20);

%prueba filtro promedio
I = handler.average_filter(G,2,2);

imshow(I);figure,imhist(I);
%imhist(I); figure, imhist(I2);