function dy = odesystem(t, y, m, b, k)                  %#ok
% 2nd-order ODE
%
%   m*x'' + b*x' + k*x = 0
%
% Reduce to system of two 1st-order ODEs
%
%   x' = z
%   z' = -1/m * (b*z + k*x)
%
%
% Copyright 2010 The MathWorks, Inc.

%   y = [x; z]

dy(1) = y(2);
dy(2) = -1/m * (k * y(1) + b * y(2));

dy = dy(:); % convert to column vector