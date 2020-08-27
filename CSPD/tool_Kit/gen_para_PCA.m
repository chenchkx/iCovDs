%% Genetating paramters of PCA files
% input:
%      option: paramters of dataset
% output:
%      para_PCA : paramters(projection matrix and eigvalues, etc.) of PCA for dataset
%% Coder: Kai-Xuan Chen
%% code completed on 2018.06.08

function para_PCA = gen_para_PCA(option)
    block_Num = option.num_Sqrt_Block^2;
    block_Row = option.row_Resize/option.num_Sqrt_Block;
    block_Col = option.col_Resize/option.num_Sqrt_Block;
    fea_Begin = 1; 
    cen_Begin = 1;
    for class_th = 1:option.num_Class
        data_Spd_Cell_th = 0;
        fprintf('Read data for Class :  %d \n',class_th); 
        current_Object_Folder = [option.root_Path,option.pre_Class,num2str(class_th),'\'];
        d = dir(current_Object_Folder);  
        isub = [d(:).isdir]; %# returns logical vector  
        nameFolds = {d(isub).name}';  
        nameFolds(ismember(nameFolds,{'.','..'})) = [];
        num_Sample = length(nameFolds);       
        for set_tr_th = 1:num_Sample
            data_Spd_Cell_th = data_Spd_Cell_th + 1;
            fprintf('Read data for Data_Spd_Cell_th :  %d   \n',data_Spd_Cell_th); 
            current_Folder = [option.root_Path,option.pre_Class,num2str(class_th),'\',option.pre_Set,num2str(set_tr_th),'\'];
            current_Pics = dir(strcat(current_Folder,'*',option.type_Image));
            current_Num = size(current_Pics,1);
            block_Matrix = zeros(block_Row*block_Col,current_Num*block_Num);
            temp_Feature = 1;
            for sam_th = 1:current_Num
                Sample_th = imread([current_Folder,current_Pics(sam_th,1).name]);
                if size(Sample_th,3) == 3
                    Sample_th = rgb2gray(imresize(Sample_th,[option.row_Resize option.col_Resize]));
                end            
                Sample_th = imresize(Sample_th,[option.row_Resize option.col_Resize]);
                for blo_th = 1:block_Num
                    X = mod(blo_th,sqrt(block_Num));
                    if X == 0
                        X = sqrt(block_Num);
                    end
                    Y = fix((blo_th - 1)/sqrt(block_Num)) + 1;
                    X_Start = 1 + block_Row*(X-1);
                    Y_Start = 1 + block_Col*(Y-1);
                    block_Matrix(:,temp_Feature) = reshape(Sample_th(X_Start:X_Start-1+block_Row,Y_Start:Y_Start-1+block_Col),block_Row*block_Col,1);
                    temp_Feature = temp_Feature + 1;
               end                                   
            end 
            block_Matrix = block_Matrix/255;
            [dim,num_Feature] = size(block_Matrix);
            random_Ind = randperm(num_Feature);
            num_Selected = fix(num_Feature*option.train_Rate);
            fea_End = fea_Begin + num_Selected - 1;
            train_Matrix(1:dim,fea_Begin:fea_End) = block_Matrix(:,random_Ind(1:num_Selected));
            fea_Begin = fea_End + 1;            
        end 
    end
    fprintf('-------  compute codebook  ---- PCA + Whitening  ----\n');
    mean_Feature = mean(train_Matrix,2);
    train_Matrix = train_Matrix - repmat(mean_Feature, 1, size(train_Matrix, 2));
    cov_Matrix = train_Matrix*train_Matrix'/size(train_Matrix,2);
    [feature_U,feature_S,~] = svd(cov_Matrix);
%%  para of PCA + Whitening 
    para_PCA.mean_Feature = mean_Feature;
    para_PCA.feature_U = feature_U;
    para_PCA.feature_S = feature_S;
    name_PCAParam = ['.\tool_Mat\','para_PCA','_',option.name_Dataset,'_typeBlock',num2str(option.num_Sqrt_Block),'_size',num2str(option.row_Resize),'.mat'];
    save(name_PCAParam,'para_PCA');
    
    varlist = {'mean_Feature','feature_U','feature_S','feature_K','train_Matrix','cov_Matrix','feature_xPCAwhite'};
    clear(varlist{:});
end