%%  computing Stein divergence: the geodesic distance between SPD matrices
%   Written by Kai-Xuan Chen (e-mail: kaixuan_chen_jsh@163.com)
%   version 2.0 -- December/2018 
%   version 1.0 -- June/2017 


function dis_Stein = compute_Stein_D(X,Y)
    t = log(det(0.5*(X+Y))) - 0.5* (log(det(X)) + log(det(Y)));
    if t == inf || isnan(t)
        eigX = eig(X);
        eigX (eigX <= 0) = eps;
        eigY = eig(Y);
        eigY (eigY <= 0) = eps;
        t = real(sum(log(eig(0.5*(X+Y))))) - 0.5 *(real(sum(log(eigX))) + real(sum(log(eigY))) );          
        %t = log(det(0.5*(X+Y))) - 0.5* (log(det(X)) + log(det(Y)));
    end
    dis_Stein = t;
end