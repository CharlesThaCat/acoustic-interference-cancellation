function [en,S] = MSAFadapt_cllp(un,dn,S)

% MSAFadapt_cllp    Closed-Loop Implementation of Delayless Multiband-Structured SAF
%
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in MSAFinit.m
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);
[L,N] = size(S.analysis);
mu = S.step;
alpha = S.alpha;
AdaptStart = S.AdaptStart;
H = S.analysis;
F = S.synthesis;
w = S.coeffs; U = zeros(M,N);                   % For MSAF adaptation
u = zeros(M,1);                                 % Fullband tapped-delay line
a = zeros(L,1); A = zeros(L,N); e = zeros(L,1); % For analysis filtering

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
    
    a = [un(n); a(1:end-1)];                    % Update tapped-delay line of u(n)
    A = [a, A(:,1:end-1)];                      % Update buffer
    u = [un(n); u(1:end-1)];                    % Fullband input signal vector for 
                                                %   adaptive filter (open loop structure)
    en(n) = dn(n) - w'*u;                       % Error signal (open loop structure)
    e = [en(n); e(1:end-1)];
    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;              % System error norm (normalized)
    end
    
    if (mod(n,N)==0)                            % Tap-weight adaptation at decimated rate
        U1 = (H'*A)';                           % Partitioning u(n) 
        U2 = U(1:end-N,:);
        U = [U1', U2']';                        % Subband data matrix
        eD = H'*e;                              % Partioning fullband error signal
        if n >= AdaptStart
            w = w + U*(eD./(sum(U.*U)+alpha)')*mu;% Tap-weight adaptation
            S.iter = S.iter + 1;
        end
    end
                          
end

S.coeffs = w;
if ComputeEML == 1;
    S.eml = eml;
end


    
