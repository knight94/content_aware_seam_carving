function [I_resize] = HoriNewImage(I,H)
    [Y, X, Color] = size(I);
    I_resize = uint8(zeros(Y-1,X,Color));
    for j=1:X
        I_resize(:,j,:) = I([1:H(j)-1,H(j)+1:Y],j,:);
    end
end

