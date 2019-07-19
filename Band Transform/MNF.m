function y = MNF(h)

%   MNF is a classic dimensionality reduction algorithm.
%   h is the hyperspectral image data struct.
%
%   Then, 
%   img should be a m*n*l martix,

    img = h.him;
    [m,n,l] = size(img);
    X = reshape(img,[m*n,l]);
    N = NF(img);

    sigma_X = cov(X);
    sigma_N = cov(N);
    [v,d] = eig(sigma_N);
    f = v*(d^(-1/2));
    sigma_w = f'*sigma_X*f;

    [U,~,~] = svd(sigma_w);
    t = U(:,1:end);

    y = X*t;

end





