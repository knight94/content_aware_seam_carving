function [E] = CalcEnergy(I, type)
    if ~exist('type','var')
     % Defualt type to gradient
      type = 1;
    end
    if ( size(I,3) == 3)
        I = rgb2gray(I);
    end
    switch type
        case 1
%             [E, ~] = imgradient(I);
            [Ix,Iy] = imgradientxy(I);
            E = abs(Ix) + abs(Iy);
        case 2
            [Ix,Iy] = imgradientxy(I);
            E = (abs(Ix) + abs(Iy))./ max(extractHOGFeatures(I, 'NumBins', 8, 'CellSize', [11 11]));
        case 3
            E = entropyfilt(I);
    end
end

