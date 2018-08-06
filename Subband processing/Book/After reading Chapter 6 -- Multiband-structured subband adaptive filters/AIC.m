clear; clc;
tic;
% [dn,fs1] = audioread('C:\Users\Xu\Desktop\ï¿½ï¿½×¿ï¿½ï¿½\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\001_2mplayback_1646-802.wav');
% [un,fs1] = audioread('x45.wav');
[x,fs1] = audioread('C:\Users\Xu\Desktop\ÁÖ×¿ÎÄ\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\001_2mplayback_1646-802.wav');
dn = x(:,1);
un = x(:,5);
% Arguments: 
% w0            Coefficients of FIR filter at start
% mu            Step size
% N             Number of subbands
% H             Analysis filter bank (optional), each column represents a filter
% F             Synthesis filter bank (optional), each column represents a filter
mu = 0.1;
N = 8;
L = 8*N;
w0 = zeros(L,1);
S = MSAFinit(w0,mu,N,L);
[en,S] = MSAFadapt_oplp(un,dn,S);
% result = un'-1*en;
% plot(dn'); hold on; plot(1*en);
% legend('dn','1 en')
toc;
soundsc(en,fs1);
pause;
clear sound
% audiowrite('4.wav',en,fs1);