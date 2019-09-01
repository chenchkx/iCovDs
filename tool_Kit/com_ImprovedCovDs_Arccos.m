%   function [iCovDs, ~] = com_ImprovedCovDs_Arccos(block_Matrix,option,type_Block)
%   input : 
%         param 1 : block sample matrix
%         param 2 : the struct of parameters
%         param 3 : type for describing sub-image sets
%   output :
%         iCovDs: improved CovDs


function [iCovDs, salient_Matrix] = com_ImprovedCovDs_Arccos(block_Matrix,option,type_Block)
    [dim,~,num_Block] = size(block_Matrix);
    dim_LogDomain = (dim + 1)^2;
    iCovDs = zeros(num_Block,num_Block);
    salient_Matrix = zeros(num_Block,num_Block);
    for block_th = 1:num_Block
        current_Block = block_Matrix(:,:,block_th);      
        switch type_Block % representation for sub-image set
            case 'Gauss'
                current_Cov = embed_Gauss2SPD_Sim(current_Block,option);   
            case 'CovDs'
                current_Cov = embed_TraditionCovDs(current_Block,option); 
        end
%%     mean centralization operation
        log_current_Cov = logm(current_Cov);
        mean_C = mean(log_current_Cov,2);
        mean_R = mean(log_current_Cov,1);
        log_current_Cov = log_current_Cov + (1/(size(log_current_Cov,1)*size(log_current_Cov,1)))*mean2(log_current_Cov).*ones(size(log_current_Cov))...
            - 1/(size(log_current_Cov,1))*(repmat(mean_C,[1,size(log_current_Cov,2)]) + repmat(mean_R,[size(log_current_Cov,1),1]));
        log_Matrix(:,:,block_th) = log_current_Cov;
    end    
    switch option.kernel_Type
        case 'LogEk'    % Log-Euclidean Kernel
            vectors = reshape(log_Matrix, size(log_Matrix, 1) * size(log_Matrix, 2), size(log_Matrix, 3))';
            iCovDs= vectors*vectors';  
            vectors = bsxfun(@rdivide, vectors, sqrt(sum(vectors.^2, 2)));
            salient_Matrix = vectors*vectors';         
        case 'LogEk.Arc' % Log-Euclidean based Arc-cosine Kernel
            vectors = reshape(log_Matrix, size(log_Matrix, 1) * size(log_Matrix, 2), size(log_Matrix, 3));
            vectors_Fro = sqrt(sum(vectors.*vectors,1)); 
            inner_Matrix = vectors_Fro'*vectors_Fro;
            jtheta_Matrix0 = zeros(num_Block,num_Block); jtheta_Matrix1 = zeros(num_Block,num_Block);
            jtheta_Matrix2 = zeros(num_Block,num_Block); jtheta_Matrix3 = zeros(num_Block,num_Block);
            for i_th = 1:num_Block
                vector_I = vectors(:,i_th);
                norm_I = vectors_Fro(i_th);
                for j_th = i_th:num_Block
                    vector_J = vectors(:,j_th);
                    norm_J = vectors_Fro(j_th);                   
                    current_Theta = acos((vector_I'*vector_J)/(norm_I*norm_J));
                    sin_Theta = real(sin(current_Theta));
                    cos_Theta = real(cos(current_Theta));
%                     current_Theta_Temp = acos(trace(log_Matrix(:,:,i_th)*log_Matrix(:,:,j_th))/(norm(log_Matrix(:,:,i_th),'fro')*norm(log_Matrix(:,:,j_th),'fro')));
%                     sin_Theta_Tmp = real(sin(current_Theta_Temp));
%                     cos_Theta_Tmp = real(cos(current_Theta_Temp));
%%                J0(¦È) = ¦Ð - ¦È
                    if length(option.vector_W)>=1 && option.vector_W(1,1)~=0
                        jtheta_Matrix0(i_th,j_th) = pi - current_Theta;
                        jtheta_Matrix0(j_th,i_th) = jtheta_Matrix0(i_th,j_th);
                    end
%%                J1(¦È) = (¦Ð - ¦È) cos ¦È + sin¦È,
                    if length(option.vector_W)>=2 && option.vector_W(1,2)~=0
                        jtheta_Matrix1(i_th,j_th) = (pi - current_Theta)*cos_Theta - sin_Theta;
                        jtheta_Matrix1(j_th,i_th) = jtheta_Matrix1(i_th,j_th);
                    end
%%                J2(¦È) = (¦Ð - ¦È)(1 + 2 cos^2 ¦È) + 3sin¦È cos ¦È,
                    if length(option.vector_W)>=3 && option.vector_W(1,3)~=0
                        jtheta_Matrix2(i_th,j_th) = (pi - current_Theta)*(1 + 2*cos_Theta^2) + 3*sin_Theta*cos_Theta;
                        jtheta_Matrix2(j_th,i_th) = jtheta_Matrix2(i_th,j_th);
                    end
%%                J3(¦È) = (¦Ð - ¦È)(9 sin^2 ¦È cos ¦È + 15cos^3 ¦È) + 4sin^3 ¦È + 15sin¦È cos^2 ¦È.
                    if length(option.vector_W)>=4 && option.vector_W(1,4)~=0
                        jtheta_Matrix3(i_th,j_th) = (pi - current_Theta)*(9*sin_Theta^2*cos_Theta+15*cos_Theta^3) + 4*sin_Theta^3 + 15*sin_Theta*cos_Theta^2;
                        jtheta_Matrix3(j_th,i_th) = jtheta_Matrix3(i_th,j_th);
                    end
                end        
            end  
            jtheta_Matrix0 = real(jtheta_Matrix0);jtheta_Matrix1 = real(jtheta_Matrix1);
            jtheta_Matrix2 = real(jtheta_Matrix2);jtheta_Matrix3 = real(jtheta_Matrix3);
            k_Matrix0 = (1/pi)*inner_Matrix.^(0).*(jtheta_Matrix0); 
            k_Matrix1 = (1/pi)*inner_Matrix.^(1).*(jtheta_Matrix1); 
            k_Matrix2 = (1/pi)*inner_Matrix.^(2).*(jtheta_Matrix2); 
            k_Matrix3 = (1/pi)*inner_Matrix.^(3).*(jtheta_Matrix3); 
%%         OUTPUT REPRESENTATION
            iCovDs = option.vector_W(1,1)*k_Matrix0 + option.vector_W(1,2)*k_Matrix1 + option.vector_W(1,3)*k_Matrix2 + option.vector_W(1,4)*k_Matrix3; 
    end
end