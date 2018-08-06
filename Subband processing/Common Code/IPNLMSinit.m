function S = IPNLMSinit(w0,mu,alpha,leak)

% IPNLMSinit         Initialize Parameter Structure for the IPNLMS Algorithm
%
% Parameters:
% w0                 Coefficients of FIR filter at start (@n=1)
% mu                 Stepsize for IPNLMS algorithm 
% alpha              Scaling for weight
% leak               Leakage factor
%                      leak = 0 for conventional IPNLMS
%                      0 < leak <1/step for leaky IPNLMS
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

if nargin < 3 || isempty(alpha),
    alpha = 0;                    % Use default
end

if nargin < 4 || isempty(leak),
    leak = 0;                     % Use default
end

% Assign structure fields

S.coeffs        = w0(:);          % Coefficients of FIR filter 
S.step          = mu;             % Step size of IPNLMS algorithm
S.leakage       = leak;           % Leaky factor for leaky IPNLMS
S.iter          = 0;              % Iteration count
S.alpha         = alpha;          % Scaling for coefficients 
S.AdaptStart    = length(w0);     % Running effect of adaptive filter, minimum M

