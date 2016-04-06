function imgtotif(I,location)
n=size(I,3);
for serialno=1:n
    if serialno<10
        ii=['00',int2str(serialno)];
    elseif serialno<100
        ii=['0',int2str(serialno)];
    else
        ii=int2str(serialno);
    end
    Inew = imadjust(I(:,:,serialno), stretchlim(I(:,:,serialno)), []);
    imwrite(Inew.*255,[location,'/',ii,'.tiff']);
end