function [xd,w,XD] = PSDecimation(X,DFTpoint,D)

% PSDecimation      Decimation of Power Density Spectrum
%
% Arguments:
% X                 Power spectrum from 0 to 2pi, real function of w
% DFTpoint          DFT size
% D                 Decimation factor, D >= 1,
%                     (D = 1 indicates no decimation)
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

delta_w = 2*pi/DFTpoint;           % Frequency resolution
XD = zeros(D,DFTpoint);

k = 0;
while k <= D-1
    N = round((2*pi*k/D)/delta_w); % number of points to be shifted
                                   %   corresponding to (2*pi*k)/D
    x = X; n = 0;                  % Frequency response to be shifted   
    while n < N
        x = [x(end) x(1:end-1)];
        n = n + 1;
    end
    XD(k+1,:) = x;
    k = k + 1;
end

Npoint = round(DFTpoint/D);
Npoint = floor(Npoint/4)*4;
XD = XD(:,1:Npoint)/D;             % Stretch the frequency response
xd = sum(XD,1);                    % Sum the frequency shifted versions

delta_w = 2*pi/Npoint;
w = (0:Npoint-1)*delta_w;
