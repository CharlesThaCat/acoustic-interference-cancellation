function S = DSAFinit_Merched(M,mu,N,J)

% DSAFinit_Merched   Initialize Parameter Structure for the Delayless Subband Adaptive Filter 
%                    Proposed by Merched et al.
% Arguments:
% M                 Length of corresponding fullband filter
% mu                Stepsize
% N                 Number of subbands
% J                 Update rate, typically in the range 1 to 8
%
% Subband Adaptive Filtering: Theory and Implementation
% by Lee, Gan, and Kuo, 2008
% Publisher: John Wiley and Sons, Ltd

D = N;                                % Crtical decimation (recommended)
OverFac = 4;                          % Overlapping factor (Try other integer values)
L = 2*OverFac*N-1;                    % Length of analysis filters, L = 2KN-1

% DFT filter bank with fractional delay (see Section 4.4.3.2)

wc = 1/N;                             % Cut-off frequency
hopt = fir1(L-1,wc);                  % Generate prototype filter
hopt = hopt/max(hopt);                % Note: it is necessary to have normalization such that 
                                      %  lowpass filter have its middle sample equal to 1       
% Polyphase decomposition

h = [hopt, 0];                        % Zero-padding (so that reshape function can be used)
E = reshape(h,N,length(h)/N);         % Each row represent a polyphase component
Dint = OverFac-1;                     % Integer part of fractional delay (delta_int in Section 4.4.3.2)
[H,F] = make_bank_DFT(hopt,N);        % Complex modulation

% Assign structure fields

S.FULLcoeffs    = zeros(M,1);         % Fullband adaptive filter
S.SUBcoeffs     = zeros(M/D+1,N/2+1); % Adaptive subfilters (initialized to zeros). Consider only the 
                                      % first N/2 + 1 subfilters with length (M/D+1), extra 1 sample
S.step          = mu;                 % Step size
S.decfac        = D;                  % Decimation factor
S.analysis      = H;                  % Analysis filter bank
S.Polyphase     = E;                  % Polyphase representation of analysis filter bank
S.Dint          = Dint;
S.synthesis     = F;                  % Synthesis filter bank
S.iter          = 0;                  % Iteration count
S.alpha         = 1e-4;               % Small positive constant
S.AdaptStart    = L + M;              % Running effect of the analysis and adaptive filter, minimum L+M
S.UpdateRate    = round(M/J);         % J is typically in the range 1 to 8


                     
