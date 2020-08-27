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
function [train_Data,test_Data] = split_Data(data,rand_Matrix,option)
    for class_th = 1:option.num_Class
        train_Data(1,option.num_Train*class_th-option.num_Train+1:option.num_Train*class_th) = data(class_th,rand_Matrix(class_th,1:option.num_Train));
        test_Data(1,option.num_Test*class_th-option.num_Test+1:option.num_Test*class_th) = data(class_th,rand_Matrix(class_th,1+option.num_Train:option.num_Sample));
    end
end