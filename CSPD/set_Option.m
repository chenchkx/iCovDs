%%  set option for different datasets
%   input : 
%         param 1 : the name of dataset
%         param 2 : the descriptions of sub-image sets: CovDs
%                   CovDs: represent sub-image sets by traditional CovDs
%   output:
%         option : the struct of parameters  
%   
%   Written by Kai-Xuan Chen (e-mail: kaixuan_chen_jsh@163.com)
%   version 2.0 -- December/2018 
%   version 1.0 -- June/2017 
%
%   Please cite the following paper (more theoretical and technical details) if your are using this code:
%   Kai-Xuan Chen, Xiao-Jun Wu. Component SPD matrices: A low-dimensional discriminative
%   data descriptor for image set classification[J]. Computational Visual Media, 2018.
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
function option = set_Option(name,type_Block)
    addpath(genpath('tool_Kit'));
    addpath(genpath('CDL')); 
    addpath(genpath('LogEK_SR'));
    addpath(genpath('Classify_NN'));
    switch name
        case 'ETH'
            option.root_Path = '.\ETH-80\'; % rootpath of dataset in your computer
            option.mat_Path = '.\data\mat_ETH';                                 % relative path of CSPD 
            option.res_Path = '.\data\res_ETH';                                 % relative path of '.mat' files of accuracies 
            option.name_Dataset = 'ETH';                                        % the name of dataset
            option.num_Ite = 100;                                               % number of iterations 
            option.num_Class = 8;                                               % number of categories
            option.num_Sample = 10;                                             % number of sample in each class
            option.num_Gallery = 2;                                             % number of gallery sample
            option.num_Probe = option.num_Sample - option.num_Gallery;          % number of probe sample
            option.label_Gallery = reshape(ones(option.num_Gallery,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Gallery]);
                                                                                % label of gallery sample
            option.label_Probe = reshape(ones(option.num_Probe,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Probe]);
                                                                                % label of probe sample
            option.type_Image = '.png';                                         % suffix of images
            option.train_Rate = 1;                                              % the train_Rate for PCA
            option.if_PCA = 0;                                                  % 1£ºPCA  0£ºPCA unnecessary
            option.type_PCA = 'topK_PCA';                                       % param{'rate_PCA','topK_PCA'}
            option.rate_PCA = 0.99;                                             % energy need to be retained for 'rate_PCA'
            option.topK_PCA = 15;                                               % components need to be retained for 'topK_PCA'
            option.resized_Row = 24;                                            % the height of the resized image
            option.resized_Col = 24;                                            % the width of the resized image
            option.block_Row = 4;                                               % the height of the blocks
            option.block_Col = 4;                                               % the width of the blocks
            option.step_Row = 4;                                                % step size in the row direction
            option.step_Col = 4;                                                % step size in the column direction
            option.pre_Set = '';                                                % prefix string of each image set  
            option.pre_Class = '';                                              % prefix string of each class
            option.LogEK_N = 1;                                                 % paramter for LogEKSR
            option.latentDim_PLS = option.num_Class + 1;                        % latent dimension for COV-PLS
            option.type_Block = type_Block;                                     % the descriptions of sub-image sets: {Gauss,CovDs}
            option.beta_Gauss = 0.1;                                            % paramter for Gaussian embedding
                                                
            
        case 'Virus'
            option.root_Path = 'E:\WORKSPACE\DATASET\Virus\Virus\';
            option.mat_Path = '.\data\mat_Virus';
            option.res_Path = '.\data\res_Virus';
            option.name_Dataset = 'Virus';
            option.num_Ite = 100;
            option.num_Class = 15;
            option.num_Sample = 5;
            option.num_Gallery = 3;
            option.num_Probe = option.num_Sample - option.num_Gallery;
            option.label_Gallery = reshape(ones(option.num_Gallery,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Gallery]);
            option.label_Probe = reshape(ones(option.num_Probe,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Probe]);
            option.type_Image = '.png';
            option.train_Rate = 1;  
            option.if_PCA = 0; 
            option.type_PCA = 'topK_PCA';
            option.rate_PCA = 0.99; 
            option.topK_PCA = 33; 
            option.resized_Row = 24;
            option.resized_Col = 24;
            option.block_Row = 6;
            option.block_Col = 6;
            option.step_Row = 6;
            option.step_Col = 6;  
            option.pre_Set = '';
            option.pre_Class = '';
            option.LogEK_N = 1;
            option.latentDim_PLS = option.num_Class + 1;                        
            option.type_Block = type_Block;                                    
            option.beta_Gauss = 0.9;                                            
            
        case 'CG'
            option.root_Path = 'E:\WORKSPACE\DATASET\CGesture\';
            option.mat_Path = '.\data\mat_CG';
            option.res_Path = '.\data\res_CG';
            option.name_Dataset = 'CG';
            option.num_Ite = 100;
            option.num_Class = 9;
            option.num_Sample = 100;
            option.num_Gallery = 20;
            option.num_Probe = option.num_Sample - option.num_Gallery;
            option.label_Gallery = reshape(ones(option.num_Gallery,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Gallery]);
            option.label_Probe = reshape(ones(option.num_Probe,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Probe]);
            option.type_Image = '.jpg';
            option.train_Rate = 0.5;  
            option.if_PCA = 0; 
            option.type_PCA = 'topK_PCA';
            option.rate_PCA = 0.998; 
            option.topK_PCA = 15; 
            option.resized_Row = 24;
            option.resized_Col = 24;
            option.block_Row = 4;
            option.block_Col = 4;
            option.step_Row = 4;
            option.step_Col = 4; 
            option.pre_Set = 's';
            option.pre_Class = '';  
            option.LogEK_N = 1;                                               
            option.latentDim_PLS = option.num_Class + 1;                        
            option.type_Block = type_Block;                                     
            option.beta_Gauss = 0.1;                                            
           
    end
    option.out_File_Name = [option.name_Dataset,'_resized',num2str(option.resized_Row),'M',num2str(option.resized_Col),'_blockSize',...
        num2str(option.block_Row),'M',num2str(option.block_Col),'_stepSize',num2str(option.step_Row),'M',num2str(option.step_Col),'_',type_Block,'.mat'];
    option.output_Path = [option.mat_Path,'\',option.out_File_Name];
    option.dis_Matrix_Path = [option.mat_Path,'\','disMatrix','_',option.out_File_Name];
    option.timeNumber_Matrix_Path = [option.mat_Path,'\','tnMatrix_',option.out_File_Name];           
    option.res_Output = [option.res_Path,'\','_numGallery',num2str(option.num_Gallery),option.out_File_Name];
end
