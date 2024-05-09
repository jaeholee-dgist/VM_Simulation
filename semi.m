function MSE = semi(s,L,sigma_n,num_rep)
%%%
%%% This code simulates 1,000 repeated semiconductor processes
%%% to compute the Mean Squared Error (MSE) between the output and the Target value T.
%%%
%%% Comments regarding the sampling interval (s), delay (L), and standard deviation of measurement noise (sigma_n).
%%% The nominal values used in the paper are: s=20, L=50, sigma_n=1.
%%%
%%% The target value T is set to 10, and Lambda is set to 0.3 as the default value.
%%% The gain b is set to 2.
%%%


arguments
    %
    % This values represent the ideal scenario 
    % where measurements are taken at every step
    % without any delay or measurement noise.
    %
    % If no input arguments are provided, the values for ideal scenario will be used.
    %    
    s = 1;
    L = 0;
    sigma_n = 0;
    num_rep = 1000;
end


for k = 1:num_rep
    c(1) = 1;                   % initial state
    EWMA(1) = 0;                % initial estimate
    lambda = 0.3;               % process variability parameter
    N = 100000;                 % length of simulations
    a = randn(1,N);             % IID normally distributed shock which is used to compute c(t)
    %                           % MSE(y,T) = var(a) for ideal scenario (s = 1, L = 0, sigma_n = 0)
    b = 2;                      % input gain of controller
    T = 10;                     % target value
    
    c_s(1) = 1;
    EWMA_s(1) = 0;
    n = sigma_n * randn(1,N);   % measurement noise with standard deviation sigma_n
    
    % Optimal estimate of lambda affected by sampling interval
    lambda_star = (sqrt(s*lambda^2*(s*lambda^2-4*lambda+4))-s*lambda^2)/(2*(1-lambda));
    
    
    % EWMA process considering s, L, and sigma_n
    for i = 1:N
        if i-L<2
            u(i) = (T-EWMA(1))/b;
            u_s(i) = (T-EWMA_s(ceil(1/s)))/b;
            y(i) = b*u(i) + c(i) + n(i);
            y_s(i) = b*u_s(i) + c(i) + n(i);
        else
            u(i) = (T-EWMA(i-L))/b;
            u_s(i) = (T-EWMA_s(ceil((i-L)/s)))/b;
            y(i) = b*u(i) + c(i) + n(i);
            y_s(i) = b*u_s(i) + c(i) + n(i);
        end
        
        
        if i<N
            c(i+1) = c(i) - (1-lambda)*a(i) + a(i+1);
            EWMA(i+1) = lambda*(y(i)-b*u(i)) + (1-lambda)*EWMA(i);
            
            if mod(i,s) == 0
                c_s(i/s+1) = c(i+1);
                EWMA_s(i/s+1) = lambda_star*(y_s(i) - b*u_s(i)) + (1-lambda_star)*EWMA_s(i/s);
            end
        end
    end
    
    mse_EWMA_s(k) = immse(y_s,T*ones(1,N)); % Compute the MSE between y and T
end
MSE = mean(mse_EWMA_s); % Return the mean value of 'num_rep' simulations
end