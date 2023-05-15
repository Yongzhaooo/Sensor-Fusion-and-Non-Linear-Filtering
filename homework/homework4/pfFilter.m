function [xfp, Pfp, Xp, Wp] = pfFilter(x_0, P_0, Y, proc_f, proc_Q, meas_h, meas_R, ...
                             N, bResample, plotFunc)
%PFFILTER Filters measurements Y using the SIS or SIR algorithms and a
% state-space model.
%
% Input:
%   x_0         [n x 1] Prior mean
%   P_0         [n x n] Prior covariance
%   Y           [m x K] Measurement sequence to be filtered
%   proc_f      Handle for process function f(x_k-1)
%   proc_Q      [n x n] process noise covariance
%   meas_h      Handle for measurement model function h(x_k)
%   meas_R      [m x m] measurement noise covariance
%   N           Number of particles
%   bResample   boolean false - no resampling, true - resampling
%   plotFunc    Handle for plot function that is called when a filter
%               recursion has finished.
% Output:
%   xfp         [n x K] Posterior means of particle filter
%   Pfp         [n x n x K] Posterior error covariances of particle filter
%   Xp          [n x N x K] Non-resampled Particles for posterior state distribution in times 1:K
%   Wp          [N x K] Non-resampled weights for posterior state x in times 1:K

% Your code here, please. 
% If you want to be a bit fancy, then only store and output the particles if the function
% is called with more than 2 output arguments.
K = size(Y,2);
n = size(x_0, 1);

xfp = zeros(n, K);
Pfp = zeros(n, n, K);
Xp = zeros(n, N, K);
Wp = zeros(N, K);

plot = 1;

%intial create parciles
Xk = mvnrnd(x_0, P_0, N)';
Wk = ones(1, N) / N;
j = 1:N;

% %intialize Xk-1
% Xkold = Xk;

%Filter for every step
 for k = 1:K

        Xkold = Xk;

        [Xk, Wk] = pfFilterStep(Xk, Wk, Y(:, k), proc_f, proc_Q, meas_h, meas_R);
        % Store data, they are non-resampled
%         Xp(:, :, k) = Xk;
%         Wp(:, k) = Wk;
        
        %if want plot
        if plot 
            plotFunc(k, Xk, Xkold, j);
        end

        %If want resample:
        if bResample
            [Xk, Wk, j] = resampl(Xk, Wk);
        end

        Xp(:, :, k) = Xk;
        Wp(:, k) = Wk;
        
        xfp(:, k) = sum(Xk .* Wk, 2);
        Pfp(:, :, k) = (Wk.*(Xk - xfp(:,k)))*(Xk - xfp(:,k))';
        %Here Pfp I ask chatgpt to give me.
%         %update Xkold
%         Xkold = Xk;

    end
end


function [Xr, Wr, j] = resampl(X, W)
    % Copy your code from previous task! 
    % Your code here!
N = size(X,2);
n = size(X,1);
Xr = zeros(n,N);
Wr = zeros(1,N);
j = zeros(1,N);

% Compute cumulative sum of weights
cumulativeSum = cumsum(W);

% Resampling loop
for i = 1:N
    % Generate a random number
    r = rand();
    
    % Find the index corresponding to the random number in the cumulative sum
    index = find(cumulativeSum >= r, 1);
    
    % Resample particle and weight
    Xr(:,i) = X(:,index);
    Wr(i) = 1/N;
    j(i) = index;
end
end

function [X_k, W_k] = pfFilterStep(X_kmin1, W_kmin1, yk, proc_f, proc_Q, meas_h, meas_R)
    % Copy your code from previous task!
    % Your code here!
    N = size(X_kmin1,2);
    n = size(X_kmin1,1);

    for i = 1:N
        X_k(:,i) = proc_f(X_kmin1(:,i))+mvnrnd(zeros(n,1),proc_Q,1)';

% Lec8 page 14
    p = normpdf(yk, meas_h(X_k(:,i)), sqrt(meas_R));
    W_k(i) = W_kmin1(i) * p;
    end
    W_k = W_k./sum(W_k);
end