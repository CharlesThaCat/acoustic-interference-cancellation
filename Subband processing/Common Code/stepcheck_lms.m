function  stepcheck_lms(in,M,mu)

% stepcheck_lms    Performs Step-size Checking
%
%                  To Ensure that the step size selected by user is within the 
%                  prescribed step-size bound. A recommended range of step 
%                  size is also proposed in the report
%
% Arguments:
% in               Input signal
% M                Length of adaptive filter
% mu               Step size selected for the LMS algorithm 
%
% by Lee, Gan, and Kuo, 2008
% Subband Adaptive Filtering: Theory and Implementation
% Publisher: John Wiley and Sons, Ltd

P = var(in);                % Power of input sequence
mu_bound = 2/(M*P);
mu_tight = 2/(3*M*P);
mu_recommend = mu_bound/10;

disp('------------------------------------------------------------------');
disp(sprintf('Step-size bound is greater than 0 but less than %.5f\n',mu_bound));
disp(sprintf('Tighter step-size bound is greater than 0 but less than %.5f\n',mu_tight));
disp(sprintf('Recommended step-size bound is greater than 0 but less than %.5f\n',mu_recommend));


if (mu < mu_recommend) && (mu >0);
    disp('The selected step size is WITHIN the recommended step-size bound');
elseif (mu < mu_bound)
    disp('The selected step size is NOT WITHIN the recommended step-size bound, but still fall within the theoretical step-size bound');
else
    disp('The selected step size is OUTSIDE the step-size bound and will cause INSTABILITY!');
end
disp('------------------------------------------------------------------');