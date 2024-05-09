function sigma_n_star = find_sigma(s,L,sigma_n,num_rep)
%%%
%%% Calculate the upper bound for the sigma_n of Virtual Metrology (VM) to achieve better performance
%%% than Physical Metrology (PM) with given values of s, L, and sigma_n.
%%%
%%% This function iterates over increasing values of VM's sigma_n from 0 in increments of 0.1.
%%% It determines the point at which the error surpasses that of PM and returns the previous value as the upper bound.
%%%

arguments
    % The nominal values used in the paper are set as default.
    % If no input arguments are provided, the nominal values will be used.
    s = 20;
    L = 50;
    sigma_n = 1;
    num_rep = 1000;
end

sigma_n_star = 0;

while semi(1,0,sigma_n_star,num_rep) < semi(s,L,sigma_n,num_rep)
    sigma_n_star = sigma_n_star + 0.1;
end
sigma_n_star = sigma_n_star - 0.1;
end