function S = FXLMSinit(w0,mu,est_sec, sec_num, sec_den,leak)

% FXLMSinit     Initialize Parameter Structure for the FXLMS Algorithm
%
% Arguments:
% w0            Coefficients of FIR filter at start (@n=1)
% mu            Step size for the LMS algorithm 
% est_sec       Estimated secondary path
% sec_num       Numerator of secondary path
% sec_den       Denomerator of secondary path
% leak          Leaky factor
%                 leak = 0 for the conventional FXLMS
%                 0 < leak <1/step for the leaky FXLMS algorithm
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

if nargin < 6               % Set default to conventional LMS algorithm
	leak = 0;
end

% Assign structure fields
S.coeffs  = w0(:);          % Weight (column) vector of FIR filter 
S.step    = mu;             % Step size of LMS algorithm
S.leakage = leak;           % Leaky factor for the leaky LMS algorithm
S.iter    = 0;              % Iteration count
S.estsec  = est_sec;        % Estimated secondary path (FIR model)
S.sec_num = sec_num;        % Secondary path, numerator
S.sec_den = sec_den;        % Secondary path, denominator
S.AdaptStart = length(w0);  % Running effect of adaptive filter, minimum M
                     
