function seams_data = RunVertSeamCarve(I, R) 
%     I = imread(impath);
    [Y, X, Color] = size(I);
    %Reduce image Horizaontally by R amount
    fprintf('Current Size of image : %d, %d.\n', Y, X);
%     NewR = input('New number of cols: ');
%     R = X-NewR;
    %Energy function to use 1-gradient, 2-HOG, 3-entropy
    etype = 1;

    figure;
    imshow(I);
    tempI = I;
    filename = 'Output_ver.gif';
    seams_data = cell(1,R);
    for Vseams = 1:R
        [E_acc] = EnergyAcc(tempI, 2, etype);
        [V] = GetVerSeam(E_acc);
        seams_data{Vseams} = V;
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
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
        else
            imwrite(A,map,filename,'gif','WriteMode','append');
        end
        [tempI] = VerNewImage(tempI,V);
    end
    figure
    imshow(tempI);
    figure
    imshow(CalcEnergy(I, etype),[]);
end 