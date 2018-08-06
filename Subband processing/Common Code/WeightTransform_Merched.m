function w = WeightTransform_Merched(W,E,Dint,N,M)

% WeightTransform_Merched    Mapping of Subband Adaptive Filters Coefficients 
%                            to Full-band Filter
%
% Weight trnasformation by Merched, Diniz, and Petraglia (see Section 4.4.3.2)
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

W = [W, conj(fliplr(W(:,2:end-1)))];
W = W.';
Wp = real(ifft(W,N));

G = zeros(N,M/N);

G(1,:) = Wp(1,1:M/N);                % Discard the last sample
for m = 2:N
    aux = conv(E(m-1,:),Wp(m,:));    % Filtering by subfilters with polyphase  
                                     %   components of the analysis filter
    G(m,:) = aux(Dint+2:Dint+1+M/N);
end

w = reshape(G,M,1);	             % Equivalent full-band filter