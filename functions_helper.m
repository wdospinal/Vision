function F = functions_helper
    F.get_rgb_channels = @get_rgb_channels;
end

function [R G B] = get_rgb_channels(image_RGB)
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
            I = imadjust(I)
        case 2
            I = imadjust(I)

end

function I = averange_filter(image ,j , k)
    h = ones(j,k)/(j*k);
    I = filter2(h, image);
end

function I = gaussian_filter(image, hsize,sigma)
    h =fspecial ('gaussian', hsize, sigma)
    I = imfilter(image, h, 'replicate');
end


function I = log_filter(image, hsize,sigma)
    h =fspecial ('log', hsize, sigma);
    I = imfilter(image, h, 'symmetric');
end

function I = median_filter(image, a)
    G = medfilt2(I, [a,a],'symmetric');
end

function I = max_filter(image, a)
    fun = @(x) max(x(:));
    G = nlfilter(I,[a,a],fun);
end

function I = min_filter(image ,a)
    fun = @(x) min(x(:));
    G = nlfilter(I,[a,a],fun);
end
