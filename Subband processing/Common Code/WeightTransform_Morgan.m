function w = WeightTransform_Morgan(W,N,D,Ms)

% WeightTransform_Morgan    Mapping of Subband Adaptive Filters Coefficients to 
%                           Full-band Filter
%
% Weight transformation by Morgan and Thi (See Section 4.4.3.1)
%
% Arguments:
% W            Tap-weights for subbands i = 0,1,...,(N/2) in each column
% N            Number of subbands
% Ms           Length of adaptive subfilters
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

w = zeros(Ms*D,1);                    % Setup fullband weight vector

Ms = Ms*2;                            % Zero padding
G = fft(W,Ms);                        % Ms-point FFT on (N/2)+1 adaptive subfilters

% Weight trasformation for 2x-oversampling

if D == N/2                           % For 2x-oversampling
    
% or subband from i = 1,2,...,(N/2)-1, where i is the subband index

    X = zeros(Ms/2,N/2-1);
	for i = 1:2:(N/2-1)           % For i is an odd number
        x = reshape(G(:,i+1),Ms/4,4);
        x = [x(:,2); x(:,3)];
        X(:,i) = x;  
	end
	for i = 2:2:(N/2-1)           % For i is an even number
        x = reshape(G(:,i+1),Ms/4,4);
        x = [x(:,4); x(:,1)];
        X(:,i) = x;  
	end
    X = X(:);

    i = 0;   x = reshape(G(:,i+1),Ms/4,4); X = [x(:,1); X];
    
    i = N/2;
    if mod(i,2)==0                    % For N/2 is even, eg. N = 8, 16 subbanbs
        x = reshape(G(:,i+1),Ms/4,4); X = [X; x(:,4)];
    else                              % For N/2 is odd, eg. N = 10 subbands
        x = reshape(G(:,i+1),Ms/4,4); X = [X; x(:,2)];
    end       
    
    X = [X; 0; conj(flipud(X(2:end)))];
    x = real(ifft(X));                % Ms*D-point ifft
    w = x(1:(Ms/2)*D);
    
end

% Weight trasformation for critical subsampling

if D == N                             % if critical subsampling
    
% For subbands from i = 1,2,...,(N/2)-1, where i is the subband index

    X = zeros(Ms,N/2-1);
	for i = 1:(N/2-1)                
        x = reshape(G(:,i+1),Ms/2,2);
        x = [x(:,2); x(:,1)];
        X(:,i) = x;  
	end
    X = X(:);

    i = 0;   x = reshape(G(:,i+1),Ms/2,2); X = [x(:,1); X];
    i = N/2; x = reshape(G(:,i+1),Ms/2,2); X = [X; x(:,2)];
    
    X = [X; 0; conj(flipud(X(2:end)))];
    x = real(ifft(X));                % Ms*D-point ifft
    w = x(1:(Ms/2)*D);
    
end