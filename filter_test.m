clc;
clear;
close all;

%% Captura de imagenes

n = 100;
base_images = cell(1, n);
for i=100:n
    h = functions_helper();
    s1 = 'D:\Drive\Proyecto Vision artificial\Fotos\Recortadas\(';
    s2 = num2str(i);
    s3 = ').jpg';
    s = strcat(s1, s2);
    s = strcat(s, s3);
    img = imread(s);

%% Mejoramiento de Imagenes

% Muestra todos los canales de la imagen para ver cual es mejor
    img_ycbcr = rgb2ycbcr(img);
    img_yiq = rgb2ntsc(img);

% Obtenemos el tamaño de la imagen para luego filtrar
    [M, N, D] = size(img);
    [R , G , B]  = h.get_rgb_channels(img_ycbcr);
    [R2, G2, B2] = h.get_rgb_channels(img_yiq);
    w_img = imcomplement(B) - G;
    G2 = im2uint8(h.histogram_expansion(G2));
    w_img = w_img - G2;
    w_img = h.histogram_expansion(w_img);
    w_img = h.median_filter(w_img, 5);

% Segmentacion de Imagenes
    umbral = graythresh(w_img);
    bw = im2bw(w_img, umbral);

    bw2 = bw;
    d_se = strel('disk', 3);
    bw = imerode(bw, d_se);
    bw = bwareaopen(bw, floor(M/15 * N/15));

% Rellenamos 
    bw = imfill(bw, 'holes');

% Separamos la imagen en regiones
    regs = regionprops(bw, 'BoundingBox', 'Centroid', 'Orientation');
    imgs = cell(1, size(regs, 1));
    c = 1;
    hold on
    for n=1:size(regs, 1)
        x = regs(n).BoundingBox(1);
        y = regs(n).BoundingBox(2);
        w = regs(n).BoundingBox(3);
        h = regs(n).BoundingBox(4);
        centroid = regs(n).Centroid;
    %     rectangle('Position',regs(n).BoundingBox,'EdgeColor','g','LineWidth',2); 
    %     plot(x, y, 'b*');
    %     plot(x + w, y, 'r*');
    %     plot(x, y + h, 'g*');
    %     plot(x + w, y + h, 'w*');
        
    % Centroide aproximadamente en la mitad.
            e = 10;
            if abs(centroid(1) - (x+w/2)) <= e && abs(centroid(2) - (y+h/2)) <= e
                c_img = bw2(y:floor(y+h), x:floor(x+w));
%                 c_img = imrotate(c_img, -regs(n).Orientation, 'bilinear', 'crop');
                
%                 figure, imshow(c_img);        
                imgs{c} = c_img;
                c = c + 1;
            end
    end
    hold off
    
    imwrite('holi.jpg');
        
    
    for j = 1:size(imgs, 2)
        segs = regionprops(imcomplement(imgs{j}), 'BoundingBox', 'Centroid', 'Orientation');
        
        figure, imshow(imcomplement(imgs{j}));
        hold on
        for h = 1:size(segs, 1)               
            rectangle('Position',segs(h).BoundingBox,'EdgeColor','g','LineWidth',2); 
        end     
        hold off
    end
    

%% Extracion de Características


%% Creacion de Clases


%% Resultados
    s1 = 'results\fil';
    s2 = num2str(i);
    s3 = '.jpg';
    s = strcat(s1,s2);
    s = strcat(s,s3);
    imwrite(bw, s);
end

