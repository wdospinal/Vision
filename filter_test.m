handler = functions_helper();
img = imread('..\Fotos\Recortadas\IMG_2148.JPG');
% [R, G, B] = handler.get_rgb_channels(img);

% Prueba expancion histogram
%I = handler.histogram_expansion(im2double(R));
%I2 = imadjust(im2double(R));

% Prueba linear_transformation
%I = handler.linear_transformation(R,2,20);
%imshow(I);

% Prueba filtro promedio
%I = handler.average_filter(R, 3, 3);
%imshow(I);figure,imhist(I);
%imhist(I); figure, imhist(I2);

% Prueba filtro LOG
% I = handler.log_filter(image, 5, 0.5);
% imshow(I);

img_yiq = rgb2ntsc(img);
img_hsv = rgb2hsv(img);
img_xyz = rgb2xyz(img);
img_lab = rgb2lab(img);
img_ycbcr = rgb2ycbcr(img);

img_array = {img, img_yiq, img_hsv, img_xyz, img_lab, img_ycbcr};
name_array = {'RGB', 'YIQ', 'HSV', 'XYZ', 'LAB', 'YCBCR'};

size = length(img_array);
for i = 1:size
    [R1, G1, B1] = handler.get_rgb_channels(img_array{i});
    subplot (1, 3, 1); imshow(R1); title(strcat('Rojo ', name_array(i)))
    subplot (1, 3, 2); imshow(G1); title(strcat('Verde ', name_array(i)))
    subplot (1, 3, 3); imshow(B1); title(strcat('Azul ', name_array(i)))
    if i < size
        figure
    end
end



