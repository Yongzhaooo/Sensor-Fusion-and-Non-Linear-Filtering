function [x, P] = mu_g(x, P, yacc, Ra, g0)
%g0 is gravity vector
%Ra is eak
%fak =0, assumpution
%yak=Q' *g0 +Ra
%following chapter 4 kalman filter update

Q = Qq(x); 
h = Q'*g0;

[Q0, Q1, Q2, Q3] = dQqdq(x);
% H = [Q0, Q1, Q2, Q3]*g0; this cannot works
H = [Q0'*g0 Q1'*g0 Q2'*g0 Q3'*g0];

%innovation covariance
S = H * P * H' + Ra;

%innovation
v = yacc- h;

%kalman gain
K = P * H' * inv(S);

x = x + K* v;
P = P - K* S *K';

end