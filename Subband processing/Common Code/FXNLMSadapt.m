function [yn,en,S] = FXNLMSadapt(un,dn,S)

% FXNLMSadapt       Normalized FXLMS Algorithm 
%
%                   Perform over the entire length of the input sequence. The
%                   history of output, square error and coefficients of FIR 
%                   filters are passed out to extenal
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in NLMSinit.m
% yn                History of output signal
% en                History of error signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = length(S.coeffs);                     % Length of input sequence
mu = S.step;                              % Step size of NLMS algorithm (between 0 and 2)
leak = S.leakage;                         % Leaky factor for leaky LMS algorithm
alpha = S.alpha;                          % Small constant
AdaptStart = S.AdaptStart;
w = S.coeffs;                             % Coefficients of FIR filter
u = zeros(M,1); 
fu = zeros(M,1);

ITER = length(un);                        % Length of input sequence
yn = zeros(1,ITER);                       % Initialize output sequence to zero
en = zeros(1,ITER);                       % Initialize error sequence to zero
%filt_un = zeros(1,ITER);                 % Initialize filtered input to zero
%est_filt_un = zeros(1,ITER);             % Initialize filtered input to zero (est)
filt_un = filter(S.sec_num,S.sec_den,un); % Filtered input 
est_filt_un = filter(S.estsec,1,un);      % Filtered input (est)

if isfield(S,'unknownsys')
    b = S.unknownsys;
    norm_b = norm(b);
    eml = zeros(1,ITER);
    ComputeEML = 1;
else
    ComputeEML = 0;
end

for n = 1:ITER  
   u = [filt_un(n); u(1:end-1)];          % Input signal vector (through the actual 
                                          %   secondary path)
   fu = [est_filt_un(n); fu(1:end-1)];    % Filtered input signal vector (through 
                                          %   the estimated secondary path)
   yn(n) = w'*u;                          % Inner product of filter coefficients and 
                                          %   tappd delay line 
   en(n) = dn(n)-yn(n);                   % Compute error signal
   if ComputeEML == 1;
        eml(n) = norm(b-w)/norm_b;        % System error norm (normalized)
   end
   if n >= AdaptStart
        w = (1-mu*leak)*w + ((mu*en(n))/(fu'*fu+alpha))*fu;     
                                          % LMS algorithm in leaky mode
        S.iter = S.iter + 1;
   end     
end

S.coeffs = w;                             % Coefficient values at the final iteration
if ComputeEML == 1;
    S.eml = eml;
end

