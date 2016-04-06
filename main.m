%[MR DSA]=bwextract_ex();
%load bwimage.mat;
%[MR DSA]=readseg();
load segimage.mat
[MR_r,DSA_r]=resize_mrdsa(MR,DSA);
convert_ply(MR_r,DSA_r);
imgtotif(DSA_r,'DSA_resize');
imgtotif(MR_r,'MR_resize');

[DSA_nodelist,DSA_linkfrom_trim,DSA_linkto_trim]=net_trim(DSA_r);
[MR_nodelist,MR_linkfrom_trim,MR_linkto_trim]=net_trim(MR_r);

