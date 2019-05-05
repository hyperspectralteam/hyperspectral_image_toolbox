function [him_, snr] = MNF(him)
    [m, n, l] = size(him);
    X = reshape(him, [], l);
    [Rn, Rs] = noise_signal_estim(him);
    Rn_ = pinv(sqrtm(Rn));
    [V, D] = eig(Rn_ * Rs * Rn_);
    Y = X * V;
    
    him_ = reshape(Y, [m, n, l]);
    snr = diag(D);
end