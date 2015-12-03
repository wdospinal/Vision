clc;
clear;
close all;

%% Captura de imagenes

n = 3;
base_images = cell(1, n);
for i=1:n
    h = functions_helper();
    s1 = 'C:\Users\user\Desktop\Filtros\Recortadas\(';
    s2 = num2str(i);
    s3 = ').jpg';
    s = strcat(s1, s2);
    sfinal = strcat(s, s3);
    img = imread(sfinal);

%% Mejoramiento de Imagenes

% Muestra todos los canales de la imagen para ver cual es mejor
    img_ycbcr = rgb2ycbcr(img);
    img_yiq = rgb2ntsc(img);

% Obtenemos el tama?o de la imagen para luego filtrar
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
%     hold on
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
%               c_img = imrotate(c_img, -regs(n).Orientation, 'bilinear', 'crop');                
               figure, imshow(c_img); 
                imgs{c} = imcomplement(c_img);
                c_img = imcomplement(c_img); %comentar
                s1 = 'results\fil';
                s2 = num2str(i);
                s3 = '_';
                s4 = num2str(c);
                s5 = '.jpg';
                s = strcat(s1,s2);
                s = strcat(s, s3);
                s = strcat(s, s4);
                s = strcat(s, s5);                
                            
                [L, num] = bwlabel(imgs{c}, 4);
                
                [NA, BA]= size(imgs{c});

                % Recorre lasesquinas y borra lineas de las placas
                imgs{c}(L == L(1, 1)) = 0;
                imgs{c}(L == L(NA, 1)) = 0;
                imgs{c}(L == L(1, BA)) = 0;
                imgs{c}(L == L(NA, BA)) = 0;      
                
                imgs{c} = bwareaopen(imgs{c}, floor(NA*0.05 * BA*0.05));

                % Recorre Esquinas, aumentado por columnas
                for m=1:BA
                  if(L(1, m) ~= 0 )
                    imgs{c}(L == L(1, m)) = 0;
                  end
                  if(L(NA, m) ~= 0 )
                  	imgs{c}(L == L(NA, m)) = 0;
                  end
                end
                % Recorre Esquinas, aumentado por filas
                for m=1:NA
                  if(L(m, 1) ~= 0)
                    imgs{c}(L == L(m, 1)) = 0;                      
                  end
                  if(L(m, BA) ~= 0)
                    imgs{c}(L == L(m, BA)) = 0;
                  end
                end
                
                [L, num] = bwlabel(imgs{c}, 4);
                if (num > 1)
                    imwrite(imgs{c}, s);
                    c = c + 1;
                end
            end
    end
%     hold off        
    
    for j = 1:size(imgs, 2)
        segs = regionprops(imgs{j}, 'BoundingBox', 'Centroid', 'Orientation');                 figure, imshow(imgs{j});
        hold on
        for h = 1:size(segs, 1)               
            rectangle('Position',segs(h).BoundingBox,'EdgeColor','g','LineWidth',2); 
        end     
        hold off
    end
    

%% Extracion de Caracter?sticas


%% Creacion de Clases


%% Resultados

%     for n=0:size(imgs,2) 
%         s1 = 'results\fil';
%         s2 = num2str(i);
%         s3 = '.jpg';
%         s = strcat(s1,s2);
%         s = strcat(s,s3);
%         imwrite(imgs{n}, s);
%     end

end