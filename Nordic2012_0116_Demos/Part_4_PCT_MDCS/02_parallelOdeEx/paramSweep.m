%% Parameter Sweep of ODEs
% This is a parameter sweep study of a 2nd order ODE system.
% x = x(t).
%
%   m*x'' + b*x' + k*x = 0
%
% We solve the ODE for a time span of 0 to 25 seconds, with initial
% conditions x(0) = 0 and x'(0) = 1. We sweep the parameters "b" and "k"
% and record the peak values of x for each condition. At the end, we plot a
% surface of the results.
%
% Copyright 2010 The MathWorks, Inc.

%% Initialize Problem
%if ( matlabpool('size') ~= 0 ); matlabpool ('close'); end
m     =         5;  % mass
bVals =  .1:.1 :5;  % damping values
kVals = 1.5:.05:5;  % spring stiffness values
[kGrid, bGrid] = meshgrid(bVals, kVals);
peakVals = nan(size(kGrid));

%% Parameter Sweep
disp('Computing ...');drawnow;

tic;
L=numel(kGrid);
parfor idx = 1:numel(kGrid)
  % Solve ODE
    [T,Y] = ode45(@(t,y) odesystem(t, y, m, bGrid(idx), kGrid(idx)), ...
    [0, 25], ...  % simulate for 25 seconds
    [0, 1]);      % initial conditions
    
    % Determine peak value
    peakVals(idx) = max(Y(:,1));
end
toc;

%% Visualize

figure;
surf(bVals, kVals, peakVals);
xlabel('Damping'); ylabel('Stiffness'); zlabel('Peak Displacement');
view(50, 30)