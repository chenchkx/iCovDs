%% Author: Kai-Xuan Chen 

function new_Dis = decide_Dis(dis)
    if dis<= 1e-15
        new_Dis = 0;
    else
        new_Dis = dis;
    end
end