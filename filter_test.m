handler = functions_helper();
%image = imread('imagen2.jpg');
image = imread('imagen3.JPG');
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
%I = handler.median_filter(R, 150);

%prueba max_filter
%---------------------------
%I = handler.max_filter(R, 5);

%prueba min_filter
%---------------------------
%I = handler.min_filter(R, 5);


%trabajo con imagen a mejorar placa
I = handler.log_filter(G, 10, 1);
I = I+R;
I = handler.gaussian_filter(I, 15, 2);
%imshow(I);
%figure,
I (I < 90) = 0;
I (I > 150) = 0;
%G (G >=130) = 0;
I = handler.histogram_expansion(im2double(I));
imshow(I);%figure,imhist(G);
imwrite(I,'imagen_edit.JPG')

%figure, imshow(R),figure,imshow(G),figure,imshow(B)