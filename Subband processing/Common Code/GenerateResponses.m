function [un,dn,vn] = GenerateResponses(iter,b,seed,ARtype,SNR)

% GenerateResponses     Generate Input and Desired Responses
%
% Arguments:
% iter                  Number of samples in u(n)
% b                     Unknown system
% seed                  Seed for generating random numbers
% ARtype                Set ARtype = 1 for generating white noise
% SNR                   Set SNR = inf for noiseless signal
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

if nargin < 3
    seed = sum(100*clock);
    ARtype = 1;
    SNR = 40;
end

% Generate different AR signals

randn('state',seed);                                 % Reset generator to diffrent state
un = randn(1,iter);                                  % Gaussian distribution random signal
ARcoeffs(1).a = 1;                                   % White noise
ARcoeffs(2).a = [1; -0.1; -0.8];                     % AR(2), c.f. Figure 6.14(a)
ARcoeffs(3).a = [1; -1.6;  0.81];                    % AR(2), c.f. Figure 4.6
ARcoeffs(4).a = [5.3217; -9.2948;  7.0933; -2.8152;...
                 2.5805; -2.4230;  0.3747;  2.2628;...
                -0.3028; -1.7444;  1.1053];          % AR(10), c.f. Figure 6.17
ARcoeffs(5).a = [1.0000; -1.3193;  0.8610; -0.4541;...
                -0.6191;  0.9800; -0.6530;  0.5424;...
                 0.3694; -0.5102;  0.3673; -0.4017;...
                 0.0649; -0.1499;  0.1212;  0.1978]; % AR(15), c.f. Figure 3.3(a)

un = filter(1,ARcoeffs(ARtype).a,un);                % Generate AR signal

dn = filter(b,1,un);                                 % Generate desired response d(n)
dn = dn(length(b)+1:end);                            % Adjusting starting index of signals
un = un(length(b)+1:end);

% Normalization of u(n) and d(n)

un = un/std(dn);
dn = dn/std(dn);

% Add white noise with given SNR

rand('state',sum(100*clock));                        % Generate additive noise
vn = (rand(1,length(dn))-0.5)*sqrt(12*10^(-SNR/10)); % SNR in dB
dn = dn + vn;                                        % Mix signal with noise

