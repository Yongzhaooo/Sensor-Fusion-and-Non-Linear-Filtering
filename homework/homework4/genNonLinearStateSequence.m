function X = genNonLinearStateSequence(x_0, P_0, f, Q, N)
    % Extract the size of the state vector
    n = numel(x_0);
    
    % Initialize the state vector sequence
    X = zeros(n, N+1);
    
    % Set the initial state
    X(:, 1) = x_0;
    
    % Generate the state vector sequence
    for k = 1:N
        % Draw a random sample from the process noise distribution
        w_k = mvnrnd(zeros(size(Q, 2), 1), Q)';
        
        % Propagate the state using the motion model
        [fx, ~] = f(X(:, k));
        X(:, k+1) = fx + w_k;
    end
end