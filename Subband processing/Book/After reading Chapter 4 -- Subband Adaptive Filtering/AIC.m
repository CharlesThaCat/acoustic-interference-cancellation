clear; clc;
tic;
% [dn,fs1] = audioread('C:\Users\Xu\Desktop\林卓文\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\001_2mplayback_1646-802.wav');
% [un,fs1] = audioread('x45.wav');
[x,fs1] = audioread('C:\Users\Xu\Desktop\林卓文\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\001_2mplayback_1646-802.wav');
dn = x(:,1);
un = x(:,5);
% Arguments:
% M             Length of corresponding fullband filter
% mu            Step size
% N             Number of subbands
% D             Decimation factor, D=N (Critical decimation), D<N (oversampling)
M = 512;
mu = 0.5;
N = 8;
D = N;
L = 256;
S = SAFinit(M,mu,N,D,L);
[en,S] = SAFadapt(un,dn,S);
% % result = un'-1*en;
% % plot(dn'); hold on; plot(1*en);
% % legend('dn','1 en')
toc;
soundsc(en,fs1);
pause;
clear sound
% audiowrite('4.wav',en,fs1);