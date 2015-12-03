fh = functions_helper();

% Adquisici�n de imagen de entrenamiento
I = not (imread( 'img/learning_chars.bmp' ) ) ;
[X, Xn] = fh.get_features(I);

chars = ['a'; 'd'; 'e'; 'i'; 'n'; 'l'; 'r'; 'v'; 'A'; 'B'; 'C'; 'D'; 'E'; 'F';
            '0'; '1'; '2'; '3'; '4'; '7'; '8'];

% Vector que indica cantidad de cada char
clases = [44; 3; 35; 2; 4; 47; 24; 3; 7; 6; 33; 5; 6; 2;
            4; 3; 19; 31; 3; 10; 11];

% Creaci�n matriz columna con el clasificador ideal de la imagen de
% entrenamiento
d = fh.create_d(clases);

save('data/X-Xn-d_training.mat', 'X', 'Xn', 'd');

% % ***** Supervisi�n
[d,D] = Bio_labelregion(I,L,21);
% save('data/L, X, Xn, d - learning.mat', 'L', 'X', 'Xn', 'd');
load('data/L, X, Xn, d - learning.mat');

% AN�LISIS VISUAL DE LAS CARACTER�STICAS
k= [1:29];
fh.view_features(d, k, X, Xn);

figure
k=[2 9 26];
Bio_plotfeatures(X(:,k),d, Xn(k,:));

k= [2 9 26];
% % Dise�o de clasificador (con k caracter�sticas)
opcion.p = [];    %Igual propabilidad para todas las clases
op = Bcl_lda(X(:,k), d, opcion); % LDA � training

% Test con imagen de entrenamiento

ds = Bcl_lda(X(:,k), op); % LDA - testing
p = Bev_performance(d,ds) % performance on test data

% _____________________
% Test con otra imagen
% ---------------------

Itest = not (imread( 'img/numbersTest.bmp' ) ) ;
[Ltest, Xtest, Xn] = fh.get_features(Itest);

% % ***** Supervisi�n
[dtest,Dtest] = Bio_labelregion(Itest,Ltest,2);
% save('data/L, X, Xn, d - testing.mat', 'Ltest', 'Xtest', 'Xn', 'dtest');
load('data/L, X, Xn, d - testing.mat');

k = [9];
ds = Bcl_lda(Xtest(:,k), op); % LDA - testing
p = Bev_performance(dtest,ds) % performance on test data