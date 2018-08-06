function C = DCTmatrix_TypeIV(N)

% DCTmatrix_TypeIV     Construct an N-by-N Type-IV DCT Matrix
%
%                      Each Column of Matrix Is a Basis Function
%
% by K.A. Lee, Dec. 2003

n = (0:N-1)';
C = zeros(0,0);        % Initialize to zero matrix

for k = 0:N-1          % Generate DCT matrix
	c = sqrt(2/N)*cos((pi/N)*(k+0.5)*(n+0.5));
	C = [C c];
end
    
