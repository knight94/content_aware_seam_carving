I = imread('../Images/Beach.png');
[Y, X, Color] = size(I);
%Reduce image Horizaontally by R amount
fprintf('Current Size of image : %d, %d.\n', Y, X);
NewC = input('New number of rows: ');
K = NewC-Y;
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;

H = zeros(K, X);

tempI = I;
for k = 1:K
    [E_acc] = EnergyAcc(tempI, 1, etype);
    [H(k,:)] = GetHoriSeam(E_acc);
    [tempI] = HoriNewImage(tempI,H(k,:));
end
figure;
imshow(I);
img1 = I;
for i = 1:X
    for j = 1:K
        img1(H(j,i),i,1) = 255;
        img1(H(j,i),i,2) = 0;
        img1(H(j,i),i,3) = 0;
    end
end
imshow(img1);

figure
[I_final] = InsertHoriSeam(I,H);
figure
imshow(I_final);