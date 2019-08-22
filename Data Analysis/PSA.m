function Y = PSA(X, c)
%PSA Principal Skewness Analysis
%   X is a N * l matrix
%   c is the number of the components
%   Y is a N * c matrix

    [n, l] = size(X);
    X = X - mean(X, 1);
    R = X' * X / n;
    X = X * sqrtm(pinv(R));
    X_bak = X;
    U = zeros([l, c]);

    S = zeros([l, l, l]);
    for i = 1:n
        r2 = tensor_mul(X(i, :)', X(i, :), 2, 0);
        S = S + tensor_mul(r2, X(i, :)', 3, 0);
    end
    S = S / n;
    
    tol = 1e-5;
    for k = 1:c    
        u = randn([l, 1]);
        u = u ./ norm(u);
        u_ = u;
        for t = 1:500
            S1 = tensor_mul(S, u, 3, 1);
            u = tensor_mul(S1, u, 2, 1);
            u = u ./ norm(u);

            if norm(u - u_) < tol
                break;
            end
            u_ = u;
        end
        P = (eye(l) - u * u');
        S = tensor_mul(S, P, 1, 2);
        S = tensor_mul(S, P, 2, 2);
        S = tensor_mul(S, P, 3, 2);
        U(:, k) = u;
    end

    Y = X_bak * U;
end