function out = smooth(un,window)

% smooth            Smoothing Input Signal Using Moving Averaging
%
% Arguments:
% un                Input signal
% window            Length of moving-average window
% out               Smooth output signal
%
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

out = zeros(1,length(un)-window);     % Preallocate the out array 

for n = 1:1:length(un)-window
    out(n) = mean(un(n:n+window));
end