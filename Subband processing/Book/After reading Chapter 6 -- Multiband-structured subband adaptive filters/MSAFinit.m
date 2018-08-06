function S = MSAFinit(w0,mu,N,L,H,F)

% MSAFinit      Initialize Parameter Structure for the MSAF Algorithm
%                 Psuedo-QMF CMFB is Used by Default, H and F are Used Otherwise
%
% Arguments: 
% w0            Coefficients of FIR filter at start
% mu            Step size
% N             Number of subbands
% H             Analysis filter bank (optional), each column represents a filter
% F             Synthesis filter bank (optional), each column represents a filter

if nargin > 4
    if (size(H,2)~=N)|(size(F,2)~=N)
        error('Columns of H (%d) or F (%d) not match with N = %d',size(H,2),size(F,2),N);
    end
else

% Defualt filter bank: Pseudo-QMF CMFB

    [hopt,passedge] = opt_filter(L-1,N); % Generate a prototype lowpass filter
    [H,F] = make_bank(hopt,N);           % Generate filter banks using cosine modulation
    H = sqrt(N)*H';                      % Analysis section
    F = sqrt(N)*F';                      % Synthesis section
end

% Assign structure fields

S.coeffs        = w0(:);                 % Convert to column vector of length M
S.step          = mu;
S.analysis      = H;
S.synthesis     = F;
S.iter          = 0;                     % Iteration count
S.alpha         = ones(1,N)*1e-4;        % Small positive constant
S.AdaptStart    = L + length(w0);        % Running effect of analysis and adaptive filter, 
                                         %   minimum L + M


                     
