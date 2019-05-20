function y = SpectralClustering(X, k)

%   Spectral Clustering
%   X is data, n*d matrix
%   n is number of samples
%   d is number of original dimension
%   
%   Then,
%   k is the number of clusters
%
%   So,
%   the output y is the label of each samlpe
%   y is a n*1 matrix

    [n,~] = size(X);
    W = zeros(n);
    sigma = 0.2;
    for i = 1:n
        for j = 1:n
            W(i, j) = exp(-norm(X(i, :)-X(j, :))^2 / (sigma^2));
        end
    end

    D = zeros(n);
    for i = 1:n
        D(i, i) = sum(W(i, :));
    end
    L = D - W;

    [S, ~, ~] = svd(L);
    S_sorted = fliplr(S);
    v = S_sorted(:, 2:k);
    y = kmeans(v, k);

end








