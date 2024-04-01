function test2(iLoop, nLoops)
% TEST Displays a progress bar in a for loop.
%   test(iLoop, nLoops) displays a progress bar indicating the current
%   progress of a for loop. The function takes two input arguments:
%   iLoop, which represents the current iteration of the loop, and nLoops,
%   which represents the total number of iterations in the loop.
%
% Usage:
%   for i = 1:nLoops
%       % Add your code here
%       test(i, nLoops);
%   end

% Constants
finishLabel = '>'; % '>' by default
unfinishLabel = '-'; % '-' by default
nAlign = 4; % Number of alignment characters

% Get command windows size
commandWinSize = get(0, 'CommandWindowSize');

preText = '[';

% Get current time
c = datevec(datetime); % [year month day hour minute seconds]
formattedTime = sprintf('%02d:%02d:%02d ',c(4),c(5),round(c(6))); % Format current time

barLength = commandWinSize(1) - length(formattedTime) - length(preText) - 7 - 21  - nAlign;

if iLoop ~= nLoops % Not finished
    if iLoop == 1 % Start
        tic;
        remainingTimeText = ' Estimating remaining time...';
        nDelete = 0;
    else
        runTime = toc;
        remainingTime = runTime/(iLoop-1)*(nLoops-1) - runTime;
        remainingTimeText = formattime(remainingTime);
        remainingTimeText = [' |' remainingTimeText 'remaining'];

        if iLoop == 2
            nDelete = 85;
        else
            nDelete = commandWinSize(1) - nAlign;
        end
    end
    nFinishLabel = floor(iLoop/nLoops*barLength);
    percentageText = sprintf('] %4.1f%%', iLoop/nLoops*100);
    barLabel = sprintf([repmat(finishLabel, 1, nFinishLabel)...
        repmat(unfinishLabel, 1, barLength-nFinishLabel)]);
    showText = [formattedTime preText barLabel percentageText remainingTimeText];

else % Finished
    showText = sprintf([formattedTime 'Finish! 100%%         Time used:' formattime(toc/(nLoops-1)*nLoops) '\n']);
    nDelete = commandWinSize(1) - nAlign;
end

% Escape % and \ characters
showText = strrep(showText,'%','%%');
showText = strrep(showText,'\\','\\\\');

% Print progress bar
fprintf([repmat('\b', 1, nDelete) showText]);
end

function timeText = formattime(totalTime)
% FORMATTIME Formats time in seconds to a readable format.
%   timeText = formattime(totalTime) takes the total time in seconds and
%   returns a formatted string representing the time in hours, minutes, and
%   seconds.

h = floor(totalTime/3600);
m = floor(mod(totalTime,3600)/60);
s = round(mod(mod(totalTime,3600),60));
timeText = sprintf(' %02d:%02d:%02d ', h, m, s);
end