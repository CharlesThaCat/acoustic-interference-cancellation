clear; clc;
%% Usable filters
% LMS, RLS, AffineProjection, FastTransversal, AdaptiveLattice
%% desired signal
% n = (1:1000)';
% s = sin(0.075*pi*n);

%% noise signal
% v = 0.8*randn(1000,1); % Random noise part.
% ar = [1,1/2];          % Autoregression coefficients.
% v1 = filter(1,ar,v);   % Noise signal. Applies a 1-D digital filter.

%% primary input (noise corrupted signal)
% x = s + v1;
[x,fs1] = audioread('x21.wav');

%% reference input 
% ma = [1, -0.8, 0.4 , -0.2];
% v2 = filter(ma,1,v);
[v2,fs1] = audioread('x25.wav');

%% adaptive filter
% initialization
L = 1024;
alf = dsp.AdaptiveLatticeFilter(L,'Method','Least-squares Lattice','ForgettingFactor',1);
[y,err] = alf(v2,x);

% filter step size
% [y,e] = step(rlsFilt,v2,x);
% nlms.StepSize = mumaxmsenlms/6; 

%% plot
% primary input
% plot(n(900:end),x(900:end),'k:')
% xlabel('Time index (n)');
% ylabel('Amplitude');
plot([1:length(x)], x, 'm:')
xlabel('Time index (n)');
ylabel('Amplitude');

% denoised result
hold on;
% plot(n(900:end),[ew(900:end), elms(900:end),enlms(900:end)]);
% legend('Wiener filter denoised sinusoid',...
%     'LMS denoised sinusoid','NLMS denoised sinusoid');
% xlabel('Time index (n)');
% ylabel('Amplitude');
plot([1:length(x)], err);
xlabel('Time index (n)');
ylabel('Amplitude');
legend('primary input','denoised result');
hold off;

%% reset nlms
reset(alf);