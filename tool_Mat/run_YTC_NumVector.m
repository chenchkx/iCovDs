%% generate fold matrix for YTC dataset
% Author: Kai-Xuan Chen
% Date: 2018.09.22

clear;
clc;
num_VectorOfYTC = [55,64,70,37,20,...
    24,43,47,108,29,...
    28,22,33,34,35,...
    20,34,20,17,29,...
    22,55,37,48,49,...
    59,29,35,53,30,...
    36,36,45,65,32,...
    40,71,40,41,58,...
    49,28,46,34,35,...
    33,34];
Fold_Matrix = zeros(47,10);
for class_th = 1:47
    current_Num = num_VectorOfYTC(1,class_th);
    if current_Num>45
        temp_Step = fix((current_Num - 45)/6);
        for fold_th = 1:5
            ind_Start = temp_Step*fold_th + (fold_th-1)*9 + 1;
            ind_End = ind_Start + 8;
            Fold_Matrix(class_th,fold_th*2-1:fold_th*2) = [ind_Start,ind_End];
        end
    else
        temp_OverLapping = fix((45 - current_Num)/4) + 1;
        temp_Step = 9 - temp_OverLapping;
        for fold_th = 1:5
            ind_Start = temp_Step*(fold_th-1) + 1;
            ind_End = ind_Start + 8;
            Fold_Matrix(class_th,fold_th*2-1:fold_th*2) = [ind_Start,ind_End];
        end
    end   
end
out_Mat = '.\Fold_Matrix_YTC.mat';
save(out_Mat,'Fold_Matrix');