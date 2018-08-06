function S = NLMSinit(w0,mu,leak)

% NLMSinit      Initialize Parameter Structure for the NLMS Algorithm
%
% Arguments:
% w0            Coefficients of FIR filter at start (@n=1)
% mu            Step size for NLMS algorithm 
% leak          Leaky factor
%                 (leak = 0) [conventional NLMS]
%                 (0 < leak <1/step)  [leaky NLMS]
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

if nargin < 3                    % Set default to conventional NLMS
	leak = 0;
end

% Assign structure fields

S.coeffs        = w0(:);         % Weight (column) vector of FIR filter 
S.step          = mu;            % Step size of the LMS algorithm
S.leakage       = leak;          % Leaky factor for the leaky LMS algorithm
S.iter          = 0;             % Iteration count
S.alpha         = 1e-4;          % A small constant to avoid divide by zero
S.AdaptStart    = length(w0);    % Running effect of adaptive filter, minimum M

                     
