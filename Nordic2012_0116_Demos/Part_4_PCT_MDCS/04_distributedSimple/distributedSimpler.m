%% Open MATLAB pool of workers
%matlabpool open Speedy 16
clear;
if ( matlabpool('size')==0); matlabpool( 'open' ); end

%% Create a local array of random numbers
R = rand(100, 1000);

%% Create simple distributed array from local array
A = distributed(R);

%% Check memory usage
whos

%% spmd blocks provide a window into the workers
spmd
    disp(A)	
end

%% Can work with distributed arrays just as with local arrays
B = A';

%% Matrix multiplication, results in new distributed array
C = A * B;

%% Singular value decomposition of distributed array
[U,S,V] = svd(C);

%% Copy all parts of distributed array to client
spy(S)

%% Use labindex to know which worker we are on
spmd
	disp(labindex)	
end

%% Create distributed array directly on the workers.
A = distributed.rand(100,1000);
