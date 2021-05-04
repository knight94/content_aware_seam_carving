function [I_final] = InsertVerSeam(I,V)
    img = I;
    [Y, X, Color] = size(img);
    
    I_temp = uint8(zeros(Y, X+1, Color));
    filename = 'insert_output_ver.gif';
    for k = 1:size(V,2)
        for y = 1:Y
            tempx = V(y,k);
            for c = 1:Color
                if(tempx == 1)
                    q = mean([img(y, tempx, c), img(y, tempx+1, c)]);
                elseif(tempx == X)
                    q = mean([img(y, tempx-1, c), img(y, tempx, c)]);
                else
                    q = mean([img(y, tempx-1, c), img(y, tempx, c), img(y, tempx+1, c)]);
                end
                I_temp(y,1:tempx,c) = img(y,1:tempx,c);
                I_temp(y,tempx+1,c) = q;
                I_temp(y,tempx+2:end,c) = img(y,tempx+1:end,c);
            end
        end
        for y = 1:Y
            img(y,V(y,k),1) = 255;
            img(y,V(y,k),2) = 0;
            img(y,V(y,k),3) = 0;    
        end
        imshow(img);
        img_gif = uint8(zeros(Y,X+size(V,2),Color));
        img_gif(:,1:size(img,2),1) = img(:,:,1);
        img_gif(:,1:size(img,2),2) = img(:,:,2);
        img_gif(:,1:size(img,2),3) = img(:,:,3);
        [A,map] = rgb2ind(img_gif,256);
        if k == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
        else
            imwrite(A,map,filename,'gif','WriteMode','append');
        end
        img = I_temp;
        I_temp = uint8(zeros(Y, size(img,2)+1, Color));
    end
    I_final = img;
end

