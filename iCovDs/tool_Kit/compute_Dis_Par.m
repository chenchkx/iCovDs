%% Author: Kai-Xuan Chen 

% compute distance matrix for NN methods
% input:  
%       option for current dataset
% output: 
%       distance matrix of current dataset

function dis_Matrix = compute_Dis_Par(option,worker_th,workers)
    load(option.output_Path);
    num_Class_each_Worker = split_numClass2Worker(option.num_Class,workers);
    begin_Class = option.num_Class - sum(num_Class_each_Worker(1,1:worker_th)) + 1;
    end_Class = begin_Class + num_Class_each_Worker(1,worker_th) - 1;
    num_Classes = option.num_Class;
    row_th = option.num_Sample*(begin_Class-1);                   % row of dis_Matrix
    col_th = row_th;                   % col of dis_Matrix
    initial_col = row_th;
    num_Total_Samples = option.num_Sample*num_Classes;
    dis_Matrix_A = zeros(num_Total_Samples,num_Total_Samples);
    dis_Matrix_S = zeros(num_Total_Samples,num_Total_Samples);
    dis_Matrix_J = zeros(num_Total_Samples,num_Total_Samples);
    dis_Matrix_L = zeros(num_Total_Samples,num_Total_Samples);
    dis_Matrix_Output = [option.mat_Path,'\','disMatrix','_','par',num2str(worker_th),'_',option.name_Dataset,'_resized',...
        num2str(option.resized_Row),'M',num2str(option.resized_Col),'_blockSize',num2str(option.block_Row),'M',num2str(option.block_Col),...
        '_stepSize',num2str(option.step_Row),'M',num2str(option.step_Col),'_arcKerOrder',num2str(option.order),'_betaGau',num2str(option.beta_Gauss),...
        '_minEGau',num2str(option.min_Eig_Gauss),'_minEiCovDs',num2str(option.min_Eig_iCovDs),'.mat'];
    if ~exist(dis_Matrix_Output,'file') && begin_Class <= end_Class
        for cla_rth = begin_Class:end_Class           
            for set_rth = 1:option.num_Sample
                row_th = row_th + 1;
                r_spd_CovDs = cov_Improve_CovDs{cla_rth,set_rth};
                r_log_CovDs = log_Improve_CovDs{cla_rth,set_rth};
                r_inv_CovDs = inv_Improve_CovDs{cla_rth,set_rth};
            %%  for columns
                for cla_cth = begin_Class:num_Classes
                    for set_cth = 1:option.num_Sample
                        col_th = col_th + 1;
                        if col_th >= row_th
                            c_spd_CovDs = cov_Improve_CovDs{cla_cth,set_cth};
                            c_log_CovDs = log_Improve_CovDs{cla_cth,set_cth};
                            c_inv_CovDs = inv_Improve_CovDs{cla_cth,set_cth};
                            tmpEig =  eig(r_spd_CovDs,c_spd_CovDs);   % distance while using AIRM
            %                         outAIRM = sum(log(tmpEig).^2);
                            dis_AIRM = decide_Dis(sum(log(tmpEig).^2)); % distance while using AIRM
                            % distance while using Stein
            %                         dis_Stein = decide_Dis(log(det(0.5*(r_spd_CovDs+c_spd_CovDs))) -  0.5*(log(det(r_spd_CovDs*c_spd_CovDs))));
                            dis_Stein = decide_Dis(compute_Stein_D(r_spd_CovDs,c_spd_CovDs));
                            % distance while using Jeffrey
                            dis_Jeff = decide_Dis(0.5*trace(r_inv_CovDs*c_spd_CovDs)+0.5*trace(c_inv_CovDs*r_spd_CovDs) - size(r_spd_CovDs,1));
                            % distance while using LogED
                            dis_LogEu = decide_Dis(norm((r_log_CovDs-c_log_CovDs),'fro'));
                            if mod(row_th,2)==0 && mod(col_th,5)==0
            %                         if mod(col_th,5)==0
                                fprintf('computing dis_Matrix of %d_th row, %d_th col. \n',row_th,col_th); 
                            end
            %                             dis_Matrix_A(row_th,col_th) = dis_AIRM;dis_Matrix_A(col_th,row_th) = dis_AIRM;
            %                             fprintf('AIRM completed, ');
            %                             dis_Matrix_S(row_th,col_th) = dis_Stein;dis_Matrix_S(col_th,row_th) = dis_Stein;
            %                             fprintf('Stein completed, ');
            %                             dis_Matrix_J(row_th,col_th) = dis_Jeff;dis_Matrix_J(col_th,row_th) = dis_Jeff;
            %                             fprintf('Jeffrey completed, ');
            %                             dis_Matrix_L(row_th,col_th) = dis_LogEu;dis_Matrix_L(col_th,row_th) = dis_LogEu;
            %                             fprintf('LogED completed. \n');                        
                            dis_Matrix_A(row_th,col_th) = dis_AIRM;dis_Matrix_A(col_th,row_th) = dis_AIRM;
                            dis_Matrix_S(row_th,col_th) = dis_Stein;dis_Matrix_S(col_th,row_th) = dis_Stein;
                            dis_Matrix_J(row_th,col_th) = dis_Jeff;dis_Matrix_J(col_th,row_th) = dis_Jeff;
                            dis_Matrix_L(row_th,col_th) = dis_LogEu;dis_Matrix_L(col_th,row_th) = dis_LogEu; 
                            clear ('c_spd_CovDs','c_log_CovDs','c_inv_CovDs');                       
                        end  
                    end       
                end  
                col_th = initial_col;
                clear ('r_spd_CovDs','r_log_CovDs','r_inv_CovDs');
            end       
        end
        dis_Matrix.A = dis_Matrix_A;
        dis_Matrix.S = dis_Matrix_S;
        dis_Matrix.J = dis_Matrix_J;
        dis_Matrix.L = dis_Matrix_L;

        save(dis_Matrix_Output,'dis_Matrix');
    else
        dis_Matrix = [];
    end
    
end