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

function sample_Matrix = trans_Data(data_Cell)
    num_Cell = length(data_Cell);
    [d,~] =size(data_Cell{1,1});
    sample_Matrix = zeros(d,d,num_Cell);
    for i = 1:num_Cell
        sample_Matrix(:,:,i) = data_Cell{i};        
    end
    sample_Matrix = reshape(sample_Matrix,[size(sample_Matrix,1)*size(sample_Matrix,2),num_Cell]);
    
%     sample_Matrix = [];
%     for i = 1:num_Cell
%         current_Data = data_Cell{i};
%         sample_Matrix = [sample_Matrix(),reshape(current_Data,[size(current_Data,1)*size(current_Data,2),1])];        
%     end
end