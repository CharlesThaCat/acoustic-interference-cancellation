clear; clc;

%% DFT filter bank
N = 8;          % number of subbands
K = 16;         % overlapping factor
L = 2*K*N;      % length of analysis filters

hopt = fir1(L-1,1/N);       % prototype filter
[H,F] = make_bank_DFT(hopt,N);
H = sqrt(N)*H;                    % analysis section
F = sqrt(N)*F;                    % synthesis section

%% signals in the DFT filter bank
xn = sin(2*pi*0.01*(0:1000));
ITER = length(xn);
yn = zeros(ITER,1);
x = zeros(length(H),1);
b = zeros(length(F),1);

%% analysis and synthesis filter banks implementation
for n = 1:ITER
    x = [xn(n); x(1:end-1)];
    % block transformation is performed once for every N input samples
    if mod(n,N) == 0
        x_D = H.'*x;
        % =====================
        % insert subband processing here
        % =====================
        b = F*x_D + b;
    end
    yn(n) = real(b(1));
    b = [b(2:end); 0];
end

%% plot input and output signal
figure;
plot(0:length(xn)-1, xn); hold on;
plot(0:length(yn)-1, yn, 'r:');
xlabel('Time index, n'); ylabel('Amplitude');


%{
 %% plot frequency response
DFTpoint = 4096;
[Hz,w] = FreqResp(H, DFTpoint); 
Hz = Hz.';
figure;
subplot(3,1,[1 2]); hold on;
for k = 1:N
    if mod(k,2) == 0
        plot(w/pi,20*log10(abs(Hz(k,:))));
    else
        plot(w/pi,20*log10(abs(Hz(k,:))),':');
    end
end
title('frequency response'); 
%}
