function S = PMSAFinit(w0,mu,N,L,H,F,alpha,delta)

% PMSAFinit        Initialize Parameter Structure for the PMSAF Algorithm
%
%                  Psuedo-QMF CMFB is Used by default, H and F are used otherwise
% Arguments: 
% w0               Coefficients of FIR filter at start
% mu               Step size
% N                Number of subbands
% H                Analysis filter bank (optional), each column represents a filter
% F                Synthesis filter bank (optional), each column represents a filter
% alpha            Adjust scaling of tap weights 
% delta            Small constant
% 
% Subband Adaptive Filtering: Theory and Implementation
% by Lee, Gan, and Kuo, 2008
% Publisher: John Wiley and Sons, Ltd

if nargin > 4
    if (size(H,2)~=N)||(size(F,2)~=N)
        error('Columns of H (%d) or F (%d) not match with N = %d',size(H,2),size(F,2),N);
    end
else
% Defualt filter bank: Pseudo-QMF CMFB

    [hopt,passedge] = opt_filter(L-1,N); % Generate prototype lowpass filter
    [H,F] = make_bank(hopt,N);           % Generate filter banks using cosine modulation
    H = sqrt(N)*H';                      % Analysis section
    F = sqrt(N)*F';                      % Synthesis section
end

if nargin < 7 || isempty(alpha),         % Use default
    alpha = 0;                           % Try -0.5
end

if nargin < 8 || isempty(delta),
    delta = 1e-4;                        % Use default                 
end


% Assign structure fields

S.coeffs        = w0(:);                 % Convert to column vector of length M
S.step          = mu;                    % Step size
S.analysis      = H;                     % Analysis filter
S.synthesis     = F;                     % Synthesis filter
S.iter          = 0;                     % Iteration count
S.alpha         = alpha;                 % Tap weight scaling
S.delta         = ones(1,N)*delta;       % Small positive constant
S.AdaptStart    = L + length(w0);        % Running effect of analysis and adaptive filter, 
                                         %   minimum L+M
     



