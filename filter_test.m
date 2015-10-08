handler = functions_helper();
img = imread('/home/android/Work/Vision/Fotos/Recortadas/IMG_2172.jpg');
% [R, G, B] = handler.get_rgb_channels(img);


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


img_yiq = rgb2ntsc(img);
img_hsv = rgb2hsv(img);
%img_xyz = rgb2xyz(img);
%img_lab = rgb2lab(img);
img_ycbcr = rgb2ycbcr(img);

%   Muestra todos los canales de la imagen para ver cual es mejor
%img_array = {img, img_yiq, img_hsv, img_ycbcr};
%name_array = {'RGB', 'YIQ', 'HSV', 'YCBCR'};
%
%size = length(img_array);
%for i = 1:size
%    [R1, G1, B1] = handler.get_rgb_channels(img_array{i});
%    subplot (1, 3, 1); imshow(R1); title(strcat('Rojo ', name_array(i)))
%    subplot (1, 3, 2); imshow(G1); title(strcat('Verde ', name_array(i)))
%    subplot (1, 3, 3); imshow(B1); title(strcat('Azul ', name_array(i)))
%    if i < size
%        figure
%    end
%end

%     Quitar mas fondo de la imagen  verdeHSV- verdeYIQ 
[R1, G1, B1] = handler.get_rgb_channels(img_hsv);
[R1, G2, B1] = handler.get_rgb_channels(img_yiq);
imshow(G1),figure,imshow(G2)
I = G1 - G2;
%%I2 = handler.log_filter(I, 5, 0.5);
%I(I <  0.5) = 0;
%I(I >  0.7) = 0;
%%I = I + I2;
%imshow(I);
%%I = handler.histogram_expansion(im2double(I));
%imwrite(I,'edit.jpg');

