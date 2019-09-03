%% function current_SPD = embed_Gauss2SPD(current_Feature,option)
%   input : 
%         param 1 : feature matrix
%         param 2 : the struct of parameters
%   output :
%         current_SPD: SPD representation via Gaussian embedding

function current_SPD = embed_Gauss2SPD_Sim(current_Feature,option)
        tmp_SPD = com_SPDGaussEmbedding(current_Feature,option.beta_Gauss);
        [~,S] = eig(tmp_SPD);
        [temp_min,~] = min(diag(S));
        if temp_min <= option.min_Eig_Gauss
            current_Feature = current_Feature + rand(size(current_Feature));
            tmp_SPD = com_SPDGaussEmbedding(current_Feature,option.beta_Gauss);
            [~,S] = eig(tmp_SPD);
            [temp_min,~] = min(diag(S));
            while temp_min <= option.min_Eig_Gauss
                tmp_SPD = tmp_SPD + option.min_Eig_Gauss*trace(tmp_SPD)*eye(size(tmp_SPD));
                [~,S] = eig(tmp_SPD);
                [temp_min,~] = min(diag(S));
            end 
        elseif norm(tmp_SPD,'fro') == 0 && trace(tmp_SPD) == 0
            tmp_SPD = eye(size(tmp_SPD));
        end 
        current_SPD = tmp_SPD;        
end

function tmp_SPD = com_SPDGaussEmbedding(current_Feature,beta)
        [d,~] = size(current_Feature);
        tmp_SPD = zeros(d+1,d+1);
        mean_Feature = mean(current_Feature,2);
        cov_Feature = cov(current_Feature');     
        tmp_SPD(1:d,1:d) = cov_Feature + beta^2.*mean_Feature*mean_Feature';
        tmp_SPD(1+d,1:d) = beta*mean_Feature;
        tmp_SPD(1:d,1+d) = beta*mean_Feature';
        tmp_SPD(1+d,1+d) = 1;
end
