function [I_resize] = VerNewmask(mask,V)
    [Y, X] = size(mask);
    I_resize = logical(zeros(Y,X-1));
    for i=1:Y
        I_resize(i,:) = mask(i,[1:V(i)-1,V(i)+1:X]);
    end
end

