clear; clc;
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
lms = dsp.LMSFilter(L,'Method','LMS');
nlms = dsp.LMSFilter(L,'Method','Normalized LMS');
% filter step size
[mumaxlms,mumaxmselms]   = maxstep(lms,x);
[mumaxnlms,mumaxmsenlms] = maxstep(nlms,x); % maxstep function of dsp.LMSFilter
lms.StepSize  = mumaxmselms/30; 
nlms.StepSize = mumaxmsenlms/20; 

%% filter with the adaptive filter
[ylms,elms,wlms] = lms(v2,x);
[ynlms,enlms,wnlms] = nlms(v2,x);

%% compute the optimal solution (FIR Wiener filter)
bw = firwiener(L-1,v2,x); % Optimal FIR Wiener filter
yw = filter(bw,1,v2);   % Estimate of x using Wiener filter
ew = x - yw;            % Estimate of actual sinusoid

%% plot
% denoised result
% plot(n(900:end),[ew(900:end), elms(900:end),enlms(900:end)]);
% legend('Wiener filter denoised sinusoid',...
%     'LMS denoised sinusoid','NLMS denoised sinusoid');
% xlabel('Time index (n)');
% ylabel('Amplitude');
plot([1:length(x)], [ew, elms, enlms]);
legend('Wiener filter denoised sinusoid',...
    'LMS denoised sinusoid','NLMS denoised sinusoid');
xlabel('Time index (n)');
ylabel('Amplitude');
% primary input
hold on
% plot(n(900:end),x(900:end),'k:')
% xlabel('Time index (n)');
% ylabel('Amplitude');
plot([1:length(x)], x, 'k:')
xlabel('Time index (n)');
ylabel('Amplitude');
hold off

%% convergence investigation through learning curve

%% reset nlms
reset(nlms);