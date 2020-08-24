%%  combine distance matrix for NN methods
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


function out_Matrix = combine_Dis_Matrix(option,workers)
    
    num_Total_Samples = option.num_Sample*option.num_Class;
    dis_Matrix_A = zeros(num_Total_Samples,num_Total_Samples);
    dis_Matrix_S = zeros(num_Total_Samples,num_Total_Samples);
    dis_Matrix_J = zeros(num_Total_Samples,num_Total_Samples);
    dis_Matrix_L = zeros(num_Total_Samples,num_Total_Samples);
    for worker_th = 1:workers
        option = set_DisMatrixPath(option,worker_th);
        current_Worker_Dis_Matrix = option.dis_Matrix_Output;
        load(current_Worker_Dis_Matrix);
        dis_Matrix_A = dis_Matrix_A + dis_Matrix.A; 
        dis_Matrix_S = dis_Matrix_S + dis_Matrix.S;
        dis_Matrix_J = dis_Matrix_J + dis_Matrix.J;
        dis_Matrix_L = dis_Matrix_L + dis_Matrix.L;
        clear('dis_Matrix','current_Worker');
    end
    dis_Matrix.A = dis_Matrix_A;
    dis_Matrix.S = dis_Matrix_S;
    dis_Matrix.J = dis_Matrix_J;
    dis_Matrix.L = dis_Matrix_L;
    dis_Matrix_Output = option.dis_Matrix_Path;
    save(dis_Matrix_Output,'dis_Matrix');
    out_Matrix = dis_Matrix;
end