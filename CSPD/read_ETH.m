%%  Component symmetric positive definite matrices (CSPD) matrices for ETH dataset
%   CSPD: A low-dimensional discriminative data descriptor than traditional covariance descriptors for image set classification
%   Written by Kai-Xuan Chen (e-mail: kaixuan_chen_jsh@163.com)
%   version 2.0 -- December/2018 
%   version 1.0 -- June/2017 
%
%   Please cite the following paper (more theoretical and technical details) if your are using this code:
%
%   Kai-Xuan Chen, Xiao-Jun Wu. Component SPD matrices: A low-dimensional discriminative
%   data descriptor for image set classification[J]. Computational Visual Media, 2018.
%
%   DOI: 10.1007/s41095-018-0119-7
%   BibTex : 
%   @article{Chen2018Component,
%      title={Component SPD matrices: A low-dimensional discriminative data descriptor for image set classification},
%      author={Chen, Kai-Xuan and Wu, Xiao-Jun},
%      journal={Computational Visual Media},
%      volume={4},
%      number={3},
%      pages={245--252},
%      year={2018},
%      publisher={Springer}
%   } 

%% read data for ETH dataset
clear;  
clc;
workers = 4;                            % the number of workers for parallel operation 
option = set_Option('ETH','CovDs');     % set Hy-Parameters for ETH dataset    
%   input : 
%         param 1 : the name of dataset
%         param 2 : the descriptions of sub-image sets: CovDs
%                   CovDs: represent sub-image sets by traditional CovDs
%   output:
%         option : the struct of parameters  
[cov_Improve_CovDs,log_Improve_CovDs] = gen_ImprovedCovDs(option); % Generating the CSPD (Improved CovDs) and saved as '.mat' files

if ~exist(option.dis_Matrix_Path,'file')
    pool = parpool(workers);    
    parfor worker_th = 1:workers
%     for worker_th = 1:workers
        temp_Dis_Matrix = compute_Dis_Par(option,worker_th,workers); % Generate distance matrix, if it does not exist.   
    end
    delete(pool);   
end
dis_Matrix = combine_Dis_Matrix(option,workers); % combine distance matrix