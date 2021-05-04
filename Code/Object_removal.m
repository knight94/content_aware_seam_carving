I = imread('../Images/couple.png');
[Y, X, Color] = size(I);
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;
figure
imshow(I);
h = drawassisted();
mask = createMask(h);

%%for specifying important part
figure
imshow(I);
h = drawassisted();
mask1 = createMask(h);

dir = input('Use Vertical(2) or Horizontal(1) seam: ');
[E] = CalcEnergy(I, etype);
%Mark the pixel in the object to be removed with low negative energy
[E_acc] = EnergyAcc_object_removal(I, mask, dir, etype, mask1);

tempI = I;
tempmask = mask;
tempmask1 = mask1;
filename = 'object_remove.gif';
k = 1;
if dir == 1
    while sum(sum(tempmask > 0)) > 0
        [E_acc] = EnergyAcc_object_removal(tempI, tempmask, dir, etype, tempmask1);
        [H] = GetHoriSeam(E_acc);
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
        if k == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
            k = k + 1;
        else
            imwrite(A,map,filename,'gif','WriteMode','append');
        end
        [tempI] = HoriNewImage(tempI,H);
        [tempmask] = HoriNewmask(tempmask,H);
        [tempmask1] = HoriNewmask(tempmask1,H);
    end
    I_r = tempI;
    NewR = Y;
    [y, x, Color] = size(tempI); 
    K = NewR-y;

    H = zeros(K, x);
    for k = 1:K
        [E_acc] = EnergyAcc(tempI, 1, etype);
        [H(k,:)] = GetHoriSeam(E_acc);
        [tempI] = HoriNewImage(tempI,H(k,:));
    end
    figure;
    imshow(I_r);
    img1 = I_r;
    for i = 1:x
        for j = 1:K
            img1(H(j,i),i,1) = 255;
            img1(H(j,i),i,2) = 0;
            img1(H(j,i),i,3) = 0; 
        end
    end
    imshow(img1);

    [I_final] = InsertHoriSeam(I_r,H);
    figure
    imshow(I_final);
else
    while sum(sum(tempmask > 0)) > 0
        [E_acc] = EnergyAcc_object_removal(tempI, tempmask, dir, etype, tempmask1);
        [V] = GetVerSeam(E_acc);
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
        if k == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
            k = k+1;
        else
            imwrite(A,map,filename,'gif','WriteMode','append');
        end
        [tempI] = VerNewImage(tempI,V);
        [tempmask] = VerNewmask(tempmask,V);
        [tempmask1] = VerNewmask(tempmask1,V);
    end
    I_r = tempI;
    NewC = X;
    [y, x, Color] = size(tempI); 
    K = NewC-x;

    V = zeros(y, K);
    
    for k = 1:K
        [E_acc] = EnergyAcc(tempI, 2, etype);
        [V(:,k)] = GetVerSeam(E_acc);
        [tempI] = VerNewImage(tempI,V(:,k));
    end
    figure;
    imshow(I_r);
    img1 = I_r;
    for j = 1:y
        for i = 1:K
            img1(j,V(j,i),1) = 255;
            img1(j,V(j,i),2) = 0;
            img1(j,V(j,i),3) = 0;
        end
    end
    imshow(img1);

    [I_final] = InsertVerSeam(I_r,V);
    figure
    imshow(I_final);
end
figure
imshow(I)