function S = APinit(w0,mu,P)

% APINIT         Initialize Parameter Structure for Affine Projection (AP) Algorithm
%
% Arguments:
% w0             Coefficients of FIR filter at start (@n=1)
% mu             Step size for LMS algorithm 
% P              Projection order
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

% Assign structure fields
S.coeffs        = w0(:);              % Weight (column) vector of filter 
S.step          = mu;                 % Step size
S.iter          = 0;                  % Iteration count
S.alpha         = eye(P,P)*1e-4;      % A small constant 
S.AdaptStart    = length(w0)+P-1;     % Running effect of adaptive filter and projection matrix
S.order         = P;                  % Projection order   
