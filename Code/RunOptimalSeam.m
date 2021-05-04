% clear all; clc;
I = imread('../Images/butterfly_1.jpg');
if (size(I,1) > 700)
    I = imresize(I, [700 NaN]);
end
[Y, X, Color] = size(I);
%Reduce image Horizaontally by R amount
fprintf('Current Size of image : %d, %d.\n', Y, X);
NewR = input('New number of rows: ');
R = Y-NewR;
NewC = input('New number of cols: ');
C = X-NewC;
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;

[finalImage, T, Index_T] = OptimalCarve_mem_improved(I, NewR, NewC, etype);

figure;
imshow(I);
figure;
imshow(finalImage);
figure;
imshow(T, []);
figure;
imshow(Index_T, []);