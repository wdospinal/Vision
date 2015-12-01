clc;
clear;
close all;
% %   
%% Captura de imagenes

n =3;

for i=1:n
   h = functions_helper();
   s1 = '..\Fotos\Recortadas\';
   s2 = num2str(i);
   s3 = '.jpg';
   s = strcat(s1,s2);
   s = strcat(s,s3);
   img = imread(s);

% %
%% Mejoramiento de Imagenes

%  Muestra todos los canales de la imagen para ver cual es mejor
img_ycbcr = rgb2ycbcr(img);
img_yiq = rgb2ntsc(img);

% Obtenemos el tamaño de la imagen para luego filtrar
[M, N, D] = size(img);
[R , G , B]  = h.get_rgb_channels(img_ycbcr);
[R , G2, B2] = h.get_rgb_channels(img_yiq);
w_img = imcomplement(B) - G;
G2 = im2uint8(h.histogram_expansion(G2));
w_img = w_img - G2;
w_img = h.histogram_expansion(w_img);
w_img = h.median_filter(w_img, 5); 
%
% Segmentacion de Imagenes
umbral = graythresh(w_img);
bw = im2bw(w_img, umbral);

bw2 = bw;
d_se = strel('disk', 3);
bw = imerode(bw, d_se);

bw = bwareaopen(bw, floor(M/15 * N/15));

% Rellenamos 
bw = imfill(bw, 'holes');

% %
%% Extracion de Caracterizticas

% %
%% Creacion de Clases


% %
%% Resultado
s1 = 'results\fil';
s2 = num2str(i);
s3 = '.jpg';
s = strcat(s1,s2);
s = strcat(s,s3);
s
imwrite(bw,s);
end