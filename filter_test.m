clc;
clear;
close all;

h = functions_helper();
img = imread('..\Fotos\Recortadas\IMG_2162.jpg');
% [R, G, B] = h.get_rgb_channels(img);

%%prueba expancion histogram
%---------------------------
%I = h.histogram_expansion(im2double(R));
%I2 = imadjust(im2double(R));

%%prueba linear_transformation
%---------------------------
%I = h.linear_transformation(R,2,20);

%%prueba filtro promedio
%---------------------------
%I = h.average_filter(R, 3, 3);

%%prueba filtro gaussioano
%---------------------------
%I = h.gaussian_filter(R, 5, 3);

%%prueba log filter
%---------------------------
%I = h.log_filter(R, 5, 3);

%%prueba media filter
%---------------------------
%I = h.median_filter(R, 150);

%%prueba max_filter
%---------------------------
%I = h.max_filter(R, 5);

%%prueba min_filter
%---------------------------
%I = h.min_filter(R, 5);

%%  Muestra todos los canales de la imagen para ver cual es mejor
img_yiq = rgb2ntsc(img);
% img_hsv = rgb2hsv(img);
% img_xyz = rgb2xyz(img);
% img_lab = rgb2lab(img);
img_ycbcr = rgb2ycbcr(img);


% img_array = {img, img_yiq, img_hsv, img_xyz, img_lab, img_ycbcr};
% name_array = {'RGB', 'YIQ', 'HSV', 'XYZ', 'LAB', 'YCBCR'};
% 
% size = length(img_array);
% for i = 1:size
%    [R1, G1, B1] = h.get_rgb_channels(img_array{i});
%    subplot (1, 3, 1); imshow(R1); title(strcat('Rojo ', name_array(i)))
%    subplot (1, 3, 2); imshow(G1); title(strcat('Verde ', name_array(i)))
%    subplot (1, 3, 3); imshow(B1); title(strcat('Azul ', name_array(i)))
%    if i < size
%        figure
%    end
% end


% I = h.transformation_gamma_three(img_hsv, 0.85, 1.3);
% [R, G, B] = h.get_rgb_channels(I);
% I = edge(G, 'Canny', [], 0, 1.0);
% I2 = edge(G, 'Canny', [], 0, 2.0);
% I3 = edge(G, 'Canny', [], 0, 3.0);

% I = mat2gray(img);
% [I, x] = edge(I(:,:,1), 'Canny', [], 'both', 5);
% imshow(I);
%[R1, G1, B1] = h.get_rgb_channels(img_yiq);
[R, G, B] = h.get_rgb_channels(img_ycbcr);
bordes = h.log_filter(B, 5, 0.5);
B = B + bordes;
B = h.thresholding(B, 70, 115);
imwrite(B,'um.jpg');
B = h.median_filter(B, 3);
imshow(B);
imwrite(B,'fil.jpg');
% [I, x] = edge(B, 'Canny', [], 'both', 1.5);
% imshow(I);

% [R, G2, B] = h.get_rgb_channels(img_hsv);
% figure, imshow(G2);
% figure, imshow(im2uint8(G2) - G)




