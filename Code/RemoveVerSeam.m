function [tempI] = RemoveVerSeam(I,C,etype,filename_gif, showfig)
    [Y, X, Color] = size(I);

    if showfig == 1
        figure;
        imshow(I);
    end
    tempI = I;
%     filename = 'Output_ver.gif';
    for Vseams = 1:C
        [E_acc] = EnergyAcc(tempI, 2, etype);
        [V] = GetVerSeam(E_acc);

        if showfig == 1
            img1 = tempI;
            for y = 1:Y
                img1(y,V(y),1) = 255;
                img1(y,V(y),2) = 0;
                img1(y,V(y),3) = 0;    
            end
            imshow(img1);
            img_gif = uint8(zeros(Y,X,Color));
            img_gif(:,1:size(img1,2),1) = img1(:,:,1);
            img_gif(:,1:size(img1,2),2) = img1(:,:,2);
            img_gif(:,1:size(img1,2),3) = img1(:,:,3);
            [A,map] = rgb2ind(img_gif,256);
            if Vseams == 1
                imwrite(A,map,filename_gif,'gif','LoopCount',Inf,'DelayTime',1);
            else
                imwrite(A,map,filename_gif,'gif','WriteMode','append');
            end
        end
        [tempI] = VerNewImage(tempI,V);
    end
    if showfig == 1
        figure
        imshow(tempI);
        figure
        imshow(CalcEnergy(I, etype),[]);
    end
end

