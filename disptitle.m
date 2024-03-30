function disptitle(str)
% DISPTITLE Displays the title centered within a line of dashes.
%   disptitle(str) takes a title string (str) as input and displays it
%   centered within a line of dashes. 
%
%   Example:
%       disptitle('This is a sample title')
%
%   Output:
%       ---------------------- This is a sample title ----------------------

totLength = 80;
strLength = length(str);
if strLength < 80
    prebarLength = floor((totLength - strLength)/2);
    postbarLength = totLength - strLength - prebarLength;
    prebar = sprintf(repmat('-', 1, prebarLength));
    postbar = sprintf(repmat('-', 1, postbarLength));
    fulltext = [prebar str postbar];
else
    fulltext = str;
end
disp(fulltext);
end