function [yn,en,S] = APadapt(un,dn,S)

% APadapt            Affine Projection Algorithm (See Sections 1.4 and 6.3)
%
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in APinit.m
% yn                History of output signal
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);                     % Length of the FIR filter
mu = S.step;                              % Step size (between 0 and 2)
P = S.order;                              % Projection order
alpha = S.alpha;                          % Small constant
AdaptStart = S.AdaptStart;
w = S.coeffs;                             % Weight vector of FIR filter
u = zeros(M,1);                           % Tapped-input vector
A = zeros(M,P);                           % Projection matrix
d = zeros(P,1);                           % Desired response vector

ITER = length(un);                        % Length of input sequence
yn = zeros(1,ITER);                       % Initialize output sequence to zero
en = zeros(1,ITER);                       % Initialize error sequence to zero

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER    
    u = [un(n); u(1:end-1)];              % Input signal vector contains [u(n),u(n-1),...,u(n-M+1)]'
    A = [u A(:,1:end-1)];                 % Data matrix
    d = [dn(n); d(1:end-1)];              % Desired response vector contains [d(n),d(n-1),...,d(n-P+1)]'
    yn(n) = u'*w;                         % Output signal
    e = d - A'*w;                         % Error estimation
    en(n) = e(1);                         % Take the first element of e
    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;        % System error norm (normalized)
    end
    if n >= AdaptStart
        w = w + mu*A*inv(A'*A + alpha)*e; % Tap-weight adaptation
    end
end

S.coeffs = w;                             % Final iteration of coefficients' value.
if ComputeEML == 1;
    S.eml = eml;
end
