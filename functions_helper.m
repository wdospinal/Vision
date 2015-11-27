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
    F.transformation_gamma = @transformation_gamma;
    F.histogram_three = @histogram_three;
    F.histogram_eq_three = @histogram_eq_three;
    F.thresholding = @thresholding;
    F.transformation_gamma_three = @transformation_gamma_three;
    F.histogram_expansion_three = @histogram_expansion_three;
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

function I = histogram_expansion_three(image)
    [R, G, B] = get_rgb_channels(image);
    R = histogram_expansion(R);
    G = histogram_expansion(G);
    B = histogram_expansion(B);
    I = cat(3, R, G, B);
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

function I = thresholding(image, a, b)    
    image(image < a) = 255;
    image(image > b) = 255;
    image(image >= a & image <= b) = 0;
    I = image;
end

function I = transformation_gamma(image, a, gamma)
    I = a*image.^gamma;
end

function histogram_three(image)
    [R, G, B] = get_rgb_channels(image);
    [yR, r] = imhist (R);
    [yG, g] = imhist (G);
    [yB, b] = imhist (B);
    plot(r, yR, 'Red', g, yG, 'Green', b, yB, 'Blue');
end

function I = histogram_eq_three(image)
    [R, G, B] = get_rgb_channels(image);
    R = histeq(R);
    G = histeq(G);
    B = histeq(B);
    I = cat(3, R, G, B);
end

function I = transformation_gamma_three(image, a, gamma)
    [R, G, B] = get_rgb_channels(image);
    R = transformation_gamma(im2double(R), a, gamma);
    G = transformation_gamma(im2double(G), a, gamma);
    B = transformation_gamma(im2double(B), a, gamma);
    I = cat(3, im2uint8(R), im2uint8(G), im2uint8(B));
end
