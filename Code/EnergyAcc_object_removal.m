function [E_acc] = EnergyAcc_object_removal(I, mask, Sdir, etype, mask_p)
	[E] = CalcEnergy(I, etype);
    E(mask) = -10000;
    E(mask_p) = 10000;
    E_acc = E;
    switch Sdir
        %For horiSeam
        case 1
            for x = 2:size(E, 2)
                for y = 1:size(E, 1)
                    if (y == 1)
                        E_acc(y,x) = E(y,x) + min([E_acc(y,x-1), E_acc(y+1,x-1)]);
                    elseif (y == size(E,1))
                        E_acc(y,x) = E(y,x) + min([E_acc(y,x-1), E_acc(y-1,x-1)]);
                    else
                        E_acc(y,x) = E(y,x) + min([E_acc(y-1,x-1), E_acc(y,x-1), E_acc(y+1,x-1)]);
                    end
                end
            end
        %For VerSeam
        case 2
            for y = 2:size(E, 1)
                for x = 1:size(E, 2)
                    if (x == 1)
                        E_acc(y,x) = E(y,x) + min([E_acc(y-1,x), E_acc(y-1,x+1)]);
                    elseif (x == size(E,2))
                        E_acc(y,x) = E(y,x) + min([E_acc(y-1,x), E_acc(y-1,x-1)]);
                    else
                        E_acc(y,x) = E(y,x) + min([E_acc(y-1,x-1), E_acc(y-1,x), E_acc(y-1,x+1)]);
                    end
                end
            end
    end
end

