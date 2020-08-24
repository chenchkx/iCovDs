%%  get the number and location of blocks
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

function [location_Matrix,block_Num] = get_Block_Information(option)
    block_Num = fix((option.resized_Row-option.block_Row)/option.step_Row+1)*fix((option.resized_Col-option.block_Col)/option.step_Col+1);
    temp_Matrix = zeros(2,block_Num);
    temp = 0;
    for row_th = 1:(option.resized_Row-option.block_Row)/option.step_Row+1
        x_Location = option.step_Row*(row_th-1)+1;
        for col_th = 1:(option.resized_Col-option.block_Col)/option.step_Col+1
            y_Location = option.step_Col*(col_th-1)+1;
            temp = temp + 1;
            temp_Matrix(1,temp) = x_Location;
            temp_Matrix(2,temp) = y_Location;
        end
    end
    location_Matrix = temp_Matrix;
    clear ('temp_Matrix','x_Location','y_Location','temp');
end