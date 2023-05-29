function [x, P] = mu_m(x, P, mag, m0, Rm)

Q = Qq(x); 
h = Q'*m0;

[Q0, Q1, Q2, Q3] = dQqdq(x);
% H = [Q0, Q1, Q2, Q3]*g0; this cannot works
H = [Q0'*m0 Q1'*m0 Q2'*m0 Q3'*m0];

%innovation covariance
S = H * P * H' + Rm;

%innovation
v = mag- h;

%kalman gain
K = P * H' * inv(S);

x = x + K* v;
P = P - K* S *K';

end