%to do in 3d img convertion
function maxR=getMaxR(Img_trim)
n=size(Img,1);
for maxR=1:n
    compImg=zeros(n,n);
    se=strel('disk',maxR).getnhood();
    compImg()
    
end
end