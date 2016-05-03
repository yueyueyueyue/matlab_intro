function inplaceOptimization
%% create data
x = randn(2e7,1);

%% Not in-place and new variable
y = myfunc(x);

%% Clear
clear y;

%% In-place optimization (!)
x = myfuncInPlace(x);

%% (Not in-place)
x = myfunc(x);

%% (In-place function but new output variable)
y = myfuncInPlace(x);


end

%% Subfunctions

function y = myfunc(x)
y = sin(2*x.^2+3*x+4);
end

function x = myfuncInPlace(x)
x = sin(2*x.^2+3*x+4);
end