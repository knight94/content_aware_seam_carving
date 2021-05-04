function [finalImage, T, Index_T] = OptimalCarve_mem_improved(I, newrows, newcols, etype)
    img = I;
    [Y, X, ~] = size(img);
    r = Y-newrows;
    c = X-newcols;
    T = zeros(r+1,c+1);
    Index_T = zeros(r+1,c+1);
    Img_T_p = cell(r+1,c+1);
    Img_T_n = cell(r+1,c+1);
    Img_T_p{1} = img;
    Img_sz_T = cell(r+1,c+1);
    
    for line = 1:r+c+1
        first = max([0, line-r-1]);
%         left = 1;
%         top = 1;
        for j_i = 0:min([line, c+1-first, r+1])-1
            i = min([r+1, line])-j_i-1;
            j = first+j_i;
%             disp(i+","+j)
%             disp("lol"+left+","+top)
            if (i == 0)
                if (j == 0)
                    T(i+1,j+1) = 0;
                    Index_T(i+1,j+1) = 0;
                    Img_T_n{i+1,j+1} = img;
                    Img_sz_T{i+1,j+1} = size(img);
                    left = 1;
                    top = 1;
                else
                    tempI = Img_T_p{i+1,j};
                    left = left+1;
                    [E_acc] = EnergyAcc(tempI, 2, etype);
                    [n,~,~] = size(tempI);
                    [v] = GetVerSeam(E_acc);
                    [~, indmin] = min(E_acc(n,:));
                    T(i+1,j+1) = T(i+1, j) + E_acc(n,indmin);
                    Index_T(i+1,j+1) = 0;
%                     Img_T{i+1,j+1} = VerNewImage(tempI,v);
                    Img_T_n{i+1,j+1} = VerNewImage(tempI,v);
                    Img_sz_T{i+1,j+1} = size(Img_T_n{i+1,j+1});
                end
            else
                if (j == 0)
%                     tempI = Img_T{i, j+1};
                    tempI = Img_T_p{i, j+1};
                    top = top + 1;
                    [E_acc] = EnergyAcc(tempI, 1, etype);
                    [~,m,~] = size(tempI);
                    [h] = GetHoriSeam(E_acc);
                    [~, indmin] = min(E_acc(:,m));
                    T(i+1,j+1) = T(i, j+1) + E_acc(indmin,m);
                    Index_T(i+1,j+1) = 1;
%                     Img_T{i+1,j+1} = HoriNewImage(tempI,h);
                    Img_T_n{i+1,j+1} = HoriNewImage(tempI,h);
                    Img_sz_T{i+1,j+1} = size(Img_T_n{i+1,j+1});
                else
%                     tempI = Img_T{i+1, j};
                    tempIv = Img_T_p{i+1,j};
                    left = left + 1;
                    [E_acc] = EnergyAcc(tempIv, 2, etype);
                    [n,~,~] = size(tempIv);
                    [~, indminr] = min(E_acc(n,:));
                    E_Ver = E_acc(n, indminr);
                    
                    tempIh = Img_T_p{i,j+1};
                    top = top+1;
                    [E_acc] = EnergyAcc(tempIh, 1, etype);
                    [~,m,~] = size(tempIh);
                    [~, indminc] = min(E_acc(:,m));
                    E_Hor = E_acc(indminc, m);
                    
                    if ((T(i,j+1)+E_Hor) < (T(i+1,j)+E_Ver))
                        [h] = GetHoriSeam(E_acc);
                        T(i+1,j+1) = T(i, j+1) + E_Hor;
                        Index_T(i+1,j+1) = 1;
%                         Img_T{i+1,j+1} = HoriNewImage(tempIh,h);
                        Img_T_n{i+1,j+1} = HoriNewImage(tempIh,h);
                        Img_sz_T{i+1,j+1} = size(Img_T_n{i+1,j+1});
                    else
                        [v] = GetVerSeam(E_acc);
                        T(i+1,j+1) = T(i+1, j) + E_Ver;
                        Index_T(i+1,j+1) = 0;
%                         Img_T{i+1,j+1} = VerNewImage(tempIv,v);
                        Img_T_n{i+1,j+1} = VerNewImage(tempIv,v);
                        Img_sz_T{i+1,j+1} = size(Img_T_n{i+1,j+1});
                    end
                end
            end
        end
        Img_T_p = Img_T_n;
        Img_T_n = cell(r+1,c+1);
    end
    finalImage = Img_T_p{r+1,c+1};
end

