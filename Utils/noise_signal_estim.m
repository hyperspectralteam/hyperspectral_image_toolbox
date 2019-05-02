function [Rn, Rs] = noise_signal_estim(him)
    [m, n, l] = size(him);
    X = reshape(him, [], l);
    kernel = [0 -1 0; -1 4 -1; 0 -1 0];
    noise = zeros([m, n, l]);
    
    for i = 1:l
        noise(:, :, i) = conv2(squeeze(him(:, :, i)), kernel, 'same');
    end
    
    noise = reshape(noise, [], l);
    
    Rn = noise' * noise;
    Rs = X' * X - Rn;
end