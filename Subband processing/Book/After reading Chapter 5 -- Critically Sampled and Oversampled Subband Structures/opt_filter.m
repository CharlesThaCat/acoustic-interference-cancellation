function [p,passedge] = opt_filter(filtorder,N)

% opt_filter      Create Lowpass Prototype Filter for the Pseudo-QMF 
%                 Filter Bank with N Subbands
%
% Adapted from the paper by C. D. Creusere and S. K. Mitra, titled 
%   "A simple method for designing high-quality prototype filters for 
%   M-band pseudo-QMF banks," IEEE Trans. Signal Processing,vol. 43, 
%   pp. 1005-1007, Apr. 1995 and the book by S. K. Mitra titled "
%   Digital Signal Processing: A Computer-Based Approach, McGraw-Hill, 2001
%
% Arguments:
% filtorder     Filter order (i.e., filter length - 1)
% N             Number of subbands

stopedge = 1/N;       % Stopband edge fixed at (1/N)pi
passedge = 1/(4*N);   % Start value for passband edge
tol = 0.000001;       % Tolerance
step = 0.1*passedge;  % Step size for searching the passband edge
way = -1;             % Search direction, increase or reduce the passband edge
tcost = 0;            % Current error calculated with the cost function
pcost = 10;           % Previous error calculated with the cost function
flag = 0;             % Set to 1 to stop the search

while flag == 0
    
% Design the lowpass filter using Parks-McClellan algorithm
 
    p = remez(filtorder,[0,passedge,stopedge,1],[1,1,0,0],[5,1]);
    
% Calculates the cost function according to Eq. (2.36)

    P = fft(p,4096);
    OptRange = floor(2048/N);           % 0 to pi/N
    phi = zeros(OptRange,1);            % Initialize to zeros

% Compute the flatness in the range from 0 to pi/N

	for k = 1:OptRange
          phi(k) = abs(P(OptRange-k+2))^2 + abs(P(k))^2;
	end
	tcost = max(abs(phi - ones(max(size(phi)),1)));
   	
	if tcost > pcost                % If search in wrong direction
		step = step/2;          % Reduce step size by half 
		way = -way;             % Change the search direction 
	end
	
	if abs(pcost - tcost) < tol     % If improvement is below tol         
		flag = 1;               % Stop the search                    
	end
	
	pcost = tcost;
	passedge = passedge + way*step; % Adjust the passband edge
   
end

