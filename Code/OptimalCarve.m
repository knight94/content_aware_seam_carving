function [finalImage, T, Index_T] = OptimalCarve(I, newrows, newcols, etype)
    img = I;
    [Y, X, ~] = size(img);
    r = Y-newrows;
    c = X-newcols;
    T = zeros(r+1,c+1);
    Index_T = zeros(r+1,c+1);
%     Img_T = cell(r+1,c+1);
    TempI_h = img;
    TempI_v = img;
    
    for i = 0:r
        for j = 0:c
            if (i == 0)
                if (j == 0)
                    T(i+1,j+1) = 0;
                    Index_T(i+1,j+1) = 0;
                    TempI_h = img;
                    TempI_v = img;
                else
                    tempI = TempI_v;
                    [E_acc] = EnergyAcc(tempI, 2, etype);
                    [n,~,~] = size(tempI);
                    [v] = GetVerSeam(E_acc);
                    [~, indmin] = min(E_acc(n,:));
                    T(i+1,j+1) = T(i+1, j) + E_acc(n,indmin);
                    Index_T(i+1,j+1) = 0;
%                     Img_T{i+1,j+1} = VerNewImage(tempI,v);
                    TempI_v = VerNewImage(tempI,v);
                end
            else
                if (j == 0)
%                     tempI = Img_T{i, j+1};
                    tempI = TempI_h;
                    [E_acc] = EnergyAcc(tempI, 1, etype);
                    [~,m,~] = size(tempI);
                    [h] = GetHoriSeam(E_acc);
                    [~, indmin] = min(E_acc(:,m));
                    T(i+1,j+1) = T(i, j+1) + E_acc(indmin,m);
                    Index_T(i+1,j+1) = 1;
%                     Img_T{i+1,j+1} = HoriNewImage(tempI,h);
                    TempI_h = VerNewImage(tempI,v);
                else
%                     tempI = Img_T{i+1, j};
                    tempIv = TempI_v;
                    [E_acc] = EnergyAcc(tempI, 2, etype);
                    [n,~,~] = size(tempI);
                    [~, indminr] = min(E_acc(n,:));
                    E_Ver = E_acc(n, indminr);
                    
                    tempIh = TempI_h;
                    [E_acc] = EnergyAcc(tempI, 1, etype);
                    [~,m,~] = size(tempI);
                    [~, indminc] = min(E_acc(:,m));
                    E_Hor = E_acc(indminc, m);
                    
                    if ((T(i,j+1)+E_Hor) < (T(i+1,j)+E_Ver))
                        [h] = GetHoriSeam(E_acc);
                        T(i+1,j+1) = T(i, j+1) + E_Hor;
                        Index_T(i+1,j+1) = 1;
%                         Img_T{i+1,j+1} = HoriNewImage(tempIh,h);
                        Img_T{i+1,j+1} = HoriNewImage(tempIh,h);
                    else
                        [v] = GetVerSeam(E_acc);
                        T(i+1,j+1) = T(i+1, j) + E_Ver;
                        Index_T(i+1,j+1) = 0;
%                         Img_T{i+1,j+1} = VerNewImage(tempIv,v);
                        Img_T{i+1,j+1} = VerNewImage(tempIv,v);
                    end
                end
            end
        end
    end
    finalImage = Img_T{r+1,c+1};
end

