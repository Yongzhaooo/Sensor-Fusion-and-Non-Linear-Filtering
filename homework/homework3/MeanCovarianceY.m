function [y_hat, S] = MeanCovarianceY(x, P, y, h, R, type)
    switch type
        case 'EKF'
            % Extended Kalman Filter (EKF)
            [y_hat, Hx] = h(x);
            S = Hx * P * Hx' + R;
            
        case 'UKF'
            % Unscented Kalman Filter (UKF)
            [SP, W] = sigmaPoints(x, P, 'UKF');
            n = size(x, 1);
            m = size(y, 1);
            
            % Propagate sigma points through measurement model
            HY = zeros(m, size(SP, 2));
            for i = 1:size(SP, 2)
                [hy, ~] = h(SP(:, i));
                HY(:, i) = hy;
            end
            
            % Approximate mean and covariance of predicted measurements
            y_hat = sum(W .* HY, 2);
            S = (HY - y_hat(:, ones(1, size(HY, 2)))) * diag(W) * (HY - y_hat(:, ones(1, size(HY, 2))))' + R;
            
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
            m = size(y, 1);
            
            % Propagate sigma points through measurement model
            HY = zeros(m, size(SP, 2));
            for i = 1:size(SP, 2)
                [hy, ~] = h(SP(:, i));
                HY(:, i) = hy;
            end
            
            % Approximate mean and covariance of predicted measurements
            y_hat = sum(W .* HY, 2);
            S = (HY - y_hat(:, ones(1, size(HY, 2)))) * diag(W) * (HY - y_hat(:, ones(1, size(HY, 2))))' + R;
            
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