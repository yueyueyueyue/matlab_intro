%% Create symbolic variables
clear;
syms a b

%% Create an equation
c = sin( a + 2*b + 2 );
disp ( c );

%% Do a substitution
d = subs ( c, a, 4 );
disp ( d );
