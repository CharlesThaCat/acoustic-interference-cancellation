function S = PRAinit(w0,mu,P)

% PRAinit       Initialize Parameter Structure for Partial Rank Algorithm
%
% Arguments:
% w0            Coefficients of FIR filter at start (@n=1)
% mu            Step size for the NLMS algorithm 
% P             Projection order
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

% Assign structure fields

S.coeffs        = w0(:);          % Weight (column) vector of FIR filter 
S.step          = mu;             % Step size of the LMS algorithm
S.iter          = 0;              % Iteration count
S.alpha         = eye(P,P)*1e-4;  % A small constant to avoid divide by zero
S.AdaptStart    = length(w0)+P-1; % Running effect of adaptive filter and 
S.order         = P;              %   projection matrix      
