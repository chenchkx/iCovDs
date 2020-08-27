%   Written by Kai-Xuan Chen (e-mail: kaixuan_chen_jsh@163.com)
%   version 2.0 -- December/2018 
%   version 1.0 -- June/2017 


function new_Dis = decide_Dis(dis)
    if dis<= 1e-15
        new_Dis = 0;
    else
        new_Dis = dis;
    end
end