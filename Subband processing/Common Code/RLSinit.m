function S = RLSinit(w0,lamda)

% RLSinit       Initialize Parameter Structure for the Recursive Least Square (RLS) Algorithm
%
% Arguments:
% w0            Coefficients of FIR filter at start (@n=1)
% lamda         Exponential window for RLS algorithm 
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

% Assign structure fields

S.coeffs        = w0(:);                % Weight (column) vector of FIR filter 
S.lamda         = lamda;                % Exponential  weighting factor
S.iter          = 0;                    % Iteration count
S.P0            = eye(length(w0))*0.01; % Initial inverse input autocorrelation matrix 
S.AdaptStart    = length(w0);           % Running effect 