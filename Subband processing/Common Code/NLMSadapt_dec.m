function [yn,en,S] = NLMSadapt_dec(un,S)

% NLMSadapt        NLMS Algorithm for Decision-Directed Channel Equalization
%
%                  Perform over the entire length of the input sequence. 
%                  The history of output, square error and coefficients of FIR 
%                  filters are passed out to extenal. 
%                  Only for decision-directed mode channel equalization
% Arguments:
% un               Input signal
% S                Adptive filter parameters as defined in NLMSinit.m
% yn               History of output signal
% en               History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);         % Length of FIR filter
mu = S.step;                  % Step size of NLMS algorithm (between 0 and 2)
leak = S.leakage;             % Leaky factor for the leaky NLMS algorithm
alpha = S.alpha;              % A small constant
w = S.coeffs;                 % Coefficients of FIR filter
u = zeros(M,1);               % Input signal vector

ITER = length(un);            % Length of input sequence
yn = zeros(1,ITER);           % Initialize output sequence to zero
en = zeros(1,ITER);           % Initialize error sequence to zero

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER    
    u = [un(n); u(1:end-1)];  % Input signal vector [u(n),u(n-1),...,u(n-M+1)]';
    yn(n) = w'*u;             % Estimated output signal
    dn(n) = sign(yn(n));      % Only for decision directed mode channel equalizer
    en(n) = dn(n) - yn(n);    % Estimation error signal
    w = (1-mu*leak)*w + (mu*en(n)/(u'*u + alpha))*u;    
                              % Weight adaptation for the next cycle
    S.iter = S.iter + 1;
end

S.coeffs = w;                 % Coefficient values at final iteration
if ComputeEML == 1;
    S.eml = eml;
end
