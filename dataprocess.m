clc
clear 
clf

% for i = 1:d    
% 	Itemp = dsa(:,:,i);
% 	if i<10
% 		ii=['00',int2str(i)];
% 	elseif i<100
% 		ii=['0',int2str(i)];
% 	else
% 		ii=int2str(i);
%     end
%     imwrite(Itemp,['dsajpg/d',ii,'.jpg']);
% end


Itemp = zeros(512,512,397);
for i=1:397
    if i<10
		ii=['00',int2str(i)];
	elseif i<100
		ii=['0',int2str(i)];
	else
		ii=int2str(i);
    end
    Itemp = dicomread(strcat('00080',ii));
    Itemp = mat2gray(im2double(Itemp));
%     g = graythresh(Itemp);
    Itemp = im2bw(Itemp,0.5);
    I(:,:,i) = Itemp;
    imwrite(I(:,:,i),['dsa1out/d',ii,'.jpg']);
end


