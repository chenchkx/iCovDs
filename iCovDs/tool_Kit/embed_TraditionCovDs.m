%% function current_SPD = embed_TraditionCovDs(current_Feature,option)
%   input : 
%         param 1 : feature matrix
%         param 2 : the struct of parameters
%   output :
%         current_SPD: SPD representation via traditional CovDs

function current_SPD = embed_TraditionCovDs(current_Feature,option)
    temp_Cov = cov(current_Feature');
    [~,S] = eig(temp_Cov);
    [temp_min,~] = min(diag(S));
    if temp_min <= 10^(-9)
        current_Feature = current_Feature + rand(size(current_Feature));
        temp_Cov = cov(current_Feature');
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
    current_SPD = temp_Cov;
end
