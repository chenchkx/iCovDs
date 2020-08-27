%% Author: Kai-Xuan Chen
%% function sample_Matrix = trans_Data(data_Cell)
%   input : 
%         param 1 : the cell of data 
%   output :
%         sample_Matrix: data matrix

function sample_Matrix = trans_Data(data_Cell)
    num_Cell = length(data_Cell);
    [d,~] =size(data_Cell{1,1});
    sample_Matrix = zeros(d,d,num_Cell);
    for i = 1:num_Cell
        sample_Matrix(:,:,i) = data_Cell{i};        
    end
    sample_Matrix = reshape(sample_Matrix,[size(sample_Matrix,1)*size(sample_Matrix,2),num_Cell]);
end