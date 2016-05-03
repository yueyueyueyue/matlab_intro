%% Data Acquisition demo
% This demo shows how Data Acquisition Toolbox can be used to read in data
% from a sound card or other device and analyze the data as it is being
% acquired

%% Clear out any devices not properly closed
delete( daqfind() );

%% Code the setup live on site.

%% List the installed hardware drivers
devices = daqhwinfo();
disp ( devices )

%% List the installed devices using the winsound driver
soundcards = daqhwinfo( 'winsound' );
disp ( soundcards );
disp ( soundcards.ObjectConstructorName{1} );

%% Create analoginput and specify settings for acquisition
aiobj = analoginput('winsound', 0);
addchannel(aiobj,1);
aiobj.SampleRate = 8000;
Ns = 2000;
aiobj.SamplesPerTrigger = Ns;
aiobj.TriggerRepeat = Inf;

%% Collect, analyze and plot the data. Put analysis and plotting in loop, fix and annotate axis
% For each iteration, new data is acquired, spectrogram is calculated and plotted.
start(aiobj);
pause(1);
while ( true );
    d = peekdata(aiobj,Ns);
    [S,F,T,P] = spectrogram(d,64,[],128,8000);
    surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
    view(0,90);
    xlabel('Time (Seconds)'); ylabel('Hz');
    drawnow;
end;
stop(aiobj);

%% Clear up
delete(aiobj);
clear aiobj