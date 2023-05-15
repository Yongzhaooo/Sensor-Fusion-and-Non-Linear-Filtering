function [xs, Ps, xf, Pf, xp, Pp] = ...
    nonLinRTSsmoother(Y, x_0, P_0, f, T, Q, S, h, R, sigmaPoints, type)
% NONLINRTSSMOOTHER Filters measurement sequence Y using a 
% non-linear Kalman filter. 
%
%Input:
%   Y           [m x N] Measurement sequence for times 1,...,N
%   x_0         [n x 1] Prior mean for time 0
%   P_0         [n x n] Prior covariance
%   f                   Motion model function handle
%   T                   Sampling time
%   Q           [n x n] Process noise covariance
%   S           [n x N] Sensor position vector sequence
%   h                   Measurement model function handle
%   R           [n x n] Measurement noise covariance
%   sigmaPoints Handle to function that generates sigma points.
%   type        String that specifies type of non-linear filter/smoother
%
%Output:
%   xf          [n x N]     Filtered estimates for times 1,...,N
%   Pf          [n x n x N] Filter error convariance
%   xp          [n x N]     Predicted estimates for times 1,...,N
%   Pp          [n x n x N] Filter error convariance
%   xs          [n x N]     Smoothed estimates for times 1,...,N
%   Ps          [n x n x N] Smoothing error convariance

    N = size(Y,2);
    n = size(x_0,1);

    xf = zeros(n,N);
    Pf=zeros(n,n,N);
    xp=zeros(n,N);
    Pp=zeros(n,n,N);
    xs=zeros(n,N);
    Ps=zeros(n,n,N);

    % Forward Kalman filter
    for k = 1:N
        % Prediction
        [xPred, PPred]  = nonLinKFprediction(x_0, P_0, f, T, Q, sigmaPoints, type);
        xp(:,k) = xPred;
        Pp(:,:,k) = PPred;
        
        % Update
%         disp(size(Y)); % Display the size of Y
% disp(size(S)); % Display the size of S

%         [xf(:, k), Pf(:, :, k)] = nonLinKFupdate(xPred, PPred, Y(:,k), S(:,k), h, R, sigmaPoints, type);
[xf(:, k), Pf(:, :, k)] = nonLinKFupdate(xPred, PPred, Y(:,k), S, h, R, sigmaPoints, type);
        % Update x_0 and P_0 for the next iteration
        x_0 = xf(:, k);
        P_0 = Pf(:, :, k);
    end
    
    % RTS backward smoother
    xs = zeros(size(xf));
    Ps = zeros(size(Pf));

    % Set the last smoothed estimates to the filtered estimates
    xs(:,N) = xf(:,N); 
    Ps(:,:,N) = Pf(:,:,N);

    for k = (N-1):-1:1
        [xs(:,k) Ps(:,:,k)] = nonLinRTSSupdate(xs(:,k+1), Ps(:,:,k+1), xf(:,k), Pf(:,:,k), xp(:,k+1), Pp(:,:,k+1), f, T, sigmaPoints, type);    
    end

end