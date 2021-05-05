function [tempI,new_seam] = mapping(seam_Ip,Ij)
% set4_data = cell(1,4);
% set4_data{1} = [2*j-1, 2*i-1];
% set4_data{2} = [2*j, 2*i-1] ;
% set4_data{3} = [2*j, 2*i];
% set4_data{4} = [2*j-1, 2*i];
[Y X col] = size(Ij);
tempI = Ij;
new_seam = cell(1, 2*length(seam_Ip)); 
for j=1:2*length(seam_Ip)
    new_seam{j} = zeros(1,Y);
end 
% disp(length(seam_Ip));
for i=1:length(seam_Ip)
    V = seam_Ip{i};
%     disp(length(V)); 
%     break
for y=1:length(V)
    % these set of points should be there that's what is represented here
    new_seam{i}(2*y-1) = 2*V(y)-1;
    new_seam{i}(2*y) = 2*V(y)-1;
    new_seam{length(seam_Ip)+ i}(2*y-1) = 2*V(y);
    new_seam{length(seam_Ip)+ i}(2*y) = 2*V(y); 
end 
[tempI] = VerNewImage(tempI,new_seam{i});
[tempI] = VerNewImage(tempI,new_seam{length(seam_Ip)+ i});
end
% figure
% imshow(tempI);
% disp(size(tempI));
end 