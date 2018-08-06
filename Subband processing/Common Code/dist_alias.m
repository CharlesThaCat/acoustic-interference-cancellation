function dist_alias(H,G,nband)

% dist_alias        Calculate and Plot Distortion and Aliasing of Filter Banks
%
% Arguments:
% H                 Impulse responses of analysis filter
% G                 Impulse responses of synthesis filter
% nband             Number of subbands
%
% Reference:        N.J. Fliege, Multirate Digital Signal Processing, Wiley 1994
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

N = length(H);                  % Length of prototype filter

A = zeros(nband,2*N-1);
for m=0:nband-1
     for k=0:nband-1
        A(m+1,:)=A(m+1,:)+conv(H(k+1,:).*exp(-i*[0:N-1]*2*pi*m/nband),G(k+1,:));
     end
end

A0 = zeros(1,1024);
for m=2:nband         
    A0=A0+(abs(fft(A(m,:),1024))/nband).^2; 
end
A0 = sqrt(A0);

% Plot the distortion function

figure; 
subplot(211);
% N1=256;
DFTpoint = 4096;
[h,w] = FreqResp(A(1,:),DFTpoint);
% [h,w]=freqz(A(1,:),1,N1*nband/2); 
plot(w/pi,10*log10(abs(h)));
xlabel('Frequency,\omega (\pi)'); ylabel('Amplitude distortion (dB)');
title('Distortion plot');
xlim([0 1]);

% Plot the total aliasing distortion

subplot(212);
plot([0:1/512:1],A0(1:513));
xlabel('Frequency,\omega (\pi)'); ylabel('Aliasing error');
title('Total aliasing distortion as shown in (7.22) in Fliege book');
