%%  Compute CSPD matrices
%   CSPD: a special type of improved CovDs(iCovDs) 
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

function final_ImprovedCovDs = com_ImprovedCovDs(block_Matrix,option)
    [dim,~,num_Block] = size(block_Matrix);
    
    
    switch option.type_Block
        case 'CovDs'
            logm_Block_Representations = zeros(dim,dim,num_Block);
            for blo_th = 1:num_Block
                temp_Block = block_Matrix(:,:,blo_th);
                temp_Cov = cov(temp_Block');
                [~,S] = eig(temp_Cov);
                [temp_min,~] = min(diag(S));
                if temp_min <= 10^(-9)
                    temp_Block = temp_Block + rand(size(temp_Block));
                    temp_Cov = cov(temp_Block');
                    [~,S] = eig(temp_Cov);
                    [temp_min,~] = min(diag(S));
                    while temp_min <= 10^(-9)
                        temp_Cov = temp_Cov + 0.001*trace(temp_Cov)*eye(dim);
                        [~,S] = eig(temp_Cov);
                        [temp_min,~] = min(diag(S));
                    end  
                elseif norm(temp_Cov,'fro') == 0 && trace(temp_Cov) == 0
                    temp_Cov = eye(dim);
                end 
                logm_TempCov = logm(temp_Cov);
                logm_Block_Representations(:,:,blo_th) = logm_TempCov;
            end
            vec_Block_Representations = reshape(logm_Block_Representations,dim*dim,num_Block);
        case 'Gauss'
            logm_Block_Representations = zeros(dim+1,dim+1,num_Block);
            for blo_th = 1:num_Block
                temp_Block = block_Matrix(:,:,blo_th);
                temp_Cov = embed_Gauss2SPD(temp_Block,option);
                [~,S] = eig(temp_Cov);
                [temp_min,~] = min(diag(S));
                if temp_min <= 10^(-9)
                    temp_Block = temp_Block + rand(size(temp_Block));
                    temp_Cov = embed_Gauss2SPD(temp_Block,option);
                    [~,S] = eig(temp_Cov);
                    [temp_min,~] = min(diag(S));
                    while temp_min <= 10^(-9)
                        temp_Cov = temp_Cov + 0.001*trace(temp_Cov)*eye(dim+1);
                        [~,S] = eig(temp_Cov);
                        [temp_min,~] = min(diag(S));
                    end                    
                elseif norm(temp_Cov,'fro') == 0 && trace(temp_Cov) == 0
                    temp_Cov = eye(dim+1);
                end 
                logm_TempCov = logm(temp_Cov);
                logm_Block_Representations(:,:,blo_th) = logm_TempCov;
            end     
            vec_Block_Representations = reshape(logm_Block_Representations,(dim+1)*(dim+1),num_Block);
    end
    ImprovedCovDs = vec_Block_Representations'*vec_Block_Representations;
    [~,S] = eig(ImprovedCovDs);
    [temp_min,~] = min(diag(S));
    while temp_min <= 10^(-9)
        ImprovedCovDs = ImprovedCovDs + 0.001*trace(ImprovedCovDs)*eye(num_Block);
        [~,S] = eig(ImprovedCovDs);
        [temp_min,~] = min(diag(S));
    end 
    
    final_ImprovedCovDs = ImprovedCovDs;
end
