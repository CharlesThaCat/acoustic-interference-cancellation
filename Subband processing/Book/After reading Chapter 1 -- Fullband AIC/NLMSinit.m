function [S] = NLMSinit(w0,mu,alpha)
% assign structure fields
S.coeffs = w0(:);                   % weight (column) vector of filter
S.step = mu;                        % step size
S.alpha = alpha;                    % a small constant
% S.leakage = leak;                   % leaky factor
S.iter = 0;                         % iteration count
S.AdaptStart = length(w0);          % running effect of adaptive filter, minimum M
end

