function [yn,en,S] = RLSadapt(un,dn,S)

% RLSadapt          Recursive Least Square Algorithm (See Sections 1.4 and 6.3)
%
% Parameters:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in RLSinit.m
% yn                History of output signal
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);             % Length of FIR filter
lamda = S.lamda;                  % Exponential factor 
invlamda = 1/lamda;
AdaptStart = S.AdaptStart;
w = S.coeffs;                     % Weight vector of FIR filter
P = S.P0;                         % Inverse correlation matrix
u = zeros(M,1);                   % Input signal vector
% alpha = S.alpha;                % Small constant
% g = zeros(M,1);                 % Updating gain vector

ITER = length(un);                % Length of input sequence
yn = zeros(1,ITER);               % Initialize output sequence to zero
en = zeros(1,ITER);               % Initialize error sequence to zero

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER    
    u = [un(n); u(1:end-1)];      % Input signal vector contains [u(n),u(n-1),...,u(n-M+1)]';
    yn(n) = w'*u;                 % Output of adaptive filter
    en(n)=dn(n)-yn(n);            % Estimated error
    
    if n >= AdaptStart
        r = invlamda*P*u;         % See equ. (1.20)
        g = r/(1+u'*r);           % See equ. (1.19)
        w = w + g.*en(n);         % Updated tap-weights for the next cycle, (1.18)
        P = invlamda*(P-g*u'*P);  % Inverse correlation matrix update, (1.21)
    end                           %   see (1.20) and (1.21)
    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;% System error norm (normalized)
    end
end

S.coeffs = w;                     % Coefficient values at final iteration
if ComputeEML == 1;
    S.eml = eml;
end
