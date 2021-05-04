function [I_resize] = VerNewImage(I,V)
    [Y, X, Color] = size(I);
    I_resize = uint8(zeros(Y,X-1,Color));
    for i=1:Y
        I_resize(i,:,:) = I(i,[1:V(i)-1,V(i)+1:X],:);
    end
end

