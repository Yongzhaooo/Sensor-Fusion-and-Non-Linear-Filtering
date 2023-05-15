function Y = genNonLinearMeasurementSequence(X, h, R)
% X [n x N+1] State vector sequence
    % Extract the number of states and measurements
    [n, N] = size(X);
    m = size(R, 1);
    
    % Initialize the measurement sequence
    Y = zeros(m, N-1);%X size is N+1
    
    % Generate the measurement sequence
    for k = 1:N-1
        % Propagate the state through the measurement model
        [hx, Hx] = h(X(:, k+1));
        
        % Draw a random sample from the measurement noise distribution
        v_k = mvnrnd(zeros(m, 1), R)';
        
        % Generate the measurement by adding noise to the predicted measurement
        Y(:, k) = hx + v_k;
    end
end