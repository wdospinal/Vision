clc;
clear;
close all;

h = functions_helper();
img = imread('..\Fotos\Recortadas\1.jpg');
% [R, G, B] = h.get_rgb_channels(img);

%%prueba expancion histogram
%---------------------------
% img = h.histogram_expansion(im2double(R));
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
% img_yiq = rgb2ntsc(img);
% img_hsv = rgb2hsv(img);
% img_xyz = rgb2xyz(img);
% img_lab = rgb2lab(img);
img_ycbcr = rgb2ycbcr(img);


% img_array = {img, img_yiq, img_hsv, img_xyz, img_lab, img_ycbcr};
% name_array = {'RGB', 'YIQ', 'HSV', 'XYZ', 'LAB', 'YCBCR'};

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

[M, N, D] = size(img);
[R, G, B] = h.get_rgb_channels(img_ycbcr);
% imshow(G);
% figure, imshow(B);
w_img = imcomplement(B) - G;
% figure, imshow(w_img);
w_img = h.histogram_expansion(w_img);
w_img = h.median_filter(w_img, 5);
% imshow(w_img);
umbral = graythresh(w_img);
bw = im2bw(w_img, umbral);

bw2 = bw;
d_se = strel('disk', 3);
bw = imerode(bw, d_se);

bw = bwareaopen(bw, floor(M/15 * N/15));

% Rellenamos 
bw = imfill(bw, 'holes');
% imshow(bw);
% Probamos la transformada de hough
% [H,theta,rho] = hough(bw);

regs = regionprops(bw, 'Area', 'BoundingBox', 'Centroid');
figure, imshow(R);
hold on
area = zeros()
for n=1:size(regs, 1)
    x = regs(n).BoundingBox(1);
    y = regs(n).BoundingBox(2);
    w = regs(n).BoundingBox(3);
    h = regs(n).BoundingBox(4);
    %     rectangle('Position',regs(n).BoundingBox,'EdgeColor','g','LineWidth',2); 
    plot(x, y, 'b*');
%         plot(regs(n).BoundingBox(1) + regs(n).BoundingBox(3), regs(n).BoundingBox(2), 'b*');
    plot(x + w, y, 'r*');
    plot(x, y + h, 'g*');
    plot(x + w, y + h, 'w*');
%     display(regs(n).Centroid);
%     display(x+w/2);
%     display(y+h/2);
    plot(x+w/2, y+h/2, 'y*');
    area = [area, regs(n).Area]
%     plot(crd(1), crd(2), 'b*');
end
hold off

display()

% I = h.transformation_gamma_three(img_hsv, 0.85, 1.3);
% [R, G, B] = h.get_rgb_channels(I);
% I = edge(G, 'Canny', [], 0, 1.0);
% I2 = edge(G, 'Canny', [], 0, 2.0);
% I3 = edge(G, 'Canny', [], 0, 3.0);

% I = mat2gray(img);
% [I, x] = edge(I(:,:,1), 'Canny', [], 'both', 5);
% imshow(I);
%[R1, G1, B1] = h.get_rgb_channels(img_yiq);

% [R, G, B] = h.get_rgb_channels(img_ycbcr);
% img = h.histogram_expansion(im2double(B));
% img = B;
% imhist(img);
% imshow(img);
% umbral = graythresh(img);
% umbral = multithresh(img, 2);
% BW = h.thresholding(img, 115, 139);
% BW = imquantize(img, umbral);
% BW = im2bw(img, umbral);
% imshow((BW));
% final=bwareaopen(BW, floor((800/15)*(1200/15))); 
% final=bwareaopen(BW, floor((800/15)*(1200/15))); 
% imshow(BW - final);



% bordes = h.log_filter(B, 5, 0.5);
% B = B + bordes;
% B = h.thresholding(B, 70, 115);
% imwrite(B,'results\um.jpg');
% B = h.median_filter(B, 3);
% imshow(B);
% imwrite(B,'results\fil.jpg');
% [I, x] = edge(B, 'Canny', [], 'both', 1.5);
% imshow(I);

% [R, G2, B] = h.get_rgb_channels(img_hsv);
% figure, imshow(G2);
% figure, imshow(im2uint8(G2) - G)




