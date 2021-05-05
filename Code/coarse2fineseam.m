function coarse2fineseam(N,L,impath)
tic
    img_data = cell(1,L);
    for i=1:L
        if i==1
            img_data{i} = imread(impath);
        else 
%             img_data{i} = impyramid(img_data{i-1},'reduce');
            img_data{i} = guass_pyr_reduce(img_data{i-1});
        end 
    end     
    nj_arr = zeros(1,L);
    for j=L:-1:1
       nj = calc_seams_guasspyr(N,L,j,nj_arr);
       nj_arr(j) = nj;
%        disp(nj);
%        disp('$$$$');
       if j<L 
          [img_data{j}, new_seam] = mapping(seams_data, img_data{j});% map from Ip to Ij
          seams_data = RunVertSeamCarve(img_data{j},nj); 
          seams_data = [seams_data , new_seam];
%           disp(size(img_data{j}));
%           disp('****'); 
       else
          seams_data = RunVertSeamCarve(img_data{j},nj); %Ij
       end
    end 
toc
end
