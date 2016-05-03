%% Declare a symbolic variable;
clear all;
syms x;

%% Use it to build a function.
a = x^2 %#ok

%% Declare a second equation.
syms y;
x = 2*y %#ok

%% Subsititute it into a
b = subs(a) %#ok

%% Manipulate the function symbolically.
c = diff(b) %#ok
