%% Author: Kai-Xuan Chen 

function num_Class_each_Worker = split_numClass2Worker(num_Class,workers)
    mean_Num_Class = fix(num_Class/workers);
    if mean_Num_Class == 0
        num_Class_each_Worker = zeros(1,workers);
        for cal_th = 1:num_Class
            num_Class_each_Worker(1,cal_th) = 1;
        end        
    elseif mean_Num_Class == 1
        num_Class_each_Worker = zeros(1,workers);
        for worker_th = 2:workers
            num_Class_each_Worker(1,worker_th) = 1;
        end
        num_Class_each_Worker(1,1) = num_Class - workers   + 1;
    else
        if workers ==4
            num_Class_each_Worker = zeros(1,workers);
            num_Class_each_Worker(1,4) = mean_Num_Class-1;
            num_Class_each_Worker(1,3) = mean_Num_Class;
            num_Class_each_Worker(1,2) = mean_Num_Class+1;
            num_Class_each_Worker(1,1) = num_Class - 3*mean_Num_Class;
        elseif workers ==3
            num_Class_each_Worker = zeros(1,workers);
            num_Class_each_Worker(1,3) = mean_Num_Class-1;
            num_Class_each_Worker(1,2) = mean_Num_Class;   
            num_Class_each_Worker(1,1) = num_Class - 2*mean_Num_Class + 1;  
        elseif workers ==2
            num_Class_each_Worker(1,2) = fix(num_Class*0.3);   
            num_Class_each_Worker(1,1) = num_Class - num_Class_each_Worker(1,2);
        else
            num_Class_each_Worker(1,1) = num_Class;
        end
    end    
end