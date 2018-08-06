function [error,WEIGHT,power,misalign] = fdaf(M,mu,mu_unconst,power_alpha,WEIGHT,dn_block,un_blocks,power,b,select)

% fdaf         Frequency Domain Adaptive Filter Algorithm 
%
% Source:      John Forte, BWV Technologies Inc. 
% Version:     2.0 (Modified from v1.0)
%
% Arguments:
% error        M-point error vector  
% WEIGHT       2M-point complex DFT filter weights
% power        2M-point signal power estimate, one for each frequency bin
% M            Block size
% mu           Step size (between 0 to 2, suggested value is 0.5)
% mu_unconst   Step size of unconstrained FDAF
% power_alpha  Signal power estimate time constant (0 to 1, suggested value is 0.5)
% dn           M-point real-valued desired vector 
% un_blocks    2M-point real-valued input vector, un_blocks(1) is the oldest sample 
% select       Select constrained or unconstrained FDAF algorithm

format long

% Set up a vector to extract the first M elements
 
window_save_first_M = [ones(1,M), zeros(1,M)]';  

% Transform the reference signal into frequency domain

UN = fft(un_blocks);
                                  % FFT[old block; new block]
                                  % Old block contains M previous input samples (u_old)
                                  % New block contains M new input samples (u_new)
                                                        
% Compute the estimate of desired signal

YN = UN.*WEIGHT;                  % Multiplication of input and coeff. vectors
temp = real(ifft(YN));            % Real part of IFFT output
yn = temp(M+1:2*M);               % Extracted the last M elements of IFFT block


% Compute the error signal

error = dn_block-yn;              % Error signal block
EN = fft([zeros(1,M),error']');   % Insert zero block to form 2M block before FFT


% Update the signal power estimates

power = (power_alpha.*power) + (1 - power_alpha).*(abs(UN).^2); 

% Compute the gradient and weight update in frequency domain 

if select == 1
    gradient = real(ifft((1./power).*conj(UN).* EN));
    gradient = gradient.*window_save_first_M;
    WEIGHT = WEIGHT + mu.*(fft(gradient));
else
    gradient = conj(UN).* EN;
    WEIGHT = WEIGHT + mu_unconst.*(gradient);
end
    

% Convert filter taps to time domain 

temp = real(ifft(WEIGHT));
w = temp(1:length(b));

% System error norm (normalized)

misalign = norm(b-w)/norm(b);                    

return

