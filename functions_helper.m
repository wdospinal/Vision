function F = functions_helper
    F.get_rgb_channels = @get_rgb_channels;
    F.linear_transformation = @linear_transformation;
    F.histogram_expansion = @histogram_expansion;
    F.average_filter = @average_filter;
    F.gaussian_filter = @gaussian_filter;
    F.log_filter = @log_filter;
    F.median_filter = @median_filter;
    F.max_filter = @max_filter;
    F.min_filter = @min_filter;
    F.get_features = @get_features;
    F.create_d = @create_d
end

function [R, G, B] = get_rgb_channels(image_RGB)
    R = image_RGB(:, :, 1);
    G = image_RGB(:, :, 2);
    B = image_RGB(:, :, 3);
end

function I = linear_transformation(image, a, b)
    I = (image * a) + b;
end

function I = histogram_expansion(varargin)
    switch nargin
        case 1
            image = varargin{1};
            res = stretchlim(image);
            low = res(1);
            high = res(2);
        case 3
            low = varargin{2};
            high = varargin{3};
        otherwise
            error('Unexpected input');
    end

    I = imadjust(image, [low high], []);
end

function I = average_filter(image, j, k)
    h = ones(j, k)/(j*k);
    tmp = filter2(h, image);
    I = mat2gray(tmp);
end

function I = gaussian_filter(image, hsize, sigma)
    h = fspecial ('gaussian', hsize, sigma);
    I = imfilter(image, h, 'replicate');
end


function I = log_filter(image, hsize, sigma)
    h = fspecial ('log', [hsize hsize], sigma);
    I = imfilter(image, h, 'symmetric');
end

function I = median_filter(image, a)
    I = medfilt2(image, [a, a]);
end

function I = max_filter(image, a)
    fun = @(x) max(x(:));
    I = nlfilter(image,[a,a],fun);
end

function I = min_filter(image, a)
    fun = @(x) min(x(:));
    I = nlfilter(image, [a,a], fun);
end

function I = adjust_filter(image, a,b)
    I (image < a) = 0;
    I (image > b) = 255;
end


function [X, Xn] = get_features(I)
    J = imdilate(I,ones(3,3));
    [L, n] = bwlabel(J,4);

    b(1).name = 'basicgeo'; b(1).options.show=1;
    b(2).name = 'hugeo'; b(2).options.show=1;
    b(3).name = 'flusser'; b(3).options.show=1;
    
    op.b = b;
    [X,Xn] = Bfx_geo(L, op);
end

function view_features(d, k, X, Xn)
    for i = k
    figure
    Bio_plotfeatures(X(:,i),d, Xn(i,:))
    end
end

function d = create_d(clases)
    n = size(clases, 1);
    
    d = [];
    for i=1:n
        nC = clases(i, 1);
        
        x = ones(nC, 1) * i;
        d = vertcat(d, x);       
    end
end
