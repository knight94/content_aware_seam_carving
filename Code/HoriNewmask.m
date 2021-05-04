function [I_resize] = HoriNewmask(mask,H)
    [Y, X] = size(mask);
    I_resize = logical(zeros(Y-1,X));
    for j=1:X
        I_resize(:,j) = mask([1:H(j)-1,H(j)+1:Y],j);
    end
end

