%% Genetating path of PCA files
% input:
%      option: paramters of dataset
% output:
%      pca_Path : path of  PCA files
%% Coder: Kai-Xuan Chen
%% code completed on 2018.06.08

function pca_Path = get_path_PCA(option)
    pca_Path = ['.\tool_Mat\','para_PCA','_',option.name_Dataset,'_typeBlock',num2str(option.num_Sqrt_Block),'_size',num2str(option.row_Resize),'.mat'];
end