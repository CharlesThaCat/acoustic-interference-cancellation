function S = FXNLMSinit(w0,mu,est_sec,sec_num,sec_den,leak)

% FXNLMSinit    Initialize Parameter Structure for the FXNLMS Algorithm
%
% Arguments:
% w0            Coefficients of FIR filter at start (@n=1)
% mu            Step size for the NLMS algorithm 
% est_sec       Estimated secondary path
% sec_num       Numerator of secondary path
% sec_den       Denomerator of secondary path
% leak          Leaky factor
%                 leak = 0 for conventional FXNLMS
%                 0 < leak <1/step for leaky FXNLMS algorithm
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd
 
if nargin < 6              % Set default to conventional NLMS algorithm
	leak = 0;
end

% Assign structure fields

S.coeffs  = w0(:);         % Weight (column) vector of FIR filter 
S.step    = mu;            % Step size of the LMS algorithm
S.leakage = leak;          % Leaky factor for the leaky LMS algorithm
S.iter    = 0;             % Iteration count
S.alpha   = 0.001;         % A small constant to avoid division with zero                   
S.estsec  = est_sec;       % Estimated secondary path (FIR model)
S.sec_num = sec_num;       % Secondary path, numerator
S.sec_den = sec_den;       % Secondary path, denominator
S.AdaptStart = length(w0); % Running effect of adaptive filter, minimum M