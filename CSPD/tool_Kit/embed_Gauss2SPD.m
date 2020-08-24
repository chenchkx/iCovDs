%%  Gaussian Embedding: embed Gaussian manifold into SPD manifold
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

function current_SPD = embed_Gauss2SPD(current_Feature,option)
        beta = option.beta_Gauss;
        [d,~] = size(current_Feature);
        current_SPD = zeros(d+1,d+1);
        mean_Feature = mean(current_Feature,2);
        cov_Feature = cov(current_Feature');    
        if norm(cov_Feature,'fro') == 0 && trace(cov_Feature) == 0
            current_SPD = eye(d+1);
        else
            current_SPD(1:d,1:d) = cov_Feature + beta^2.*mean_Feature*mean_Feature';
            current_SPD(1+d,1:d) = beta*mean_Feature;
            current_SPD(1:d,1+d) = beta*mean_Feature';
            current_SPD(1+d,1+d) = 1; 
        end              
end