function [H,F] = make_bank_DFT(p,N)

% make_bank_DFT     Generate DFT Filter Bank with N Subbands
%
% Arguments:
% p                 Prototype filter (impulse response)
% N                 Number of subbands
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd


p = p(:);                            % Make column
flen = max(size(p));                 % Length of prototype filter
H = zeros(flen,N/2+1);               % Assume N is an even number
n = (0:flen-1)';

k = 0; H(:,k+1) = p;                 % i = 0
k = N/2; H(:,k+1) = p.*((-1).^n);    % i = N/2+1  

% in DFT filter bank, for real-valued signals, only the first N/2+1 subbands need to be processed
for k = 1:(N/2-1)
    H(:,k+1) = p.*exp(j*2*pi/N*k*n); % Complex modulation
end

D = H(:,2:N/2);
H = [H, conj(fliplr(D))];            % Complex-conjugate pair

% Synthesis filters are the same as the analysis filters

F = H;
