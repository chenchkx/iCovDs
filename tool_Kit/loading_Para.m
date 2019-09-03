%% load data for classifiers
%  Author: Kai-Xuan Chen (e-mail: kaixuan_chen_jsh@163.com)
%% function [option,Log_RandomD,output_DisMatrix] = loading_Para(option)
%   input : 
%         param 1 : the struct of parameters 
%   output:
%         option : the struct of parameters
%         Log_RandomD : the cell of the logarithm of SPD matrices
%         output_DisMatrix : distance matrix for NN classifier

function [option,Log_RandomD,output_DisMatrix] = loading_Para(option)
    if ~exist(option.res_Path,'dir')
        mkdir (option.res_Path);
    end
    option.num_Train = option.num_Gallery;
    option.num_Test = option.num_Probe;
    option.label_Train = option.label_Gallery;
    option.label_Test = option.label_Probe; 
    file_Path = option.output_Path ;
    load (file_Path);
    Log_RandomD = log_Improve_CovDs;
    if ~exist(option.dis_Matrix_Path,'file')
        workers = 4;
        pool = parpool(workers);    
        parfor worker_th = 1:workers
            temp_Dis_Matrix = compute_Dis_Par(option,worker_th,workers); % generate distance matrix, if it does not exist.   
        end
        delete(pool); 
        dis_Matrix = combine_Dis_Matrix(option,workers);
    else
        load (option.dis_Matrix_Path);
    end
    output_DisMatrix = dis_Matrix;
end