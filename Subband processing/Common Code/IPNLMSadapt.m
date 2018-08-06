function [yn,en,S] = IPNLMSadapt(un,dn,S)

% IPNLMSadapt        Adaptive FIR Filter with the IPNLMS Algorithm 
%
%                    Performs over entire length of input sequence. The history of output, 
%                    square error and coefficients of FIR filters are passed to extenal
% Arguments:
% un                 Input signal
% dn                 Desired signal
% S                  Adaptive filter parameters
% yn                 History of output signal
% en                 History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd


M = length(S.coeffs);               % Length of FIR filter
mu = S.step;                        % Step size  of IPNLMS algorithm 
                                    %  (between 0 and 2)
leak = S.leakage;                   % Leaky factor of leaky IPNLMS
alpha = S.alpha;                    % Scaling for coefficients
delta = 1e-4;                       % Small constant
AdaptStart = S.AdaptStart;
w = S.coeffs;                       % Coefficients of FIR filter

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
    u = [un(n); u(1:end-1)];        % Input signal vector [u(n),u(n-1),...,u(n-L+1)]';
    yn(n) = w'*u;                   % Estimated output
    en(n) = dn(n) - yn(n);          % Estimation error
    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;  % System error norm (normalized)
    end
    if n >= AdaptStart
        g = (1-alpha)/(2*M) + abs(w)*(1+alpha)/(2*sum(abs(w))+delta);
        G = repmat(g,1);
        w = (1-mu*leak)*w + (G.*u*mu*en(n))/((u.*G)'*u + delta);
        S.iter = S.iter + 1;
    end
end

S.coeffs = w;                       % Coefficient values at final iteration
if ComputeEML == 1;
    S.eml = eml;
end

