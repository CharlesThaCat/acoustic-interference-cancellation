function S = SOAFinit(w0,mu,leak)

% SOAFinit       Initialize Parameter Structure for the SOAF-LMS Algorithm
%
% Arguments:
% w0             Coefficients of FIR filter at start (@n=1)
% mu             Step size for LMS algorithm 
% leak           Leaky factor:
%                  leak = 0 for conventional LMS
%                  0 < leak <1/step for leaky LMS algorithm
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd


if nargin < 3                 % Set default to conventional LMS algorithm
	leak = 0;
end

% Assign structure fields

S.coeffs        = w0(:);      % Coefficients of FIR filter 
S.step          = mu;         % Step size 
S.leakage       = leak;       % Leakage factor 
S.iter          = 0;          % Iteration count
S.AdaptStart    = length(w0); % Running effects 
M               = length(w0); % Length of filter
S.beta          = 1/M;        % Forgetting factor

for j=1:M,                    % DCT-transform matrix
   S.T(1,j)=1/sqrt(M);
   for i=2:M,
     S.T(i,j)=sqrt(2/M)*cos(pi*(i-1)*(2*j-1)/2/M);
   end
end			                     
