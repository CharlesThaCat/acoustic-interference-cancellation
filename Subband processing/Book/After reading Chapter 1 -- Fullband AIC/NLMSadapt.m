function [yn,en,S] = NLMSadapt(un,dn,S)
M = length(S.coeffs);                   % length of FIR filter
mu = S.step;                            % step size (between 0 and 2)
% leak = S.leakage;                       % leaky factor
alpha = S.alpha;                        % a small constant 
AdaptStart = S.AdaptStart;              
w = S.coeffs;                           % weight vector of FIR filter
u = zeros(M,1);                         % input signal vector

ITER = length(un);                      % length of input sequence
yn = zeros(1,ITER);                     % initialize output vector to zero
en = zeros(1,ITER);                     % initialize error vector to zero

for n = 1:ITER
    u = [un(n); u(1:end-1)];            % input signal vector
    yn(n) = w'*u;                       % output signal from transversal FIR filter
    en(n) = dn(n) - yn(n);              % estimation error

%{
     if ComputeEML == 1
        eml(n) = norm(b-w) / norm_b;    % system error norm (normalized)        
    end 
%}

    if n >= AdaptStart
        % w = (1-mu*leak)*w + (mu*en(n)/(u'*u + alpha))*u;    % tap weight adaptation
        w = w + (mu*en(n)/(u'*u + alpha))*u;    % tap weight adaptation
        S.iter = S.iter + 1;
    end
end
end

