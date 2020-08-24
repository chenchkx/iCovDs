%%  classifiers via distance matrices of different Riemannian metrics
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

function accuracy = nn_Via_disMatrix(option,ind_Matrix,disMatrix)
    label_Matrix_Row = reshape(ones(option.num_Sample,option.num_Class)*diag([1:option.num_Class]),...
        [1,option.num_Class*option.num_Sample]);
    label_Matrix_Col = label_Matrix_Row;
    ind_Gallery = []; ind_Probe = [];
    for cla_th = 1:option.num_Class
        current_Ind = ind_Matrix(cla_th,:)+option.num_Sample*(cla_th-1);
        ind_Gallery = [ind_Gallery, current_Ind(1,1:option.num_Gallery)];
        ind_Probe = [ind_Probe, current_Ind(1,option.num_Gallery+1:option.num_Sample)];
    end
    disMatrix_Gallery2Probe = disMatrix(ind_Gallery,ind_Probe);
    label_Gallery = label_Matrix_Col(1,ind_Gallery);
    label_Probe = label_Matrix_Col(1,ind_Probe);
    [~,ind_Label] = min(disMatrix_Gallery2Probe);
    out_Label = label_Gallery(1,ind_Label);
    accuracy = sum((out_Label - label_Probe) == 0)/size(label_Probe,2);
end