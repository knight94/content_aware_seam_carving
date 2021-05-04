function [V] = GetVerSeam(E_acc)
%     [E_acc] = EnergyAcc(I, 2, etype);
    [Y, X] = size(E_acc);
    V = zeros(Y, 1);
    [~, V(Y)] = min(E_acc(Y,:));
    
    for y = Y-1:-1:1
        tempx = V(y+1);
        if(tempx == 1)
            [~, q] = min([E_acc(y, tempx), E_acc(y, tempx+1)]);
            V(y) = tempx + q - 1;
        elseif(tempx == X)
            [~, q] = min([E_acc(y, tempx-1), E_acc(y, tempx)]);
            V(y) = tempx + q - 2;
        else
            [~, q] = min([E_acc(y, tempx-1), E_acc(y, tempx), E_acc(y, tempx+1)]);
            V(y) = tempx + q - 2;
        end
    end
end