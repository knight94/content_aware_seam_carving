I = imread('../Images/Dolpin.png');
[Y, X, Color] = size(I);
%Reduce image Horizaontally by R amount
fprintf('Current Size of image : %d, %d.\n', Y, X);
NewR = input('New number of cols: ');
K = NewR-X;
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;

V = zeros(Y, K);

tempI = I;
for k = 1:K
    [E_acc] = EnergyAcc(tempI, 2, etype);
    [V(:,k)] = GetVerSeam(E_acc);
    [tempI] = VerNewImage(tempI,V(:,k));
end
figure;
imshow(I);
img1 = I;
for j = 1:Y
    for i = 1:K
        img1(j,V(j,i),1) = 255;
        img1(j,V(j,i),2) = 0;
        img1(j,V(j,i),3) = 0;
    end
end
imshow(img1);

figure
[I_final] = InsertVerSeam(I,V);
figure
imshow(I_final);
