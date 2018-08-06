function [en,S] = DSAFadapt_Morgan_cllp(un,dn,S)

% DSAFadapt_Morgan_cllp     Closed-Loop Delayless Subband Adaptive Filter Using the 
%                           Weight Transformation Proposed by Morgan and Thi (Section 4.4.3.1)
% Arguments: 
% un                        Input signal
% dn                        Desired signal
% S                         Adptive filter parameters as defined in MSAFinit.m
% en                        History of error signal
%
% Note:     Only N is even is implemented, where the conjugate symmetric of H_i(z)
%           and H_{N-1}(z) is exploited!!!
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.FULLcoeffs);
Ms = size(S.SUBcoeffs,1);
[L,N] = size(S.analysis);
D = S.decfac;
mu = S.step;
alpha = S.alpha;
AdaptStart = S.AdaptStart;
UpdateRate = S.UpdateRate;
H = S.analysis;
F = S.synthesis;
W = S.SUBcoeffs;                   % Adaptive subfilters
U = zeros(size(W));                % Tapped-delay lines of adaptive subfilters
w = S.FULLcoeffs;                  % Fullband adaptive filter 
u = zeros(M,1);                    % Fullband tap-input vector
H = H(:,1:N/2+1);                  % Analysis filter (only the filrst N/2+1 is taken)
x = zeros(L,1);                    % Tapped-delay line of input signal (Analysis FB)
e = zeros(L,1);                    % Tapped-delay line of error signal (Analysis FB)

ITER = length(un);
en = zeros(1,ITER);

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER
    x = [un(n); x(1:end-1)];       % Fullband input vector for subband filtering
    u = [un(n); u(1:end-1)];

    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b; % System error norm (normalized)
    end

    en(n) = dn(n) - w.'*u;         % Error signal (open loop structure)
    e = [en(n); e(1:end-1)];

    if (mod(n-1,D)==0)             % Tap-weight adaptation at lowest sampling rate
        U = [x.'*H; U(1:end-1,:)]; % Each colums hold a subband regression vector
        eD = e.'*H;                % Row vector, each element is subband estimtion error
        if n >= AdaptStart
            W = W + conj(U)*diag(eD./(sum(U.*conj(U))+alpha))*mu;
            S.iter = S.iter + 1;
        end
    end
    if (n >= AdaptStart)& (mod(n-1,UpdateRate)==0)
        w = WeightTransform_Morgan(W,N,D,Ms);               
                                   % Weight transformation (modified Morgan's method)
    end
end

S.FULLcoeffs = w;
S.SUBcoeffs = W;
if ComputeEML == 1;
    S.eml = eml;
end



    
