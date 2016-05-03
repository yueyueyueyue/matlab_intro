%% This example shows the use of bsxfun

% C = bsxfun(fun,A,B) applies an element-by-element binary operation to
% arrays A and B, with singleton expansion enabled. fun is a function
% handle, and can either be an M-file function or one of a selected number
% of built in functions

A = magic(4000);

tic
Anew1 = A - repmat(mean(A),length(A),1);
toc

tic
Anew2 = bsxfun(@minus, A, mean(A));
toc

isequal(Anew1,Anew2)