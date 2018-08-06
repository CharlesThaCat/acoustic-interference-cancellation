function [en,S] = SAFadapt(un,dn,S)

% SAFadapt          Subband Adaptive Filter
%
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in MSAFinit.m
% en                History of error signal

[L,N] = size(S.analysis);
D = S.decfac;
mu = S.step;
alpha = S.alpha;
AdaptStart = S.AdaptStart;
H = S.analysis;
F = S.synthesis;
W = S.coeffs;                 % Adaptive subfilters
U = zeros(size(W));           % Tapped-delay lines of adaptive subfilters
H = H(:,1:N/2+1);             % Analysis filter (only the first N/2+1 are taken)
x = zeros(L,1);               % Tapped-delay line of input signal (Analysis FB)
y = zeros(L,1);               % Tapped-delay line of desired response (Analysis FB)
z = zeros(L,1);               % Tapped-delay line of error signal (Synthesis FB)

ITER = length(un);
en = zeros(1,ITER);

for n = 1:ITER
    x = [un(n); x(1:end-1)];  % Fullband input vector for band partitioning
    y = [dn(n); y(1:end-1)];  % Fullband desired response vector for band partitioning
    
    if (mod(n-1,D)==0)              % Tap-weight adaptation at lowest sampling rate
        U = [x'*H; U(1:end-1,:)];   % Each columns hold a subband regression vector
        dD = y'*H;                  % Row vector, each element is decimated desired signal
        eD = dD - sum(U.*W);
        if n >= AdaptStart
            W = W + conj(U)*diag(eD./(sum(U.*conj(U))+alpha))*mu;
            S.iter = S.iter + 1;
        end
        eD = [eD, conj(fliplr(eD(2:end-1)))].'; 
        z = F*eD + z;                                       
    end
    en(n) = real(z(1)); 
    z = [z(2:end); 0];
                   
end

en = en(1:ITER);
S.coeffs = W;


    
