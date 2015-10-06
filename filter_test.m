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
%---------------------------
%I = handler.average_filter(R, 3, 3);

%prueba filtro gaussioano
%---------------------------
%I = handler.gaussian_filter(R, 5, 3);

%prueba log filter
%---------------------------
%I = handler.log_filter(R, 5, 3);

%prueba media filter
%---------------------------
%I = handler.median_filter(R, 10);

%prueba max_filter
%---------------------------
%I = handler.max_filter(R, 5);

%prueba min_filter
%---------------------------
%I = handler.min_filter(R, 5);

imshow(I);figure,imhist(I);
