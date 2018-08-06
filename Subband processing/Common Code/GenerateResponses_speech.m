function [un,dn,vn] = GenerateResponses_speech(b,filename)

% GenerateResponses_speech  Generate Input and Desired Responses with Speech Signal
%
% Arguments:
% b                         Unknown system
% filename                  Filename of speech with variable "un" containing
%                             the speech segment to be used
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

load(filename,'un');
rand('state',sum(100*clock));
vn = (rand(1,length(un))-0.5)*sqrt(12*1e-6); % white noise with variance -60 dB
a = abs(max(un))/sqrt(2); un = un/a;         % Normalize speech to unit variance
un = un + vn;                                % Add noise to speech

dn = filter(b,1,un);                         % Generate desired response d(n)
dn = dn(length(b)+1:end);                    % Adjusting starting index of signals
un = un(length(b)+1:end);

% Normalization of speech signal
  
a = abs(max(dn))/sqrt(2);
un = un/a; dn = dn/a;