function res = calc_seams_guasspyr(N,L,i,nj_arr)
acc = 0;
if i~=L
for j=i+1:L
    acc = acc + (nj_arr(j)*power(2,j-1));
end 
res = floor((N-acc)/power(2,i-1));
else
res = floor(N/power(2,i-1));
end
end 