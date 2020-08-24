%% Genetating improved CovDs
%   Author: Kai-Xuan Chen

%   function final_ImprovedCovDs = com_ImprovedCovDs(block_Matrix,option,type_Block)
%   input : 
%         param 1 : block sample matrix
%         param 2 : the struct of parameters
%         param 3 : type for describing sub-image sets
%   output :
%         final_ImprovedCovDs: improved CovDs

function final_ImprovedCovDs = com_ImprovedCovDs(block_Matrix,option,type_Block)
  
    [ImprovedCovDs, ~] = com_ImprovedCovDs_Arccos(block_Matrix,option,type_Block);  %  Compute ImprovedCovDs  
    if option.if_JudgeiCovDsEig
        [~,S] = eig(ImprovedCovDs);
        [temp_min,~] = min(diag(S));
        while temp_min <= option.min_Eig_iCovDs
            ImprovedCovDs = ImprovedCovDs + (option.min_Eig_iCovDs)*trace(ImprovedCovDs)*eye(size(ImprovedCovDs));
            [~,S] = eig(ImprovedCovDs);
            [temp_min,~] = min(diag(S));
        end
    else
        ImprovedCovDs = ImprovedCovDs + (option.min_Eig_iCovDs)*trace(ImprovedCovDs)*eye(size(ImprovedCovDs));       
    end
%%  THE RESULTING REPRESENTATION
    final_ImprovedCovDs = ImprovedCovDs;
end