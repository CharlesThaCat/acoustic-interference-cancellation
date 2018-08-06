function [H,G] = make_bank_3(h,nbands)

% make_bank_3      Creates Analysis/Synthesis Filters for Pseudo-QMF Filter Banks
%                  
%                  Standard type of cosine modulation where the phase reference is (L-1)/2
% Arguments:
% h                Impulse response of prototype filter
% ndands           Number of subbands
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

flen = max(size(h));
H = zeros(nbands,flen);

% Note: k starts from 1, thus (k-0.5) and (k-1) in the cosine modulations 

n = 0:flen-1;
for k=1:nbands
    H(k,:) = h.*cos((pi/nbands)*(k-0.5)*(n-(flen-1)/2)+ (pi/2)*(k+0.5)*(flen-1-nbands)/nbands)*2;
end

% Synthesis filters are time-reversed versions of the analysis filters

% Gk(z) = z^(-L+1)H(z^-1)
G = fliplr(H);