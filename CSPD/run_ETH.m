%%  The average recognition rates 
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

%% Use four NN classifiers and four discriminative classifiers to calculate recognition rate
clear;
clc;
option = set_Option('ETH','CovDs');
[option,log_CovDs,dis_Matrix] = loading_Para(option); % load data for classifiers
In_Matrix = gen_randMatrix(option);      % random index matrix
row_total = size(In_Matrix,1); % In_Matrix

for ite_th = 1:option.num_Ite
    fprintf('------------ite_th :  %d------------------\n',ite_th);
    ind_Begin = (ite_th-1)*option.num_Class+1;    % The beginning of an arbitrary index 
    if ind_Begin >row_total
        ind_Begin = mod(ind_Begin,row_total);     % Re-assign if the 'ind_Begin' is greater than the row number of index matrix
    end
    ind_End = ind_Begin + option.num_Class -1;    % compute the end of index via 'ind_Begin'
    if ind_End > row_total % If the end of index is greater than the number of rows, re-assign the 'ind_Begin' and 'ind_End'
        ind_Begin = mod(ind_End,row_total);
        ind_End = ind_Begin + option.num_Class -1;
    end
    rand_Matrix = In_Matrix(ind_Begin:ind_End,:);  % The index matrix of the current iteration 
    tic;    % NN classifier via distance matrix(AIRM)
    accuracy_Matrix(1,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.A);
    time_Matrix(1,ite_th) = toc;

    tic;    % NN classifier via distance matrix(Stein)
    accuracy_Matrix(2,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.S);
    time_Matrix(2,ite_th) = toc;

    tic;    % NN classifier via distance matrix(Jeffrey)
    accuracy_Matrix(3,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.J);
    time_Matrix(3,ite_th) = toc;

    tic;    % NN classifier via distance matrix(LogED)
    accuracy_Matrix(4,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.L);
    time_Matrix(4,ite_th) = toc;
  
    tic;    % Ker-SVM classifier
    accuracy_Matrix(5,ite_th) =  Classify_KSVM(log_CovDs,rand_Matrix,option);
    time_Matrix(5,ite_th) = toc;

    tic;    % LogEKSR classifier
    accuracy_Matrix(6,ite_th) = Classify_LogEK(log_CovDs,rand_Matrix,option);
    time_Matrix(6,ite_th) = toc;

    tic;    % CDL (COV-LDA)
    accuracy_Matrix(7,ite_th) = Classify_CDL_LDA(log_CovDs,rand_Matrix,option);
    time_Matrix(7,ite_th) = toc;

    tic;    % CDL (COV-PLS)
    accuracy_Matrix(8,ite_th) = Classify_CDL_PLS(log_CovDs,rand_Matrix,option);
    time_Matrix(8,ite_th) = toc;
end

[MST.mean_Accuracy,mean_Accuracy] = deal(mean(accuracy_Matrix,2)); % mean accracy
[MST.std_Accuracy,std_Accuracy] = deal(std(accuracy_Matrix,0,2));  % standard deviation
[MST.mean_Time,mean_Time] = deal(mean(time_Matrix,2));            % time matrix
if ~exist(option.res_Path,'dir')
    mkdir(option.res_Path);
end
save(option.res_Output,'MST','mean_Accuracy','std_Accuracy','accuracy_Matrix','time_Matrix');