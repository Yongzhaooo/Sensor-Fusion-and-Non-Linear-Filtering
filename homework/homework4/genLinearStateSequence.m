function X = genLinearStateSequence(x_0, P_0, A, Q, N)
    %GENLINEARSTATESEQUENCE generates an N-long sequence of states using a 
    %    Gaussian prior and a linear Gaussian process model
    %
    %Input:
    %   x_0         [n x 1] Prior mean
    %   P_0         [n x n] Prior covariance
    %   A           [n x n] State transition matrix
    %   Q           [n x n] Process noise covariance
    %   N           [1 x 1] Number of states to generate
    %
    %Output:
    %   X           [n x N+1] State vector sequence
    %

    n = size(x_0,1);
    X = zeros(n,N);

    % init the initial state from the prior distribution x0~N(x_0,P_0)
    X(:,1)=mvnrnd(x_0,P_0);
    % iterate to generate N samples
    for i=1:N
        X(:,i+1) = A*X(:,i)+mvnrnd(zeros(n,1),Q);
    end

end