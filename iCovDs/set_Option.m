%% set option for deifferent dataset
%% Author: Kai-Xuan Chen 
%% Email: kaixuan_chen_jsh@163.com

function option = set_Option(name)
    addpath(genpath('tool_Kit'));
    addpath(genpath('CDL')); 
    addpath(genpath('LogEK_SR'));
    addpath(genpath('Classify_NN'));
    switch name
        case 'ETH'
            option.root_Path = '.\ETH-80\'; % rootpath of dataset in your computer
            option.mat_Path = '.\data\mat_ETH';                                 % relative path of Riemannian CovDs 
            option.res_Path = '.\data\res_ETH';                                 % relative path of dot mat files of accuracies 
            option.name_Dataset = 'ETH';                                        % relative path of Riemannian CovDs 
            option.num_Ite = 100;                                               % number of experiment iterations 
            option.num_Class = 8;                                               % number of categories
            option.num_Sample = 10;                                             % number of sample in each class
            option.num_Gallery = 5;                                             % number of gallery sample
            option.num_Probe = option.num_Sample - option.num_Gallery;          % number of probe sample
            option.label_Gallery = reshape(ones(option.num_Gallery,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Gallery]);
                                                                                % label of gallery sample
            option.label_Probe = reshape(ones(option.num_Probe,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Probe]);
                                                                                % label of probe sample
            option.type_Image = '.png';                                         % suffix of images
            option.train_Rate = 1;                                              % this train_Rate for PCA
            option.if_PCA = 0;                                                  % 1£ºPCA  0£º PCA unnecessary
            option.type_PCA = 'topK_PCA';                                       % param{'rate_PCA','topK_PCA'}
            option.rate_PCA = 0.99;                                             % energy need to be retained for 'rate_PCA'
            option.topK_PCA = 15;                                               % components need to be retained for 'topK_PCA'
            option.resized_Row = 24;
            option.resized_Col = 24;
            option.block_Row = 6;
            option.block_Col = 6;
            option.step_Row = 2;
            option.step_Col = 2;  
            option.pre_Set = '';                                                % prefix string of each image set  
            option.pre_Class = '';                                              % prefic string of each class
            option.LogEK_N = 1;                                                 % paramter for LogEKSR
            option.beta_Gauss = 0.9;                                            % param of Gaussian embedding
            option.min_Eig_iCovDs = 10^(-9);                                     % param for perturbation lamada when using CovDs for sub-image sets
            option.min_Eig_Gauss = 10^(-9);                                     % param for perturbation lamada when using Gaussian embedding for sub-image sets
            option.if_JudgeiCovDsEig = 1;       
            option.order = 3;                                                   % param : 0,1,2,3,... 
            option.latentDim_PLS = option.num_Class + 1;
            option.kernel_Type = 'LogEk.Arc';                                   % param: {LogEk,LogEk.Arc}     
            option.vector_W = [1;0;1;0]';
        case 'MDSD'
            option.root_Path = 'E:\WORKSPACE\DATASET\MDSD\';
            option.mat_Path = '.\data\mat_MDSD';
            option.res_Path = '.\data\res_MDSD';
            option.name_Dataset = 'MDSD';
            option.num_Ite = 100;
            option.num_Class = 13;
            option.num_Sample = 10;
            option.num_Gallery = 7;
            option.num_Probe = option.num_Sample - option.num_Gallery;
            option.label_Gallery = reshape(ones(option.num_Gallery,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Gallery]);
            option.label_Probe = reshape(ones(option.num_Probe,option.num_Class)*diag([1:option.num_Class]),[1,option.num_Class*option.num_Probe]);
            option.type_Image = '.jpg';
            option.train_Rate = 1;  
            option.if_PCA = 0; 
            option.type_PCA = 'topK_PCA';
            option.rate_PCA = 0.99; 
            option.topK_PCA = 12; 
            option.resized_Row = 24;
            option.resized_Col = 24;
            option.block_Row = 8;
            option.block_Col = 8;
            option.step_Row = 8;
            option.step_Col = 8;  
            option.pre_Set = 's';
            option.pre_Class = 'C';
            option.LogEK_N = 1;
            option.beta_Gauss = 2;
            option.min_Eig_iCovDs = 10^(-9);
            option.min_Eig_Gauss = 10^(-9);
            option.if_JudgeiCovDsEig = 1;
            option.order = 3;                                                    
            option.latentDim_PLS = option.num_Class + 1;
            option.kernel_Type = 'LogEk.Arc';
            option.vector_W = [1;0;1;0]';
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
            option.block_Row = 8;
            option.block_Col = 8;
            option.step_Row = 8;
            option.step_Col = 8;  
            option.pre_Set = '';
            option.pre_Class = '';
            option.LogEK_N = 1;
            option.beta_Gauss = 14;
            option.min_Eig_iCovDs = 8.5*10^(-7);
            option.min_Eig_Gauss = 8.5*10^(-7);
            option.if_JudgeiCovDsEig = 1;
            option.order = 3;                                                    
            option.latentDim_PLS = option.num_Class + 1;
            option.kernel_Type = 'LogEk.Arc';
            option.vector_W = [1;1;0;0]';
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
            option.block_Row = 9;
            option.block_Col = 9;
            option.step_Row = 5;
            option.step_Col = 5; 
            option.pre_Set = 's';
            option.pre_Class = '';    
            option.LogEK_N = 1;       
            option.beta_Gauss = 0.05;
            option.min_Eig_iCovDs = 10^(-7);
            option.min_Eig_Gauss = 10^(-7);
            option.if_JudgeiCovDsEig = 1;
            option.order = 3;                                                    
            option.latentDim_PLS = option.num_Class + 1;
            option.kernel_Type = 'LogEk.Arc';
            option.vector_W = [1;0;0;0]';
    end
    option.out_File_Name = [option.name_Dataset,'_resized',num2str(option.resized_Row),'M',num2str(option.resized_Col),'_blockSize',...
        num2str(option.block_Row),'M',num2str(option.block_Col),'_stepSize',num2str(option.step_Row),'M',num2str(option.step_Col),...
        '_arcKerOrder',num2str(option.order),'_betaGau',num2str(option.beta_Gauss),'_minEGau',num2str(option.min_Eig_Gauss),'_minEiCovDs',num2str(option.min_Eig_iCovDs),'.mat'];
    option.output_Path = [option.mat_Path,'\',option.out_File_Name];
    option.dis_Matrix_Path = [option.mat_Path,'\','disMatrix','_',option.name_Dataset,'_resized',num2str(option.resized_Row),'M',num2str(option.resized_Col),...
        '_blockSize',num2str(option.block_Row),'M',num2str(option.block_Col),'_stepSize',num2str(option.step_Row),'M',num2str(option.step_Col),...
        '_arcKerOrder',num2str(option.order),'_betaGau',num2str(option.beta_Gauss),'_minEGau',num2str(option.min_Eig_Gauss),'_minEiCovDs',num2str(option.min_Eig_iCovDs),'.mat'];
    option.timeNumber_Matrix_Path = [option.mat_Path,'\','tnMatrix_',option.name_Dataset,'_resized',num2str(option.resized_Row),'M',num2str(option.resized_Col),...
        '_blockSize',num2str(option.block_Row),'M',num2str(option.block_Col),'_stepSize',num2str(option.step_Row),'M',num2str(option.step_Col),...
        '_arcKerOrder',num2str(option.order),'_betaGau',num2str(option.beta_Gauss),'_minEGau',num2str(option.min_Eig_Gauss),'_minEiCovDs',num2str(option.min_Eig_iCovDs),'.mat'];           
    option.res_Output = [option.res_Path,'\',option.name_Dataset,'_numGallery',num2str(option.num_Gallery),'_resized',num2str(option.resized_Row),'M',num2str(option.resized_Col),'_blockSize',...
        num2str(option.block_Row),'M',num2str(option.block_Col),'_stepSize',num2str(option.step_Row),'M',num2str(option.step_Col),...
        '_arcKerOrder',num2str(option.order),'_betaGau',num2str(option.beta_Gauss),'_minEGau',num2str(option.min_Eig_Gauss),'_minEiCovDs',num2str(option.min_Eig_iCovDs),'.mat'];
end