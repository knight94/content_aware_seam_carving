I = imread('../Images/Castle.jpg');
[Y, X, Color] = size(I);
%Reduce image Horizaontally by R amount
fprintf('Current Size of image : %d, %d.\n', Y, X);
NewC = input('New number of cols: ');
C = X-NewC;
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;

filename_gif = 'output_ver.gif';
[tempI] = RemoveVerSeam(I,C,etype,filename_gif,1);