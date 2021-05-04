function seams_data = RunHoriSeamCarve(I, C) 
% I = imread('../Images/baekdu.jpg');
% I = imread('../Images/balloon.png');
[Y, X, Color] = size(I);
%Reduce image vertically by C amount
fprintf('Current Size of image : %d, %d.\n', Y, X);
% NewC = input('New number of rows: ');
% C = Y-NewC;
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;

figure;
imshow(I);
tempI = I;
filename = 'Output_hor.gif';
seams_data = cell(1,C);
for Hseams = 1:C
    [E_acc] = EnergyAcc(tempI, 1, etype);
    [H] = GetHoriSeam(E_acc);
    seams_data{Hseams} = H;
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
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append');
    end
    [tempI] = HoriNewImage(tempI,H);
end
% disp(size(tempI));
figure
imshow(tempI./255);
figure;
imshow(CalcEnergy(I, etype),[]);
end 