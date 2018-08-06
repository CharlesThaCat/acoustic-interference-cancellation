function [en,S] = FDAFadapt(un,dn,S)

% FDAFadapt         FIR-FDAF Adaptive Algorithm 

%                   Perfome over the entire length of input sequence. The history 
%                   of output, square error and coefficients of FIR filters are 
%                   passed out to extenal
% Arguments:
% un                Input signal
% dn                Desired signal
% S                 Adptive filter parameters as defined in FDAFinit.m
% yn                History of output signal
% en                History of error signal
%
% Reference:        S. Haykin, Adaptive Filter Theory, 4th Ed, 2002, Prentice Hall
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

M = S.length;                  % Length of adaptive filter
mu = S.step;                   % Step size of constrained FDAF
mu_unconst = S.step_unconst;   % Step size of unconstrained FDAF
AdaptStart = 2*S.AdaptStart;   % Adaptation starts after 2M-sample blocks are acquired
WEIGHT = zeros(2*S.length,1);  % Initialize 2M coefficients to 0 
dn_block = zeros(S.length,1);  % Initialize M samples of desired signal to 0
u_new = zeros(S.length,1);     % Initialize M samples of new block to 0
u_old = zeros(S.length,1);     % Initialize M samples of old block to 0
power_alpha = S.palpha;        % Initialize constant for update bin power 
power = zeros(2*S.length,1);   % Initialize average power of each bin to 0
ITER = length(un);             % Length of input sequence
select = S.select;             % Select constrained or unconstrained FDAF algorithm           
en = [];                       % Accumulation of error vector 
eml = [];                      % Accumulation of misalignment


for n = 1:ITER
    u_new = [u_new(2:end); un(n)];        % Start input signal blocks    
    dn_block = [dn_block(2:end); dn(n)];  % Start desired signal block
    if mod(n,M)==0                        % If iteration == block length, 
        un_blocks = [u_old; u_new];       
        u_old = u_new;
        b = S.unknownsys;
        if n >= AdaptStart                % Frequency-domain adaptive filtering
            [error,WEIGHT,power,misalign]=fdaf(M,mu,mu_unconst,power_alpha,WEIGHT,dn_block,un_blocks,power,b,select);
            en = [en; error];             % Update error block 
            eml = [eml; misalign];        % Update misalignment at each block
        end
    end
end

S.weight = WEIGHT;
S.eml = eml;
