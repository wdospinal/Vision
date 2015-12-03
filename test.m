clear;
close all;

%% Captura de imagenes
files = dir('results\*.jpg');
imgs = cell(1, size(files, 1));
for i = 1:size(files, 1)
    im = imread(strcat('results\', files(i).name));
    imgs{i} = im2bw(im, graythresh(im));
end

letters = ['a', 'd', 'e', 'i', 'n', 'l', 'r', 'v', 'A', 'B', 'C', 'D', 'E', 'F', '0', '1', '2', '3', '4', '7', '8'];

% Matriz de caracteristicas y matriz columna de las etiquietas
load('X-Xn-d_training.mat');

%% Selección de características, Extraemos características

% Algoritmo KNN con 1 vecino
op.m = 3;                     % 10 features will be selected
op.show = 1;                   % display results
op.b.name = 'knn';          % SFS with KNN
op.b.options.k = 1;
s = Bfs_sfs(X, d, op);

% ex-search
% op.m = 3;                     % n features will be selected
% op.show = 1;                   % display results
% op.b.name = 'fisher';          % SFS with KNN
% s = Bfs_exsearch(X, d, op); 

% Using LSEF
% o.m = 3;
% o.show = 1;
% [s, Y, th] = Bfs_lsef(X, d, o);

% Using BB
% o.show = 1;
% o.b.name = 'fisher';
% o.m = 3;
% s = Bfs_bb(X, d, o);

% fosmod
% o.m = 3;
% o.show = 1;
% s = Bfs_fosmod(X,d, o);

% Rank features
% o.m = 3;
% o.criterion = 'wilcoxon';
% s = Bfs_rank(X, d, o);

% SFS CORR
% [R, s] = Bfs_sfscorr(X, d, 3);

% Random best
% o.m = 3;
% o.show = 1;
% o.b.name = 'fisher';
% o.M = 1000;
% s = Bfs_random(X, d, o);


%% CLASIFICADORES

% Entrenamiento
% Algoritmo KNN con 1 vecino
o.k = 1;
opt = Bcl_knn(X(:, s), d, o);

% Usando LDA
% y = zeros(1, length(unique(d)));
% for i = 1:length(unique(d))
%    y(i) = sum(d == i);
% end
% o.p = y/length(d);
% opt = Bcl_lda(X(:, s), d, o);

% Usando Mahalanobis
% opt = Bcl_maha(X(:, s), d, []);

% Usando QDA
% o.p = [];
% opt = Bcl_qda(X(:, s), d, o);

% Usando PNN
% opt = Bcl_pnn(X(:, s), d, []);

% Usando NN
% o.method = 1;
% o.iter = 10000;
% opt = Bcl_nnglm(X(:, s), d, o);

% Usando Adaboost
% options.iter = 1000;
% opt = Bcl_adaboost(X(:, s), d, options);

% SVM
% o.kernel = 1;
% opt = Bcl_svmplus(X(:, s), d, o);

b(1).name = 'basicgeo';  b(1).options.show=1;
b(2).name = 'hugeo';  b(2).options.show=1;
b(3).name = 'flusser';  b(3).options.show=1;
oc.b = b;

results = cell(1, size(imgs, 2));

%% Pruebas
for i = 1:size(imgs, 2)
    res = '';
    [L2, n2] = bwlabel(imgs{i}, 8);
    [X2, X2n] = Bfx_geo(L2, oc);
     ds = Bcl_knn(X2(:, s), opt); % Testing
%     ds = Bcl_maha(X2(:, s), opt);
%     ds = Bcl_qda(X2(:, s), opt);
%     ds = Bcl_pnn(X2(:, s), opt);
%     ds = Bcl_nnglm(X2(:, s), opt);
%     ds = Bcl_adaboost(X2(:, s), opt);
%     ds = Bcl_svmplus(X2(:, s), opt);
%     ds = Bcl_lda(X2(:, s), opt);

    for j = 1:size(ds, 1)
        res = strcat(res, letters(ds(j)));
    end
    results{i} = res;
end

for i = 1:size(imgs, 2)
   figure, imshow(imgs{i}); title(results{i});
end
% k = [28, 26, 14];
% for i = 30:41
%     Bio_plotfeatures(XTest(:, i), [1, 2, 3, 3, 4], XTn(i, :));
%     figure;
% end

% disp(p_vector);
% disp('ds ->');
% for i = 1:28
%     disp(ds_vec{i});
% end

% y = zeros(1, 12);
% for i = 1:size(d, 1)
%    y(d(i)) = sum(d == d(i));
% end





