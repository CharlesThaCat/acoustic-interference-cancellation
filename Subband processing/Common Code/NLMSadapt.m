function [yn,en,S] = NLMSadapt(un,dn,S)

% NLMSadapt         Adaptive FIR Filter with the NLMS Algorithm 
%
%                   Perform over entire length of input sequence. The history of output,
%                   square error and coefficients are passed out to extenal
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in NLMSinit.m
% yn                History of output signal
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);             % Length of FIR filter
mu = S.step;                      % Step size (between 0 and 2)
leak = S.leakage;                 % Leaky factor 
alpha = S.alpha;                  % A small constant
AdaptStart = S.AdaptStart;
w = S.coeffs;                     % Weight vector of FIR filter
u = zeros(M,1);                   % Input signal vector

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
    u = [un(n); u(1:end-1)];      % Input signal vector 
    yn(n) = w'*u;                 % Estimated output 
    en(n) = dn(n) - yn(n);        % Estimation error 
    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;% System error norm (normalized)
    end
    if n >= AdaptStart
        w = (1-mu*leak)*w + (mu*en(n)/(u'*u + alpha))*u;  
                                  % Tap-weight adaptation
        S.iter = S.iter + 1;
    end
end

S.coeffs = w;                     % Coefficient values at final iteration 
if ComputeEML == 1;
    S.eml = eml;
end
