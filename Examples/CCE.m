%% 
% Open it as live script!!!
% 
% Load data.

clear;
clc;
close all;

X = csvread('twomoon-2d-50s.test.csv');
X = X(1:20:end, :);
plot(X(:, 2), X(:, 3), 'o');
%%
sigma = 0.2;
labelnum = [];
kchange = [];
for k = 10:5:20
    kchange = [kchange; k];
    idx = CCE(X, k, sigma);
    labelnum = [labelnum; length(unique(idx))];
    figure;
    scatter(X(:, 2), X(:, 3), [], idx, 'Marker', 'o');
end

plot(kchange, labelnum);
grid on;
xlabel('exponential(k)');
ylabel('Number of clusters');