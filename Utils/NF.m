function N = NF(img)

    [m,n,l] = size(img);
    img_noise = zeros(m,n,l);
    h = fspecial('laplacian');
    for i = 1:l
        img_noise(:,:,i) = imfilter(img(:,:,i),h,'replicate');
    end
    n = reshape(img_noise,[m*n,l]);
    N = him_norm(n);
    
end
