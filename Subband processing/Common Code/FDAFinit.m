function S = FDAFinit(w0,mu,mu_unconst,iter)

% FDAFinit      Initilize Parameter Structure for the FDAF Algorithm
%
% Arguments:
% w0            Coefficients of FIR filter at start (@n=1)
% mu            Step size for constrained FDAF algorithm 
% mu_const      Step size for unconstrained FDAF algorithm
% iter          Number of iteration
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

w0 = w0(:);
M = length(w0);
WEIGHT = fft([w0; zeros(M,1)]);
u_new = zeros(M,1);
u_old = zeros(M,1);
un_blocks = [u_old; u_new];

% Assign structure fields only after error checking is complete

S.coeffs        = w0;         % Coefficients of FIR filter 
S.length        = M;          % Length of adaptive filter
S.step          = mu;         % Step size of constrained FDAF 
S.step_unconst  = mu_unconst; % Step size of unconstrained FDAF 
S.iter          = 0;          % Iteration count
S.AdaptStart    = length(w0); % Running effect of adaptive filter
S.weight        = WEIGHT;     % FFT of zero-padded weight vector
S.palpha        = 0.5;        % Constant to update the power in each frequency bin
S.ref           = un_blocks;  % 2M-sample block of input signal   


