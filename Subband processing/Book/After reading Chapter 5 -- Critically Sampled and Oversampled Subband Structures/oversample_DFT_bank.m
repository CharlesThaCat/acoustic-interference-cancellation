clear; clc;
%% define parameter values
Fs = 8000;
Rp = 1;
Rs = 60;
L = 127;
wc = 1/6;
%% prototype filter
b_os = fir1(L,wc,chebwin(L+1,Rs));
figure;
freqz(b_os);
title('frequency response of prototype filter (oversampled)');

nbands = 8;
D = 6;
len = length(b_os);
[H,G] = make_bank_DFT(b_os,nbands);
H = sqrt(D)*H;
G = sqrt(D)*G;