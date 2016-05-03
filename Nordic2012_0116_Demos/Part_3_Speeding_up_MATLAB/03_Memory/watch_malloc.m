% --------------------------------------------------------------------------
% watch_malloc()
% --------------------------------------------------------------------------
% Main entry point to the program
% --------------------------------------------------------------------------
function watch_malloc(varargin)

% Create a figure

   figurehandle = figure                            ;
   set(figurehandle,'WindowStyle','Docked');
   set(figurehandle, 'CloseRequestFcn', @myclosereq);
   setappdata(0,'figurehandle',figurehandle)        ;

% Create initial data

   delT = 0.1       ;%update frequency
   x    = -119:delT:0 ;

   usr  = memory;
   m    = usr.MemUsedMATLAB/1024/1024;
   y    = m*ones(size(x))  ;

   setappdata(figurehandle,'delT', delT);

% Plot initial data to the figure

   plot(x, y, 'LineWidth', 4);
   xlabel('Time (s)')
   ylabel('Memory (MB)')

% Create and start a timer

   mytimer     = timer('TimerFcn'     ,@malloc_update, ...
                       'StartDelay'   , 0            , ...
                       'Period'       , delT         , ...
                       'Name'         ,'objectTimer' , ...
                       'ExecutionMode','fixedrate'        );

   start(mytimer);

% Disable access to the handle

   set(figurehandle, 'HandleVisibility', 'callback')


% --------------------------------------------------------------------------
% timerUpdate()
% --------------------------------------------------------------------------
% Function for timer object to call.
% --------------------------------------------------------------------------
function malloc_update(varargin)

% Get handles

   fig   = getappdata(0,'figurehandle');
   axe   = get(fig,'Children');

% Get current system resources

   usr  = memory;
   m    = usr.MemUsedMATLAB/1024/1024;
   
% Find the axis data

   h     = get(axe,'Children');

   xdata = get(h,'XData');   
   ydata = get(h,'YData');   

% Update figure for the new time

   xdata = xdata+getappdata(fig,'delT');
   ydata = [ydata(2:end), m];

   set(h, 'XData', xdata);
   set(h, 'YData', ydata);

% Create a new figure title

   title(axe,[ 'Allocated:  ' num2str(m) ' MB'])

% Fix the 'tick spacing' problem when scrolling

   set(axe, 'XLim', [min(xdata)-1  max(xdata)+1]);

% Make sure the axis limits go to zero

   ylim    = get(axe,'YLim');
   ylim(1) = 0              ;
   ylim(2) = max(ydata)*1.2 ;
   set(axe,'YLim',ylim)     ;
   

% --------------------------------------------------------------------------
% myclosereq()
% --------------------------------------------------------------------------
% Deletes the timer when the figure is closed 
% --------------------------------------------------------------------------
function myclosereq(varargin)

% Stop and delete timer

   mytimer = timerfind('Name', 'objectTimer') ;

   if ~isempty(mytimer)
      stop  (mytimer)                         ;
      delete(mytimer)                         ;
   end

% Call normal close request

   closereq                                   ;

