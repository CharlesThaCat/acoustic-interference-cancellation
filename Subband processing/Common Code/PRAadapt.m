function [yn,en,S] = PRAadapt(un,dn,S)

% PRAadapt          Partial Rank Algorithm (See Section 6.3)
%
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in PRAinit.m
% yn                History of output signal
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);        % Length of FIR filter
mu = S.step;                 % Step size
P = S.order;                 % Projection order
alpha = S.alpha;             % Small constant
AdaptStart = S.AdaptStart;
w = S.coeffs;                % Weight vector of FIR filter
u = zeros(M,1);              % Input signal vector
A = zeros(M,P);              % Projection matrix

ITER = length(un);           % Length of input sequence
yn = zeros(1,ITER);          % Initialize output sequence to zero
en = zeros(1,ITER);          % Initialize error sequence to zero

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER    
    u = [un(n); u(1:end-1)]; % Input signal vector [u(n),u(n-1),...,u(n-M+1)]'
    A = [u A(:,1:end-1)];    % Projection matrix
    yn(n) = u'*w;            % Output of adaptive filter
    en(n) = dn(n) - yn(n);
    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;        % System error norm (normalized)
    end
    if (mod(n-1,P)==0)&(n >= AdaptStart)
        e = en(n:-1:n-P+1)';
        w = w + mu*A*inv(A'*A + alpha)*e; % Tap-weight adaptation for the next cycle
    end
end

S.coeffs = w;                             % Coefficient values at the final iteration
if ComputeEML == 1;
    S.eml = eml;
end
