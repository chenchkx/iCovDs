%% Compute the time of the Riemannian metrics
% Author: Kai-Xuan Chen
% Date: 2018.10.05

function [output_Data] = compute_TimeOfRiemannianMetric(option)
    load(option.output_Path);
    num_Ite_TestTime = 100;
    option.num_Train = option.num_Gallery;
    option.num_Test = option.num_Probe;
    option.label_Train = option.label_Gallery;
    option.label_Test = option.label_Probe; 
    log_Data = cell(option.num_Class,option.num_Sample);
    spd_Data = cell(option.num_Class,option.num_Sample);
    inv_Data = cell(option.num_Class,option.num_Sample);
    time_Matrix_A = zeros(1,num_Ite_TestTime);
    time_Matrix_S = zeros(1,num_Ite_TestTime);
    time_Matrix_J = zeros(1,num_Ite_TestTime);
    time_Matrix_L = zeros(1,num_Ite_TestTime);
    for ite_th = 1:num_Ite_TestTime
        ite_th
        rand_Ind = randperm(option.num_Sample);
        num_Compute = 0;
        num_Gallery = 0; num_Probe = 0;
        for cla_th = 1:option.num_Class
            for gallery_th = 1:option.num_Gallery
                num_Gallery = num_Gallery + 1;
                gallery_Spd{1,num_Gallery} = cov_Improve_CSPD{cla_th,rand_Ind(gallery_th)};
                gallery_Log{1,num_Gallery} = log_Improve_CSPD{cla_th,rand_Ind(gallery_th)};
                gallery_Inv{1,num_Gallery} = inv_Improve_CSPD{cla_th,rand_Ind(gallery_th)};
            end
            for probe_th = 1+option.num_Gallery:option.num_Sample
                num_Probe = num_Probe + 1;
                probe_Spd{1,num_Probe} = cov_Improve_CSPD{cla_th,rand_Ind(probe_th)};
                probe_Log{1,num_Probe} = log_Improve_CSPD{cla_th,rand_Ind(probe_th)};
                probe_Inv{1,num_Probe} = inv_Improve_CSPD{cla_th,rand_Ind(probe_th)};
            end
        end   
        for gallery_th = 1:length(gallery_Spd)
            current_Gallery_Spd = gallery_Spd{1,gallery_th};
            current_Gallery_Log = gallery_Log{1,gallery_th};
            current_Gallery_Inv = gallery_Inv{1,gallery_th};
            for probe_th = 1:length(probe_Spd)
                current_Probe_Spd = probe_Spd{1,probe_th};
                current_Probe_Log = probe_Log{1,probe_th};
                current_Probe_Inv = probe_Inv{1,probe_th};   
                num_Compute = num_Compute + 1;
                tic;
                temp_Dis_AIRM = sum(log(eig(current_Gallery_Spd,current_Probe_Spd)).^2);
                temp_Time_A = toc;
                time_Matrix_A(1,ite_th) = time_Matrix_A(1,ite_th) + temp_Time_A;
                if mod(num_Compute,100) == 0
                    fprintf('%d_th AIRM has done\n',num_Compute); 
                end
                tic;
                temp_Dis_Stein = compute_Stein_D(current_Gallery_Spd,current_Probe_Spd);
                temp_Time_S = toc;
                time_Matrix_S(1,ite_th) = time_Matrix_S(1,ite_th) + temp_Time_S;
                if mod(num_Compute,100) == 0
                    fprintf('%d_th Stein has done\n',num_Compute); 
                end
                
                tic;
                temp_Dis_J = 0.5*trace(current_Gallery_Inv*current_Probe_Spd)+0.5*trace(current_Probe_Inv*current_Gallery_Spd) - size(current_Gallery_Spd,1);
                temp_Time_J = toc;
                time_Matrix_J(1,ite_th) = time_Matrix_J(1,ite_th) + temp_Time_J;
                if mod(num_Compute,100) == 0
                    fprintf('%d_th Jeffrey has done\n',num_Compute); 
                end
                
                tic;
                temp_Dis_L = norm((current_Gallery_Log-current_Probe_Log),'fro');
                temp_Time_L = toc;
                time_Matrix_L(1,ite_th) = time_Matrix_L(1,ite_th) + temp_Time_L;
                if mod(num_Compute,100) == 0
                    fprintf('%d_th LEM has done\n',num_Compute); 
                end
            end
        end
    end
    output_Data.mean_A = mean(time_Matrix_A);
    output_Data.mean_S = mean(time_Matrix_S);
    output_Data.mean_J = mean(time_Matrix_J);
    output_Data.mean_L = mean(time_Matrix_L);
end