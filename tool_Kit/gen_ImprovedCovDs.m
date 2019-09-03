%% Genetating the Improved CovDs
%% Author: Kai-Xuan Chen

% function [cov_Improve_CovDs,log_Improve_CovDs] = gen_ImprovedCovDs(option,type_Block)
%   input : 
%         param 1 : the struct of parameters  
%         param 2 : the descriptions of sub-image sets: {Gauss,CovDs}
%                   CovDs/Gauss: represent sub-image sets by traditional CovDs/Gaussian model
%   output:
%         cov_Improve_CovDs : SPD representation
%         log_Improve_CovDs : logarithm matrix representation of SPD

function [cov_Improve_CovDs,log_Improve_CovDs] = gen_ImprovedCovDs(option,type_Block)
    sample_Ind_Matrix = repmat([1:option.num_Sample],option.num_Class,1);
    output_Path = option.output_Path;
    if exist(output_Path,'file')
        cov_Improve_CovDs = []; log_Improve_CovDs = [];
        return;
    end
    [block_Location_Matrix,block_Num] = get_Block_Information(option);  % get the information of blocks
    time_Matrix = zeros(option.num_Class,option.num_Sample);
    for class_th = 1:option.num_Class
        data_Spd_Cell_th = 0;
        fprintf('Read data for Class :  %d \n',class_th); 
        current_Object_Folder = [option.root_Path,option.pre_Class,num2str(class_th),'\'];
        
        for set_th = 1:option.num_Sample
            data_Spd_Cell_th = data_Spd_Cell_th + 1;
            fprintf('Read data for %d_th set, named:  %s \n',set_th,num2str(sample_Ind_Matrix(class_th,1)+set_th - 1)); 
%             fprintf('Read data for Data_Spd_Cell_th :  %d   \n',data_Spd_Cell_th); 
            current_Folder = [current_Object_Folder,option.pre_Set,num2str(sample_Ind_Matrix(class_th,1)+ set_th - 1),'\'];
            current_Pics = dir(strcat(current_Folder,'*',option.type_Image));
            current_Num = size(current_Pics,1);
            current_Set_Matrix = zeros(option.resized_Row,option.resized_Col,current_Num);
            block_Matrix = zeros(option.block_Row*option.block_Col,current_Num,block_Num);
            for sam_th = 1:current_Num
                Sample_th = imread([current_Folder,current_Pics(sam_th,1).name]);
                if size(Sample_th,3) == 3
                    Sample_th = rgb2gray(imresize(Sample_th,[option.resized_Row option.resized_Col]));
                end            
                Sample_th = imresize(Sample_th,[option.resized_Row option.resized_Col]);
                current_Set_Matrix(:,:,sam_th) = Sample_th;         % current image saple                                           
            end 
            for block_th = 1:block_Num
                x_TopLeft = block_Location_Matrix(1,block_th);      % Upper left corner of block
                y_TopLet = block_Location_Matrix(2,block_th);       % Upper left corner of block
                current_BlockMatrix = current_Set_Matrix(x_TopLeft:x_TopLeft+option.block_Row-1,y_TopLet:y_TopLet+option.block_Col-1,:);
                block_Matrix(:,:,block_th) = reshape(current_BlockMatrix,[option.block_Row*option.block_Col,current_Num]);
            end
            tic;
            Improve_CovDs = com_ImprovedCovDs(block_Matrix,option,type_Block);
            time_Matrix(class_th,set_th) = toc;
            cov_Improve_CovDs{class_th,set_th} =  Improve_CovDs;
            log_Improve_CovDs{class_th,set_th} =  real(logm(Improve_CovDs));
            inv_Improve_CovDs{class_th,set_th} =  Improve_CovDs^(-1);
        end 
    end
    if ~exist(option.mat_Path,'dir') 
         mkdir(option.mat_Path)        
    end  
    
    save(output_Path,'cov_Improve_CovDs','log_Improve_CovDs','inv_Improve_CovDs','time_Matrix')
end