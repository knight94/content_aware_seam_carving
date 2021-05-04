function [H] = GetHoriSeam(E_acc)
%     [E_acc] = EnergyAcc(I, 1, etype);
    [Y, X] = size(E_acc);
    H = zeros(1, X);
    [~, H(X)] = min(E_acc(:,X));
    
    for x = X-1:-1:1
        tempy = H(x+1);
        if(tempy == 1)
            [~, q] = min([E_acc(tempy,x), E_acc(tempy+1,x)]);
            H(x) = tempy + q - 1;
        elseif(tempy == Y)
            [~, q] = min([E_acc(tempy-1,x), E_acc(tempy,x)]);
            H(x) = tempy + q - 2;
        else
            [~, q] = min([E_acc(tempy-1,x), E_acc(tempy,x), E_acc(tempy+1,x)]);
            H(x) = tempy + q - 2;
        end
    end
end

