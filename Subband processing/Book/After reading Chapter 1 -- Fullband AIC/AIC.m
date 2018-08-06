% Adaptive Interference Canceller
clear; clc;
[x,fs1] = audioread('C:\Users\Xu\Desktop\ÁÖ×¿ÎÄ\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\001_2mplayback_1646-802.wav');
dn = x(:,1);
noise = x(:,5);
% [dn,fs1] = audioread('x31.wav');         % extract signal+noise file
% [noise,fs1] = audioread('x35.wav');     % extract noise file
un = noise;                             % input signal to adaptive filter
M = 512;                                % filter length
w0 = zeros(M,1);                        % initialize coefs to 0
mu = 0.4;                               % step size
alpha = 0.0001;                         % a small constant

%% perform adaptive filtering using NLMS algorithm
S = NLMSinit(w0,mu,alpha);              % initialization
% S.unknownsys = b;
[yn,en,S] = NLMSadapt(un,dn,S);         % perform NLMS algorithm
soundsc(en,fs1);
pause;
clear sound;