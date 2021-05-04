function [tempI] = RemoveHoriSeam(I,R,etype,filename_gif, showfig)
    [Y, X, Color] = size(I);

    if showfig == 1
        figure
        imshow(I);
    end
    tempI = I;
    for Hseams = 1:R
        [E_acc] = EnergyAcc(tempI, 1, etype);
        [H] = GetHoriSeam(E_acc);
        if showfig == 1
            img1 = tempI;
            for x = 1:X
                img1(H(x),x,1) = 255;
                img1(H(x),x,2) = 0;
                img1(H(x),x,3) = 0;    
            end
            imshow(img1);
            img_gif = uint8(zeros(Y,X,Color));
            img_gif(1:size(img1,1),:,1) = img1(:,:,1);
            img_gif(1:size(img1,1),:,2) = img1(:,:,2);
            img_gif(1:size(img1,1),:,3) = img1(:,:,3);
            [A,map] = rgb2ind(img_gif,256);
            if Hseams == 1
                imwrite(A,map,filename_gif,'gif','LoopCount',Inf,'DelayTime',1);
            else
                imwrite(A,map,filename_gif,'gif','WriteMode','append');
            end
        end
        [tempI] = HoriNewImage(tempI,H);
    end
    if showfig == 1
        figure
        imshow(tempI);
        figure
        imshow(CalcEnergy(I, etype),[]);
    end
end

