%% Author: Kai-Xuan Chen 

function dis_Matrix_Path = get_Dis_Matrix_Path_YTC_Fold(option,fold_th)
    dis_Matrix_Path = [option.mat_Path,'\','disMatrixFold',num2str(fold_th),'_',option.out_File_Name];
end