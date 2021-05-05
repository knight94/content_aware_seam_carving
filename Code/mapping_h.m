function [tempI,new_seam] = mapping_h(seam_Ip,Ij)
% set4_data = cell(1,4);
% set4_data{1} = [2*j-1, 2*i-1];
% set4_data{2} = [2*j, 2*i-1] ;
% set4_data{3} = [2*j, 2*i];
% set4_data{4} = [2*j-1, 2*i];
[Y ,X ,col] = size(Ij);
tempI = Ij;
new_seam = cell(1, 2*length(seam_Ip)); 
for j=1:2*length(seam_Ip)
    new_seam{j} = zeros(1,X);
end 
% disp(length(seam_Ip));
% return
for i=1:length(seam_Ip)
    H = seam_Ip{i};
%     disp(length(H)); 
%     break
for x=1:length(H)
    new_seam{i}(2*x-1) = 2*H(x)-1;
    new_seam{i}(2*x) = 2*H(x)-1;
    new_seam{length(seam_Ip)+ i}(2*x-1) = 2*H(x);
    new_seam{length(seam_Ip)+ i}(2*x) = 2*H(x); 
end 
[tempI] = HoriNewImage(tempI,new_seam{i});
[tempI] = HoriNewImage(tempI,new_seam{length(seam_Ip)+ i});
end
% figure
% imshow(tempI);
% disp(size(tempI));
end 