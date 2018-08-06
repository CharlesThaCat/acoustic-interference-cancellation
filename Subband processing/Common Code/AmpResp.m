function [Hr,w,theta] = AmpResp(h,FreqPoint,FreqRange,ShiftFreq)

% AmpResp           Calculate Amplitude Response of Symmetric FIR Filter
%
% Arguments:
% h                 Symmetric impulse response:
%                     Type I linear-phase FIR filter, L is odd
%                     Type II lienar-phase FIR fitler, L is even
% FreqPoint         Range of amplitude response from 0 to 2pi or -pi to pi
% FreqRange         FreqRange = 1, frequency range is from 0 to 2pi
%                             = 2, frequency range -pi to pi                            
% ShiftFreq         Freq shift of amplitude response with specified amount 
% Hr                Amplitude (zero-phase) response (column vectors)
%
% by Kong A. Lee, Feb 2005

% Check input argument values

if nargin <4; ShiftFreq = 0; end
if nargin <3; FreqRange = 1; end
if nargin <2; FreqPoint = 4096; end
 
h = h(:);                       % Make sure h is a column vector
L = length(h);                  % Length of filter

% Check selected frequency range

if FreqRange ==1
    w = (0:FreqPoint-1)*2*pi/FreqPoint;
elseif FreqRange ==2
    FreqPoint = FreqPoint/2;
    w = (-FreqPoint+1:1:FreqPoint-1)*pi/FreqPoint;
end

if mod(L,2)==1                  % L is an odd number
    
    alpha = (L-1)/2;
	a = [h(alpha + 1); 2*h(alpha:-1:1)];
	n = 0:alpha;
	Hr = cos((w + ShiftFreq)'*n)*a;
    
end

if mod(L,2)==0                  % L is an even number
    
    alpha = L/2;
    b = 2*h(alpha:-1:1);
    n = (1:alpha) - 0.5;
    Hr = cos((w + ShiftFreq)'*n)*b;
    
end
    
theta = -((L-1)/2)*w;