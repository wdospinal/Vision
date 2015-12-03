function F = functions_helper
    F.testing_features = @testing_features;
end

function [p, ds] = testing_features(img, db, n_classes, k, ideal)
    img = im2bw(img, graythresh(img));
    load(db);

    % Calculate probability
    options.p = [0.2034 0.0169 0.1525 0.0169 0.1949 0.1271 0.0169 0.0254 0.0508 0.1441 0.0169 0.0339];
    op = Bcl_lda(X(:, k), d, options);
%         Testing p = 1
%         ds = Bcl_lda(X(:, k), op);
%         p = Bev_performance(ds, d);

%         Bio_plotfeatures(X(:,k), d, Xn(k,:));

    b(1).name = 'basicgeo';  b(1).options.show=1;
    b(2).name = 'hugeo';  b(2).options.show=1;
    b(3).name = 'flusser';  b(3).options.show=1;
    oc.b = b;

    [L2, n2] = bwlabel(img, 8);
    [XTest, XTn] = Bfx_geo(L2, oc);

    ds = Bcl_lda(XTest(:, k), op); % Testing
    p = Bev_performance(ds, ideal);
end
