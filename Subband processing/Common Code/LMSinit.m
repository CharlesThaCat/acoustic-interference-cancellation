function S = LMSinit(w0,mu,leak)

% LMSinit       Initialize Parameter Structure for the LMS Algorithm
%
% Arguments:
% w0            Coefficients of FIR filter at start (@n=1)
% mu            Step size mu 
% leak          Leaky factor:
%                 leak = 0 for conventional LMS
%                 0 < leak <1/step for leaky LMS algorithm
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd


if nargin < 3                 % Set default to conventional LMS algorithm
	leak = 0;
end

% Assign structure fields

S.coeffs        = w0(:);      % Weight (column) vector of FIR filter 
S.step          = mu;         % Step size of LMS algorithm
S.leakage       = leak;       % Leaky factor 
S.iter          = 0;          % Iteration count
S.AdaptStart    = length(w0); % Running effect of adaptive filter, minimum M
                     
