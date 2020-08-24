%%  Genetating the Improved CovDs of ETH dataset
%%  Author: Kai-Xuan Chen

clear; 
clc;
workers = 4; 
option = set_Option('ETH');           % set parameters for dataset ETH

%% Generating the Improved CovDs 
[cov_Improve_CovDs,log_Improve_CovDs] = gen_ImprovedCovDs(option,'Gauss');
%   input : 
%         param 1 : the struct of parameters  
%         param 2 : the descriptions of sub-image sets: {Gauss,CovDs}
%                   CovDs/Gauss: represent sub-image sets by traditional CovDs/Gaussian model
%   output:
%         cov_Improve_CovDs : SPD representation
%         log_Improve_CovDs : logarithm matrix representation of SPD

if ~exist(option.dis_Matrix_Path,'file')
    pool = parpool(workers);    
    parfor worker_th = 1:workers
        temp_Dis_Matrix = compute_Dis_Par(option,worker_th,workers); % generate distance matrix, if it does not exist.   
    end
    delete(pool);   
end
dis_Matrix = combine_Dis_Matrix(option,workers);