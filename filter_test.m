handler = functions_helper();
%image = imread('imagen2.jpg');
image = imread('imagen3.JPG');
[R G B] = handler.get_rgb_channels(image);

%%prueba expancion histogram
%---------------------------
%I = handler.histogram_expansion(im2double(R));
%I2 = imadjust(im2double(R));

%%prueba linear_transformation
%---------------------------
%I = handler.linear_transformation(R,2,20);

%%prueba filtro promedio
%---------------------------
%I = handler.average_filter(R, 3, 3);

%%prueba filtro gaussioano
%---------------------------
%I = handler.gaussian_filter(R, 5, 3);

%%prueba log filter
%---------------------------
%I = handler.log_filter(R, 5, 3);

%%prueba media filter
%---------------------------
%I = handler.median_filter(R, 150);

%%prueba max_filter
%---------------------------
%I = handler.max_filter(R, 5);

%%prueba min_filter
%---------------------------
%I = handler.min_filter(R, 5);

%%mostrar todos los canales RGB
%---------------------------
%figure, imshow(R),figure,imshow(G),figure,imshow(B)

%%trabajo con imagen a mejorar placa
%image = imread('imagen3.JPG');
%[R G B] = handler.get_rgb_channels(image);
%I = handler.histogram_expansion(im2double(G));
%I = handler.log_filter(I, 10, 1);
%I = I + G;
%I = handler.gaussian_filter(I, 15, 2); 
%I (I < 93) = 0;
%I (I > 120) = 0;
%I = handler.histogram_expansion(im2double(I));
%imshow(I);%figure,imhist(G);
%imwrite(I,'imagen_edit.JPG')
%%#########################################

%image = imread('imagen4.JPG');
%[R G B] = handler.get_rgb_channels(image);
%figure, imshow(R),figure,imshow(G),figure,imshow(B)
%I = handler.histogram_expansion(im2double(G));
%I = handler.log_filter(I, 20, 1);
%imwrite(I,'imagen_edit.JPG')
%imshow(I)
%#########################################

image = imread('imagen5.JPG');
[R G B] = handler.get_rgb_channels(image);
%figure, imshow(R),figure,imshow(G),figure,imshow(B)
I = handler.histogram_expansion(im2double(R));
I = handler.max_filter(R, 5);
%I = handler.median_filter(I, 150);
imwrite(I,'imagen_edit.JPG')
imshow(I);figure,imhist(G);



