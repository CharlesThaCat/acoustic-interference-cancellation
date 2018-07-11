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
[x,fs1] = audioread('x41.wav');

%% reference input 
% ma = [1, -0.8, 0.4 , -0.2];
% v2 = filter(ma,1,v);
[v2,fs1] = audioread('x45.wav');

%% adaptive filter
% initialization
L = 512;
% lms = dsp.LMSFilter(L,'Method','LMS');
nlms = dsp.LMSFilter(L,'Method','Normalized LMS','LeakageFactor',1,'AdaptInputPort',false,...
'WeightsResetInputPort',false,'WeightsOutput','Last');
% filter step size
% [mumaxlms,mumaxmselms]   = maxstep(lms,x);
[mumaxnlms,mumaxmsenlms] = maxstep(nlms,x); % maxstep function of dsp.LMSFilter
% lms.StepSize  = mumaxmselms/30; 
nlms.StepSize = mumaxmsenlms/6; 

%% filter with the adaptive filter
% [ylms,elms,wlms] = lms(v2,x);
[ynlms,enlms,wnlms] = nlms(v2,x);

%% compute the optimal solution (FIR Wiener filter)
% bw = firwiener(L-1,v2,x); % Optimal FIR Wiener filter
% yw = filter(bw,1,v2);   % Estimate of x using Wiener filter
% ew = x - yw;            % Estimate of actual sinusoid

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
plot([1:length(x)], enlms);
xlabel('Time index (n)');
ylabel('Amplitude');
legend('primary input','denoised result');
hold off;

%% reset nlms
reset(nlms);

%% convergence investigation through learning curve
% M = 10; % Decimation factor
% msenlms = msesim(nlms,v2,x,M);
% figure;
% plot(1:M:x(end),msenlms)
% legend('LMS learning curve','NLMS learning curve')
% xlabel('Time index (n)');
% ylabel('MSE');

%% theorectical learning curves
% reset(nlms);
% figure;
% [mmselms,emselms,meanwlms,pmselms] = msepred(nlms,v2,x,M);
% plot(1:M:x(end),[mmselms*ones(500,1),emselms*ones(500,1),...
%         pmselms,mselms])
% legend('MMSE','EMSE','predicted LMS learning curve',...
%     'LMS learning curve')
% xlabel('Time index (n)');
% ylabel('MSE');