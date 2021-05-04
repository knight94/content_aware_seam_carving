function [I_final] = InsertHoriSeam(I,H)
    img = I;
    [Y, X, Color] = size(img);
    
    I_temp = uint8(zeros(Y+1, X, Color));
    filename = 'insert_output_hor.gif';
    for k = 1:size(H,1)
        for x = 1:X
            tempy = H(k,x);
            for c = 1:Color
                if(tempy == 1)
                    q = mean([img(tempy, x, c), img(tempy+1, x, c)]);
                elseif(tempy == Y)
                    q = mean([img(tempy, x, c), img(tempy-1, x, c)]);
                else
                    q = mean([img(tempy-1, x, c), img(tempy, x, c), img(tempy+1, x, c)]);
                end
                I_temp(1:tempy,x,c) = img(1:tempy,x,c);
                I_temp(tempy+1,x,c) = q;
                I_temp(tempy+2:end,x,c) = img(tempy+1:end,x,c);
            end
        end
        for x = 1:X
            img(H(k,x),x,1) = 255;
            img(H(k,x),x,2) = 0;
            img(H(k,x),x,3) = 0;    
        end
        img_gif = uint8(zeros(Y+size(H,1),X,Color));
        img_gif(1:size(img,1),:,1) = img(:,:,1);
        img_gif(1:size(img,1),:,2) = img(:,:,2);
        img_gif(1:size(img,1),:,3) = img(:,:,3);
        [A,map] = rgb2ind(img_gif,256);
        if k == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
        else
            imwrite(A,map,filename,'gif','WriteMode','append');
        end
        imshow(img);
        img = I_temp;
        I_temp = uint8(zeros(size(img,1)+1, X, Color));
    end
    I_final = img;
end
