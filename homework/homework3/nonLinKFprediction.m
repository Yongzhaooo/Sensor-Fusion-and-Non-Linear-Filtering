function [x, P] = nonLinKFprediction(x, P, f, Q, type)
    switch type
        case 'EKF'
            % Extended Kalman Filter (EKF)
            [fx, Fx] = f(x);
            x = fx;
            P = Fx * P * Fx' + Q;
            
        case 'UKF'
            % Unscented Kalman Filter (UKF)
            [SP, W] = sigmaPoints(x, P, 'UKF');
            n = size(x, 1);
            
            % Propagate sigma points through motion model
            FX = zeros(n, size(SP, 2));
            for i = 1:size(SP, 2)
                [fx, ~] = f(SP(:, i));
                FX(:, i) = fx;
            end
            
            % Approximate mean and covariance
            x = sum(W .* FX, 2);
            P = (FX - x(:, ones(1, size(FX, 2)))) * diag(W) * (FX - x(:, ones(1, size(FX, 2))))' + Q;
            
            % Make sure the covariance matrix is semi-definite
            if min(eig(P))<=0
                [v,e] = eig(P, 'vector');
                e(e<0) = 1e-4;
                P = v*diag(e)/v;
            end
            
        case 'CKF'
            % Cubature Kalman Filter (CKF)
            [SP, W] = sigmaPoints(x, P, 'CKF');
            n = size(x, 1);
            
            % Propagate sigma points through motion model
            FX = zeros(n, size(SP, 2));
            for i = 1:size(SP, 2)
                [fx, ~] = f(SP(:, i));
                FX(:, i) = fx;
            end
            
            % Approximate mean and covariance
            x = sum(W .* FX, 2);
            P = (FX - x(:, ones(1, size(FX, 2)))) * diag(W) * (FX - x(:, ones(1, size(FX, 2))))' + Q;
            
            % Make sure the covariance matrix is semi-definite
            if min(eig(P))<=0
                [v,e] = eig(P, 'vector');
                e(e<0) = 1e-4;
                P = v*diag(e)/v;
            end
        otherwise
            error('Incorrect type of non-linear Kalman filter');
    end
end