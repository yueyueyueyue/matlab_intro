%% Calculating the Mandelbrot Set on a GPU


%% Setup
clear;
maxIterations = 200;
gridSize = 400;
xlim = [-0.748766713922161, -0.748766707771757];
ylim = [ 0.123640844894862,  0.123640851045266];

%% Setup the data
x = gpuArray.linspace( xlim(1), xlim(2), gridSize );
y = gpuArray.linspace( ylim(1), ylim(2), gridSize );
count = gpuArray( ones( gridSize ) );

%% Do the math 
tic;
[xGrid,yGrid] = meshgrid( x, y );
z0 = complex( xGrid, yGrid );

% Calculate
z = z0;
for n = 0:maxIterations
    z = z.*z + z0;
    inside = abs( z )<=2;
    count = count + inside;
end
count = log( count );
fprintf ( 'Time to calculate: %0.2f s.\n', toc );

%% Show the results.
imagesc( x, y, count )
colormap( [jet(128);flipud( jet(128) );0 0 0] );
axis image


