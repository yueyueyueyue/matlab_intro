%% Open Notebook
% Derive model for the average power produced by wind turbine.
nb = mupad('Wind_turbine_power.mn');

%% Import Result from Notebook
% Import average power variable from notebook and generate equivalent
% MATLAB (numeric) code. 
avgPower = getVar(nb, 'Peavg');
disp ( avgPower );
matlabFunction(avgPower,'file','calc_avgPower');
% You can also create an embedded MATLAB block for use in Simulink
% new_system('Wind_turbine_power');
% open_system('Wind_turbine_power');
% emlBlock('Wind_turbine_power/calg_avgPower',avgPower);
% % You can also create Simscape language equations for use with Simscape
% simscapeEquation('avgPow',avgPower)

%% Define Variables Associated with Turbine and Wind Farm Site
% Define Weibull parameters associated with wind farm site
c = 12.5;
k = 2.2;
%% Define variables associated with wind turbine design
Uc = 6.5; % cut-in wind speed
Ur = 13; % rated wind speed
Uf = 26; % furling wind speed
Per = 2.4e6; % rated power output

%% Calculate average power for turbine 
% Plot power profile of wind turbine with wind distribution overlaid on it
powerProfile(Per,c,k,Uc,Uf,Ur);
% Calculate average power (kW) for wind turbine with characteristics
% specified above.
avgPower = calc_avgPower(Per,c,k,Uc,Uf,Ur)/1000;
fprintf ( 'Average power: %0.2f MW.\n', avgPower );

%% Calculate average power for altenative turbine design
Uc = 3; % cut-in wind speed
Ur = 6; % rated wind speed
Uf = 12; % furling wind speed
powerProfile(Per,c,k,Uc,Uf,Ur);
avgPower = calc_avgPower(Per,c,k,Uc,Uf,Ur)/1000;
fprintf ( 'Average power: %0.2f MW.\n', avgPower );

%% Determine optimal turbine design
% We want to determine which wind turbine configuration produces optimal
% average power output at our particular site.  We make the following
% assumptions:
% * We are evaluating a single wind farm site, therefore Weibull parameters
% are constant (c = 12.5, k = 2.2)
% * There are constraints on the relationship between Uc, Ur, & Uf
% ** 0.4*Ur < Uc < 0.5*Ur
% ** 1.5*Ur < Uf < 2*Ur
% * Rated power of wind turbine is 2400 kW
x0 = [5.5; 12; 22]; % initial guess for [Uc; Ur; Uf]
lb = [2;5;8];
options = optimset('algorithm', 'active-set', 'Display', 'iter');
% run optimization
[x,fval] = fmincon(@turbineObjective,x0,[],[],[],[],lb,[],...
    @turbineConstraints,options);
Uc_opt = x(1);
Ur_opt = x(2);
Uf_opt = x(3);
avgPower = -fval/1000;
fprintf ( 'Wind speeds: Uc: %0.2f m/s Ur: %0.2f m/s Uf: %0.2f m/s.\n', ...
	Uc_opt, Ur_opt, Uf_opt );
fprintf ( 'Average power: %0.2f MW.\n', avgPower );

%% Plot optimal wind turbine power profile
powerProfile(Per,c,k,Uc_opt,Uf_opt,Ur_opt)
