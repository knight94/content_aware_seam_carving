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
method = input('row-col(1) or col-row(2) or alternate(3):');
%Energy function to use 1-gradient, 2-HOG, 3-entropy
etype = 1;

if method == 1
    [tempHor] = RemoveHoriSeam(I,R,etype,'Method_1_hor.gif',1);
    [tempHorVer] = RemoveVerSeam(tempHor,C,etype,'Method_1_ver.gif',1);
    figure;
    imshow(tempHorVer);
elseif method == 2
    [tempVer] = RemoveVerSeam(I,C,etype,'Method_2_ver.gif',1);
    [tempVerHor] = RemoveHoriSeam(tempVer,R,etype,'Method_2_hor.gif',1);
    figure;
    imshow(tempVerHor);
else
    alternate = 1;
    tempalter = I;
    for i = 1:R+C
        if alternate == 1
            tempalter = RemoveVerSeam(tempalter,1,etype,'Method_3_ver.gif',0);
            alternate = 0;
        else
            alternate = 1;
            tempalter = RemoveHoriSeam(tempalter,1,etype,'Method_3_hor.gif',0);
        end
    end
    figure;
    imshow(tempalter);
end

figure;
imshow(I);


