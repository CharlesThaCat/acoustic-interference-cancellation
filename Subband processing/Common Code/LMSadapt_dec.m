function [yn,en,S] = LMSadapt_dec(un,S)

% LMSadapt_dec      LMS Algorithm for Decision-Directed Channel Equalization
%
%                   The history of output, squared error and coefficients 
%                   of FIR filter are passed to calling function. 
%                   Only for decision-directed mode channel equalization
%
% Arguments:
% un                Input signal
% S                 Adptive filter parameters as defined in LMSinit.m
% yn                History of output signal
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);               % Length of FIR filter
mu = S.step;                        % Step size mu
leak = S.leakage;                   % Leaky factor
w = S.coeffs;                       % Weight vector of FIR filter
u = zeros(M,1);                     % Input signal vector

ITER = length(un);                  % Length of input sequence
yn = zeros(1,ITER);                 % Initialize output sequence to zero
en = zeros(1,ITER);                 % Initialize error sequence to zero

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER    
    u = [un(n); u(1:end-1)];         % Input signal vector [u(n),u(n-1),...,u(n-M+1)]'
    yn(n) = w'*u;                    % Output signal
    dn(n) = sign(yn(n));             % Only for decision directed mode channel equalizer
    en(n) = dn(n) - yn(n);           % Estimation error
    w = (1-mu*leak)*w + (mu*en(n))*u;% Tap-weight adaptation
    S.iter = S.iter + 1;
end

S.coeffs = w;                        % Coefficient values at the final iteration
if ComputeEML == 1;
    S.eml = eml;
end


