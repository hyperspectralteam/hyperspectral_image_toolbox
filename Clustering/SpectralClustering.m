function idx = SpectralClustering(X, k, sigma)

%   Spectral Clustering
%   X is data, n*d matrix
%   n is number of samples
%   d is number of original dimension
%   
%   Then,
%   k is the number of clusters
%
%   So,
%   the output idx is the label of each samlpe
%   idx is a n*1 matrix

    num = length(X);
    W = exp(-squareform((pdist(X) / sigma).^2)) - eye(num);
    D = diag(sum(W));
    L = D - W;

    [S, ~, ~] = svd(L);
    idx = kmeans(S(:, end-k:end-1), k);

end
