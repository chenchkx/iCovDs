function k = gen_principal_components(temp_S,rate)
    temp_S = diag(temp_S);
    total_Var = sum(temp_S);
    temp = 0;
    for i=1:length(temp_S)
        temp = temp + temp_S(i);
        if (temp/total_Var) >= rate
           break; 
        end
    end   
    k = i;
end