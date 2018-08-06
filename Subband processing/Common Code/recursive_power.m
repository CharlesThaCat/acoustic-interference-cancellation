function power = recursive_power(un,beta)

% recursive_power    Recursive Estimation of Signal Power Given in (1.14)
%
% Arguments:
% un                 Input signal
% beta               Averaging time constant (forgetting factor)
%                      Typical value = 1/length of moving window
% power              Recursive power of input signal
%
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

power = zeros(1,length(un));     % Preallocate the power array 

power(1) = 0;                    % Initialize power to zero
for n = 1:1:length(un)-1         % Moving averaging power estimation
    power(n+1) = (1-beta)*power(n)+(beta)*(un(n)^2);
end