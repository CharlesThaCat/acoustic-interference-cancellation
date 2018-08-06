function [H,F] = make_bank(p,N)

% make-bank     Generate Analysis Filter Bank using Cosine Modulation
%               Synthesis Filters are Time-reversed of Analysis Filters

% Arguments:
% p             Prototype filter (impulse response)
% N             Number of subbands

L = length(p);               % Length of prototype filter
H = zeros(N,L);              % Analysis filter bank

n = 0:L-1;                   % Time index

% See Eq. (2.35) for the algorithm

for i = 0:N-1
    H(i+1,:) = 2*p.*cos((pi/N)*(i+0.5)*(n-(L-1)/2)+ ((-1)^i)*(pi/4));
end

F = fliplr(H);               % Synthesis filter bank