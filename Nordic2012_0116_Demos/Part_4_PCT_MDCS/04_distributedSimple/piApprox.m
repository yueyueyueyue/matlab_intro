%% Numerical Estimation of Pi Using SPMD
% This demo shows the basics of working with spmd statements, and how they
% provide an interactive means of performing parallel computations.  We do
% this by performing relatively simple computations to approximate pi.

%%
% We define the variables |a| and |b| on all the labs, but let their values
% depend on |labindex| so that the intervals [a, b] correspond to the
% subintervals shown in the figure. 
spmd
    a = (labindex - 1)/numlabs;
    b = labindex/numlabs;
    fprintf('Subinterval: [%-4g, %-4g]\n', a, b);
end
%%
% We let all the labs now use a MATLAB quadrature method to approximate
% each integral.  They all operate on the same function, but on the
% different subintervals of [0,1] shown in the figure above.

myFunction = @(x) 4./(1 + x.^2);
spmd
    myIntegral = quadl(myFunction, a, b);
    fprintf('Subinterval: [%-4g, %-4g]   Integral: %4g\n', ...
            a, b, myIntegral);
end

%% Inspect Results in the Client  
piApprox = sum([myIntegral{:}]);   
fprintf('pi           : %.18f\n', pi);
fprintf('Approximation: %.18f\n', piApprox);
fprintf('Error        : %g\n', abs(pi - piApprox))
