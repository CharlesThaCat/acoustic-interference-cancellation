function S = DSAFinit_Morgan(M,mu,N,J)

% DSAFinit_Morgan   Initialize Parameter Structure for the Delayless
%                   Subband Adaptive Filter Proposed by Morgan and Thi
% Arguments:
% M                 Length of corresponding fullband filter
% mu                Step size
% N                 Number of subbands
% J                 Update rate, typically in the range 1 to 8
%
% Subband Adaptive Filtering: Theory and Implementation
% by Lee, Gan, and Kuo, 2008
% Publisher: John Wiley and Sons, Ltd

D = N/2;                            % 2x oversampling (recommended)
OverFac = 4;                        % Overlapping factor (Try other integer values)
L = 2*OverFac*N-1;                  % Length of analysis filters, L = 2KN-1

% DFT filter bank with fractional delay (see Section 4.4.3.2)

wc = 1/N;                           % Cut-off frequency
hopt = fir1(L-1,wc);                % Generate prototype filter
[H,F] = make_bank_DFT(hopt,N);      % Complex modulation

% Assign structure fields
S.FULLcoeffs    = zeros(M,1);       % Fullband adaptive filter
S.SUBcoeffs     = zeros(M/D,N/2+1); % Adaptive subfilters (initialized to zeros)
                                    %  consider only the first N/2 + 1 subfilters
S.step          = mu;               % Step size
S.decfac        = D;                % Decimation factor
S.analysis      = H;                % Analysis filter bank
S.synthesis     = F;                % Synthesis filter bank
S.iter          = 0;                % Iteration count
S.alpha         = 1e-4;             % Small positive constant
S.AdaptStart    = L + M;            % Running effect of the analysis and adaptive filter, minimum L+M
S.UpdateRate    = round(M/J);       % J is typically in the range 1 to 8


                     
