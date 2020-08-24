function accuracy = Classify_NN_Stein(Train_Spd_Cell,Test_Spd_Cell,Opt)
Label_Train = Opt.Label_Train;
Label_Test = Opt.Label_Test;

Num_Train = length(Train_Spd_Cell);
Num_Test = length(Test_Spd_Cell);
Out_Label = zeros(1,Num_Test);

Dis_Stein = Compute_Stein_Metric(Train_Spd_Cell,Test_Spd_Cell);

for test_th = 1:Num_Test
    dis_th = Dis_Stein(test_th,:);
    [~,ind] = min(dis_th);
    Out_Label(1,test_th) = Label_Train(1,ind);
end
accuracy = sum((Out_Label - Label_Test) == 0)/size(Label_Test,2);