function [H,w,delta_w] = FreqResp(h,N)

% FreqResp      Calculate Frequency Response of FIR System Using N-point FFT
%
% Arguments:
% h             Impulse response of system
% N             FFT size, default N = 4096
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

if nargin < 2
    N =4096;          % Default FFT size
end

H = fft(h,N);         % Perform FFT of sequence in vector h
delta_w = 2*pi/N;     % Frequency resolution
w = (0:N-1)*delta_w;

