function [xf, Pf, xp, Pp] = nonLinearKalmanFilter(Y, x_0, P_0, f, Q, h, R, type, S, sigmaPoints,T)

% Initialization
N = size(Y, 2);
n = numel(x_0);
xf = zeros(n, N);
Pf = zeros(n, n, N);
xp = zeros(n, N);
Pp = zeros(n, n, N);

% Initial state prior
[xp(:, 1), Pp(:, :, 1)] = nonLinKFprediction(x_0, P_0, f, T, Q, sigmaPoints,type);
[xf(:, 1), Pf(:, :, 1)] = nonLinKFupdate(xp(:, 1), Pp(:, :, 1), Y(:, 1), S, h, R, sigmaPoints,type);

% Loop
for k = 2:N
    [xp(:, k), Pp(:, :, k)] = nonLinKFprediction(xf(:, k-1), Pf(:, :, k-1), f, T, Q, sigmaPoints, type);
    [xf(:, k), Pf(:, :, k)] = nonLinKFupdate(xp(:, k), Pp(:, :, k), Y(:, k), S, h, R, sigmaPoints, type);
end

end