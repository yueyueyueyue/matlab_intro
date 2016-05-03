%% Data Acquisition demo
% This demo shows how Data Acquisition Toolbox can be used to read in data
% from a sound card or other device and analyze the data as it is being
% acquired

%% Clean out any devices not properly cleared.
delete( daqfind() );

%% Create analoginput and specify settings for acquisition
aiobj = analoginput('winsound', 0);
addchannel(aiobj,1);
aiobj.SampleRate = 8000;
Ns = 2000;
aiobj.SamplesPerTrigger = Ns;
%% Add trigger setup code here.

aiobj.TriggerType = 'software';
aiobj.TriggerConditionValue = 0.01;
aiobj.TriggerChannel = aiobj.Channel(1);
aiobj.TriggerDelay = -0.1;

%% Collect, analyze and plot the data. Put analysis and plotting in loop, fix and annotate axis
% For each iteration, new data is acquired, spectrogram is calculated and plotted.
warning ( 'off', 'daq:peekdata:requestedSamplesNotAvailable' );
d = zeros(Ns,1);
while ( true )
	start(aiobj);
	pause(0.01);
	maxVal = -inf;	
	
	while( strcmp( aiobj.Running, 'On' ) )		
		subplot ( 2, 1, 1 );
		dTemp = peekdata(aiobj,Ns);
		d(1:length(dTemp)) = dTemp;		
		maxVal = max(maxVal, max(d(:)) );		
		plot ( d );
		if ( maxVal ~= 0 )
			axis( [0 length(d) -maxVal maxVal] );				
		end
		drawnow;		
		pause(0.01);
	end;
	stop(aiobj);
	%
	data = getdata(aiobj);
	subplot ( 2, 1, 2 );
	plot ( (1:length(data))/8000-0.1, data );			
	xlabel('Time (Seconds)'); ylabel('Volt');		
end

%% Clear up
delete(aiobj);
clear aiobj