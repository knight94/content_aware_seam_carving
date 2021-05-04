I = imread('../Images/beach.png');
[Y, X, Color] = size(I);
%Reduce image vertically by C amount
fprintf('Current Size of image : %d, %d.\n', Y, X);
NewR = input('New number of rows: ');
R = Y-NewR;
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;


filename_gif = 'Output_hor.gif';
[tempI] = RemoveHoriSeam(I,R,etype,filename_gif,1);