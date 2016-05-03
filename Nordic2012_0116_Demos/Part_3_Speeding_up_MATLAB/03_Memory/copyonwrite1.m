%% Example: Managing Memory 

% Copyright 2012 MathWorks, Inc.

clear, clc
watch_malloc;

%% Create a cell array
% (3000*3000 elts) * (8 bytes/elt) = 72,000,000 B ~= 70MB
C{1} = rand(3000,3000);

%% Create a second element in the cell array
C{2} = rand(3000,3000);

%% Copy the cell array
% What will happen to memory?
C_new = C;       

%% Modify the first element of the first matrix
% Can you explain what happened to memory?
C{1}(1,1) = 2;   

%% Pause graph
stop(timerfind);

%% Start graph again
start(timerfind);

%% Modify the first element of the second matrix
C{2}(1,1) = 2;   

%% Clear old cell array
clear C;

%% Clear new cell array
clear C_new;

