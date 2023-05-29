function [x,P] = tu_qw(x, P, omega, T, Rw)
% instead of thinking T as the time since the last measurement, it can be
% better to think it as the sampling interval.

F = eye(size(x, 1)) + (T/2) * Somega(omega);
G = (T/2) * Sq(x);

x = F * x;
P = F * P * F' + G * Rw * G';

% else
% x = x;
% P = P + Rw;
end
