function idx = CCE(X, k, sigma)

%   Connection Center Evolution      
%   X is data, n*d matrix
%   n is number of samples
%   d is number of original dimension
%
%   Then,
%   k is The exponential of Similarity matrix
%   
%   So;
%   the output idx is the label of each samlpe
%   idx is a n*1 matrix

    Soriginal= exp(-(squareform(pdist(X) / sigma)) .^ 2);
    S = Soriginal ^ k;

    [n, ~] = size(X);
    centeridx = [];
    for i = 1:n
        [M, pos] = max(S(:, i));
        if S(i, i) == M
            centeridx = [centeridx, pos];
        end
    end
    
    centernum = length(centeridx);
    con = zeros(n, centernum);
    centercon = zeros(1, centernum);
    idx = zeros(n, 1);
    rcon = con;
    
    for i =1:centernum
        centercon(i) = S(centeridx(i), centeridx(i));
    end
    
    for i = 1:n
        for j = 1:centernum
            con(i, j) = exp(-(norm(X(i,:)- X(centeridx(j),:)).^2) / (sigma^2));
        end
        rcon(i, :) = con(i, :) ./ centercon;
        [~, cla] = max(rcon(i,:));
        idx(i) = cla;
    end
    
end

