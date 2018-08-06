clear; clc;
tic;
% [dn,fs1] = audioread('C:\Users\Xu\Desktop\��׿��\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\001_2mplayback_1646-802.wav');
% [un,fs1] = audioread('x45.wav');
[x,fs1] = audioread('C:\Users\Xu\Desktop\��׿��\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\015_2mplayback_1646-802.wav');
dn = x(:,4);
un = x(:,5);
% Arguments: 
% w0               Coefficients of FIR filter at start
% mu               Step size
% N                Number of subbands
% L                length of analysis filter
% M                length of adaptive weight vector
% H                Analysis filter bank (optional), each column represents a filter
% F                Synthesis filter bank (optional), each column represents a filter
% alpha            Adjust scaling of tap weights 
% delta            Small constant
M = 512;
w0 = zeros(M,1);
mu = 0.5;
N = 8;
L = 512;
alpha = 1;
delta = 0.0001;
S = PMSAFinit(w0,mu,N,L,alpha,delta)
[en,S] = PMSAFadapt(un,dn,S);
% % result = un'-1*en;
% % plot(dn'); hold on; plot(1*en);
% % legend('dn','1 en')
toc;
soundsc(en,fs1);
pause;
clear sound
% audiowrite('4.wav',en,fs1);