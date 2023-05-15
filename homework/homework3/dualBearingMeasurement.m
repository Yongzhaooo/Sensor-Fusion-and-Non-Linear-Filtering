function [hx, Hx] = dualBearingMeasurement(x, s1, s2)
%DUOBEARINGMEASUREMENT calculates the bearings from two sensors, located in 
%s1 and s2, to the position given by the state vector x. Also returns the
%Jacobian of the model at x.
%
%Input:
%   x           [n x 1] State vector, the two first element are 2D position
%   s1          [2 x 1] Sensor position (2D) for sensor 1
%   s2          [2 x 1] Sensor position (2D) for sensor 2
%
%Output:
%   hx          [2 x 1] measurement vector
%   Hx          [2 x n] measurement model Jacobian
%
% NOTE: the measurement model assumes that in the state vector x, the first
% two states are X-position and Y-position.
    % Extract position from the state vector
    position = x(1:2);
    
    % Calculate the bearing measurements
    phi1 = atan2(position(2) - s1(2), position(1) - s1(1));
    phi2 = atan2(position(2) - s2(2), position(1) - s2(1));
    
    % Construct the measurement vector
    hx = [phi1; phi2];
    
    % Calculate the Jacobian matrix
    Hx = zeros(2, numel(x));%Here is core.If do not set others to zero there will be mistake
    
    % Derivative of atan2 with respect to x and y
    d_phi1_dx = -(position(2) - s1(2)) / ((position(1) - s1(1))^2 + (position(2) - s1(2))^2);
    d_phi1_dy = (position(1) - s1(1)) / ((position(1) - s1(1))^2 + (position(2) - s1(2))^2);
    
    d_phi2_dx = -(position(2) - s2(2)) / ((position(1) - s2(1))^2 + (position(2) - s2(2))^2);
    d_phi2_dy = (position(1) - s2(1)) / ((position(1) - s2(1))^2 + (position(2) - s2(2))^2);
    
    % Populate the Jacobian matrix
    Hx(1, 1:2) = [d_phi1_dx, d_phi1_dy];
    Hx(2, 1:2) = [d_phi2_dx, d_phi2_dy];
    
    % Return the measurement vector and Jacobian matrix
end

%Hx is not 2x2 matrix, but 2xn matrix. For x only use first two elements as
%position it is natural to take Hx as 2x2, but actually it is still 2xn.
%So in this case the dimension of Hx should be clarified when
%initialize it.
