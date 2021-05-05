function imgout = guass_pyr_reduce(img)

kernelWidth = 5; 
cw = .375;% kernel centre weight, same as MATLAB func impyramid. 0.6 in the Paper 
ker1d = [.25-cw/2 .25 cw .25 .25-cw/2];
kernel = kron(ker1d,ker1d');


img = im2double(img); 
sz = size(img);
imgout = [];
for p = 1:size(img,3)
	img1 = img(:,:,p);
	imgFiltered = imfilter(img1,kernel,'replicate','same');
	imgout(:,:,p) = imgFiltered(1:2:sz(1),1:2:sz(2));
end
end