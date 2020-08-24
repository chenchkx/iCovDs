function [current_Block,feature_K] = process_PCA(current_Block,dim,para_PCA,option)
%%        PCA + whitening
    if option.if_PCA     
        switch option.type_PCA
            case 'topK_PCA' 
                feature_K = option.topK_PCA;
                current_Block = current_Block - repmat(para_PCA.mean_Feature, 1, size(current_Block, 2));
                feature_xPCAwhite = diag(1./sqrt(diag(para_PCA.feature_S) + eps)) * para_PCA.feature_U' * current_Block;
                current_Block = feature_xPCAwhite(1:feature_K,:);                  
            case 'rate_PCA'
                feature_K = gen_principal_components(para_PCA.feature_S,option.rate_PCA);
                current_Block = current_Block - repmat(para_PCA.mean_Feature, 1, size(current_Block, 2));
                feature_xPCAwhite = diag(1./sqrt(diag(para_PCA.feature_S) + eps)) * para_PCA.feature_U' * current_Block;
                current_Block = feature_xPCAwhite(1:feature_K,:);                  
        end   
    else
        feature_K = dim;
    end

end