clear; clc;
% Arguments:
%       Fs                  sample rate
%       u                   speaker signal, column vector in range [-1; 1]
%       d                   microphone signal, column vector in range [-1; 1]
%       filter_length       typically 250ms, i.e. 4096 @ 16k FS 
%                           must be a power of 2
%       frame_size          typically 8ms, i.e. 128 @ 16k Fs 
%                           must be a power of 2
%       dbg_var_name        internal state variable name to trace. 
%                           Default: 'st.leak_estimate'.
[x,Fs] = audioread('C:\Users\Xu\Desktop\ÁÖ×¿ÎÄ\echo cancellation\subband\book\After reading Chapter 4 -- Subband Adaptive Filtering\room1_2m_pb\001_2mplayback_1646-802.wav');
u = x(:,5); d = x(:,1);
u1 = u'; d1 = d';
[u11,~] = mapminmax(u1,-1,1);
[d11,~] = mapminmax(d1,-1,1);
u = u11'; d = d11';
filter_length = 2^(nextpow2(0.25*Fs));
frame_size = 2^(nextpow2(0.008*Fs));
speex_mdf_out = speex_mdf(Fs, u, d, filter_length, frame_size);     
err = speex_mdf_out.e;
soundsc(err,Fs);
% audiowrite('1_out_2.wav',err,Fs);
% filtertype = 'FIR';
% Fpass = 1000;
% Fstop = 7500;
% Rp = 0.1;
% Astop = 70;
% LPF = dsp.LowpassFilter('SampleRate',Fs,...
%                              'FilterType',filtertype,...
%                              'PassbandFrequency',Fpass,...
%                              'StopbandFrequency',Fstop,...
%                              'PassbandRipple',Rp,...
%                              'StopbandAttenuation',Astop);
% output = LPF(err);   
% audiowrite('1_out_3.wav',output,Fs);