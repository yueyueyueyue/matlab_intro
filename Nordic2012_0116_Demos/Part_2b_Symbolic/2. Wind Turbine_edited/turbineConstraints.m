function [c,ceq] = turbineConstraints(x)

ceq = [];
u_c = x(1);
u_r = x(2);
u_f = x(3);

% Limits on u_c
c(1) = 0.4*u_r - u_c; % <= 0
c(2) = u_c - 0.5*u_r;   % <= 0
% Limits on u_f
c(3) = 1.8*u_r - u_f; % <= 0
c(4) = u_f - 2*u_r; % <=0


