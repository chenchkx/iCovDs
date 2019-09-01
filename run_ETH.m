%% The average recognition rates 
%%  Use four NN classifiers and one discriminative classifier to calculate recognition rate
%%  Author: Kai-Xuan Chen

clear;
clc;
option = set_Option('ETH');
[option,log_CovDs,dis_Matrix] = loading_Para(option);
load In_Matrix_ETH.mat;
row_total = size(In_Matrix,1);% In_Matrix

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
    tic;                                           % classification via distance matrix(AIRM)
    accracy_Matrix(1,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.A);
    time_Matrix(1,ite_th) = toc;

    tic;                                           % classification via distance matrix(Stein)
    accracy_Matrix(2,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.S);
    time_Matrix(2,ite_th) = toc;

    tic;                                           % classification via distance matrix(Jeffrey)
    accracy_Matrix(3,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.J);
    time_Matrix(3,ite_th) = toc;

    tic;                                           % classification via distance matrix(LogED)
    accracy_Matrix(4,ite_th) = nn_Via_disMatrix(option,rand_Matrix,dis_Matrix.L);
    time_Matrix(4,ite_th) = toc;
  
    tic;    % Ker-SVM classifier
    accracy_Matrix(5,ite_th) =  Classify_KSVM(log_CovDs,rand_Matrix,option);
    time_Matrix(5,ite_th) = toc;

end

[MST.mean_Accuracy,mean_Accuracy] = deal(mean(accracy_Matrix,2)); % mean accracy
[MST.std_Accuracy,std_Accuracy] = deal(std(accracy_Matrix,0,2));  % standard deviation
[MST.mean_Time,mean_Time] = deal(mean(time_Matrix,2));            % time matrix
if ~exist(option.res_Path,'dir')
    mkdir(option.res_Path);
end
save(option.res_Output,'MST','mean_Accuracy','std_Accuracy','accracy_Matrix','time_Matrix');
