clc;
clear;
close all;

%% Captura de imagenes
handler = functions_helper();
s = 'jpg';
sfiles = [dir(['..\Fotos\Recortadas\*.' lower(s)]); dir(['..\Fotos\Recortadas\*.' upper(s)])];
n = size(sfiles,1);
base_images = cell(1, n);
for i=1:n
    ruta = '..\Fotos\Recortadas\';
    archivo = sfiles(i).name;
    s = strcat(ruta, archivo);
    img = imread(s);

%% Mejoramiento de Imagenes

%%  Muestra todos los canales de la imagen para ver cual es mejor
img_yiq = rgb2ntsc(img);
img_hsv = rgb2hsv(img);
img_xyz = rgb2xyz(img);
img_lab = rgb2lab(img);
img_ycbcr = rgb2ycbcr(img);


img_array = {img, img_yiq, img_hsv, img_xyz, img_lab, img_ycbcr};
name_array = {'-RGB', '-YIQ', '-HSV', '-XYZ', '-LAB', '-YCBCR'};
name_color = {'Red', 'Green','Blue', 'Yellow','In-phase','Quadrature', 'H', 'S', 'V', 'X', 'Y', 'Z', 'L', 'A' ,'B', 'Y', 'CB', 'CR'};
size = length(img_array);
figure
hold on
n=1;
for i = 1:size
   [R1, G1, B1] = handler.get_rgb_channels(img_array{i});
   subplot (6, 3, n,'align'); imshow(R1); title(strcat(name_color(n), name_array(i)))
   n = n + 1;
   subplot (6, 3, n,'align'); imshow(G1); title(strcat(name_color(n) , name_array(i)))
   n = n + 1;
   subplot (6, 3, n,'align'); imshow(B1); title(strcat(name_color(n), name_array(i)))
   n = n + 1;
   if i < size
%        figure
   end
end
hold off 
    % Muestra todos los canales de la imagen para ver cual es mejor

%     % Obtenemos el tamanio de la imagen para luego filtrar
%     [M, N, D] = size(img);
%     [R , G , B]  = h.get_rgb_channels(img_ycbcr);
%     [R2, G2, B2] = h.get_rgb_channels(img_yiq);
%     w_img = imcomplement(B) - G;
%     G2 = im2uint8(h.histogram_expansion(G2));
%     w_img = w_img - G2;
%     w_img = h.histogram_expansion(w_img);
%     w_img = h.median_filter(w_img, 5);
% 
% %% Segmentacion de Imagenes
%     umbral = graythresh(w_img);
%     bw = im2bw(w_img, umbral);
% 
%     bw2 = bw;
%     d_se = strel('disk', 3);
%     bw = imerode(bw, d_se);
%     bw = bwareaopen(bw, floor(M/15 * N/15));  
% 
%     % Rellenamos 
%     bw = imfill(bw, 'holes');
% 
%     % Separamos la imagen en regiones
%     regs = regionprops(bw, 'BoundingBox', 'Centroid', 'Orientation');
%     imgs = cell(1, size(regs, 1));
%     c = 1;
%     hold on
%     for n=1:size(regs, 1)
%         x = regs(n).BoundingBox(1);
%         y = regs(n).BoundingBox(2);
%         w = regs(n).BoundingBox(3);
%         h = regs(n).BoundingBox(4);
%         centroid = regs(n).Centroid;
%     %     rectangle('Position',regs(n).BoundingBox,'EdgeColor','g','LineWidth',2); 
%     %     plot(x, y, 'b*');
%     %     plot(x + w, y, 'r*');
%     %     plot(x, y + h, 'g*');
%     %     plot(x + w, y + h, 'w*');
%         
%     % Centroide aproximadamente en la mitad.
%             e = 10;
%             if abs(centroid(1) - (x+w/2)) <= e && abs(centroid(2) - (y+h/2)) <= e
%                 c_img = bw2(y:floor(y+h), x:floor(x+w));
%     %           c_img = imrotate(c_img, -regs(n).Orientation, 'bilinear', 'crop');                
%     %           figure, imshow(c_img); 
%                 imgs{c} = imcomplement(c_img);
%                             
%                 [L, num] = bwlabel(imgs{c}, 4);
%                 
%                 [NA, BA]= size(imgs{c});
%                        
%                 % Recorre las esquinas y borra lineas de las placas
%                 imgs{c}(L == L(1, 1)) = 0;
%                 imgs{c}(L == L(NA, 1)) = 0;
%                 imgs{c}(L == L(1, BA)) = 0;
%                 imgs{c}(L == L(NA, BA)) = 0;      
%                 
%                 imgs{c} = bwareaopen(imgs{c}, floor(NA*0.05 * BA*0.05));
% 
%                 % Recorre Esquinas, aumentado por columnas
%                 for m=1:BA
%                   if(L(1, m) ~= 0 )
%                     imgs{c}(L == L(1, m)) = 0;
%                   end
%                   if(L(NA, m) ~= 0 )
%                   	imgs{c}(L == L(NA, m)) = 0;
%                   end
%                 end
%                 % Recorre Esquinas, aumentado por filas
%                 for m=1:NA
%                   if(L(m, 1) ~= 0)
%                     imgs{c}(L == L(m, 1)) = 0;                      
%                   end
%                   if(L(m, BA) ~= 0)
%                     imgs{c}(L == L(m, BA)) = 0;
%                   end
%                 end
%                
%                 
%                 %No guarda las que tienen una sola region que son las flechas
%                 [L, num] = bwlabel(imgs{c}, 4);
%                 if(num > 1)
%                     % Guarda las imagenes 
%                     s1 = 'results\fil';
%                     s2 = num2str(i);
%                     s3 = '_';
%                     s4 = num2str(c);
%                     s5 = '.jpg';
%                     s = strcat(s1,s2);
%                     s = strcat(s, s3);
%                     s = strcat(s, s4);
%                     s = strcat(s, s5);      
%                     imwrite(imgs{c}, s);                    
%                     c = c + 1;
%                 end   
%             end
%     end
%    
%     % separar las imagenes en regiones de las letras
%     hold off        
%     for j = 1:size(imgs, 2)
%         % Separamos la imagen en regiones
%         segs = regionprops(imgs{j}, 'BoundingBox', 'Centroid', 'Orientation');
%         % figure, imshow(imgs{j});
%         hold on
%         for h = 1:size(segs, 1)               
%                 rectangle('Position',segs(h).BoundingBox,'EdgeColor','g','LineWidth',2); 
%         end     
%         hold off
%     end
%     
% 
% %% Extracion de Caracteristicas
% 
% 
% %% Creacion de Clases
% 
% 
% %% Resultados
% 
% %     for n=1:size(imgs,2)
% %         fid=fopen('archivo.txt','w'); 
% %         fprintf(fid,'%s \n',s);         
% %     end    
end
% % fclose(fid);
