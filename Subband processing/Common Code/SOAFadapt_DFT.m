function [yn,en,S] = SOAFadapt_DFT(un,dn,S)

% SOAFadapt_DFT     Adaptive FIR Filtering Using the SOAF-LMS (DFT) Algorithm
%
%                   The history of output, squared error and coefficients 
%                   of FIR filter are passed to calling function
%
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in SOAFinit.m
% yn                History of output signal
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);               % Length of FIR filter
mu = S.step;                        % Step size
leak = S.leakage;                   % Leaky factor of leaky NLMS algorithm
AdaptStart = S.AdaptStart;
w = S.coeffs + 1i*S.coeffs;         % Weight vector of FIR filter
u = zeros(M,1)+ 1i*zeros(M,1);      % Initialize input signal vector
U = zeros(M,1) + 1i*zeros(M,1);
power_vec = zeros(M,1);             % Initialize power in each bin
ITER = length(un);                  % Length of input sequence
yn = zeros(1,ITER);                 % Initialize output sequence to zero
en = zeros(1,ITER);                 % Initialize error sequence to zero
T = dftmtx(M);
if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_Tb = norm(T*b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER    
    u = [un(n); u(1:end-1)];        % Input signal vector [u(n),u(n-1),...,u(n-M+1)]'
    U = T*u;                        % Transformed input vector. Try dftmtx(n)
    yn(n) = conj(w')*U;
    power_vec= (1-S.beta)*power_vec+S.beta*(conj(U).*U);	
    inv_sqrt_power = 1./(sqrt(power_vec+(0.00001.*ones(M,1))));
    en(n) = dn(n) - yn(n);          % Estimation error
    if ComputeEML == 1;
        eml(n) = norm(T*b-w)/norm_Tb; % System error norm (normalized)
    end
    if n >= AdaptStart
        w = w + (mu*inv_sqrt_power).*(en(n)*conj(U)); % Tap-weight adaptation
        S.iter = S.iter + 1;
    end
end

S.coeffs = real(w);                   % Coefficient values at the final iteration
if ComputeEML == 1;
    S.eml = eml;
end


