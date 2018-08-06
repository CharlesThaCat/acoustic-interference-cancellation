function [en,S] = PMSAFadapt(un,dn,S)

% PMSAFadapt        Proportionate Multiband-Structured Subband Adaptive Filter (PMSAF)
%
% Parameters:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in MSAFinit.m
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);                              % Length of adaptive weight vector
[L,N] = size(S.analysis);                          % Number and subbands and length 
                                                   %  of analysis filter
mu = S.step;                                       % Step size of PMSAF algorithm
alpha = S.alpha;                                   % Scaling for coefficients
delta = S.delta;                                   % Small constant
AdaptStart = S.AdaptStart;
H = S.analysis;                                    % Analysis filter
F = S.synthesis;                                   % Synthesis filter
w = S.coeffs; U = zeros(M,N);                      % Initizlize adaptive filtering
a = zeros(L,1); d = zeros(L,1); 
A = zeros(L,N);                                    % Initialize analysis filtering
z = zeros(L,1);                                    % Initialize synthesis filtering

ITER = length(un);
en = zeros(1,ITER);

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    UDerr = zeros(1,ITER);
    ComputeEML = 1;
    u = zeros(M,1);
else
    ComputeEML = 0;
end

for n = 1:ITER
    d = [dn(n); d(1:end-1)];                       % Update tapped-delay line of d(n)
    a = [un(n); a(1:end-1)];                       % Update tapped-delay line of u(n)
    A = [a, A(:,1:end-1)];                         % Update buffer
    if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;                 % System error norm (normalized)
        u = [un(n); u(1:end-1)];
        UDerr(n) = (b-w)'*u;                       % Undisturbed error 
    end
    
    if (mod(n,N)==0)                               % Tap-weight adaptation at decimated rate
        U1 = (H'*A)';                              % Partitioning u(n) 
        U2 = U(1:end-N,:);
        U = [U1', U2']';                           % Subband data matrix
        dD = H'*d;                                 % Partitioning d(n) 
        eD = dD - U'*w;                            % Error estimation
        if n >= AdaptStart
            g = (1-alpha)/(2*M) + abs(w)*(1+alpha)/(2*sum(abs(w))+1e-4);
            G = repmat(g,1,N);
            w = w + (U.*G)*(eD./(sum(U.*G.*U)+delta)')*mu;
            S.iter = S.iter + 1;
        end
        z = F*eD + z;                                       
        en(n-N+1:n) = z(1:N); 
        z = [z(N+1:end); zeros(N,1)];
    end                       
end

S.coeffs = w;
if ComputeEML == 1;
    S.eml = eml;
    S.UDerr = UDerr;
end

