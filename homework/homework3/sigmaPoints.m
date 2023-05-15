function [SP, W] = sigmaPoints(x, P, type)
    n = numel(x); % Dimensionality of state vector
    
    switch type
        case 'UKF'
            % UKF sigma points and weights
W0 = 1 - n / 3;
gamma = sqrt(n / (1 - W0));
P_sqrt = sqrtm(P);
% Compute sigma points
SP = [x, x(:, ones(1, n)) + gamma * P_sqrt, x(:, ones(1, n)) - gamma * P_sqrt];
%x(:,ones(1,n)) do the same with repmat(x,1,n)

% Compute weights
W = [W0, (1-W0)/(2*n)* ones(1, 2 * n)];
            
        case 'CKF'
            % CKF sigma points and weights
            alpha = sqrt(n); % CKF parameter
            
            % Compute matrix square root of P
            P_sqrt = sqrtm(P);
            
            % Compute sigma points
            SP = [x(:, ones(1, n)) + alpha * P_sqrt, x(:, ones(1, n)) - alpha * P_sqrt];
            
            % Compute weights
            W = 1 / (2 * n) * ones(1, 2 * n);
            
        otherwise
            error('Incorrect type of sigma point');
    end
end
