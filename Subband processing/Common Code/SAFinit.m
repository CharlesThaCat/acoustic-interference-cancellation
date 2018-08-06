function S = SAFinit(M,mu,N,D,L)

% SAFinit       Initialize Parameter Structure for the Subband Adaptive Filter
%                 DFT Filter Bank Is Used by Default
%
% Arguments:
% M             Length of corresponding fullband filter
% mu            Step size
% N             Number of subbands
% D             Decimation factor, D=N (Critical decimation), D<N (oversampling)
%
% Subband Adaptive Filtering: Theory and Implementation
% by Lee, Gan, and Kuo, 2008
% Publisher: John Wiley and Sons, Ltd

% Defualt is DFT filter bank (Section 2.6)

hopt = fir1(L-1,1/N);               % Generate prototype lowpass filter
[H,F] = make_bank_DFT(hopt,N);      % Generate filter banks using complex modulation
H = sqrt(D)*H;                      % Analysis section
F = sqrt(D)*F;                      % Synthesis section

% Assign structure fields

S.coeffs        = zeros(M/D,N/2+1); % Adaptive subfilters (initialized to zeros)
                                    % Consider only the first N/2 + 1 subfilters
S.step          = mu;               % Step size
S.decfac        = D;                % Decimation factor
S.analysis      = H;                % Analysis filter bank
S.synthesis     = F;                % Synthesis filter bank
S.iter          = 0;                % Iteration count
S.alpha         = 1e-4;             % Small positive constant
S.AdaptStart    = L + M;            % Running effect of the analysis and adaptive 
                                    %   filter, minimum L + M


                     
