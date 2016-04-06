function [MR,DSA]=bwextract_ex()
FilePath ='E:\C-FYP\DSA DEMO\AngioPlanning-AVM_CTA_MRA\MR_TOF_3D_multi_slab_0_4mm_prae_0\';
MRo=[];
MR=[];
n=167;
for i=0:n
    FileFullName=strcat(FilePath,'MR_',int2str(i),'.dcm');
    I=dicomread(FileFullName);
    metadata=dicominfo(FileFullName);
    serialno=metadata.InstanceNumber;
    %MRo(:,:,serialno)=I;
    MR(:,:,serialno)=im2bw(imadjust(mat2gray(I),[],[]));
end

FilePath ='E:\C-FYP\DSA DEMO\AngioPlanning-AVM_CTA_MRA\XA_ACIre__MIPSubHUSmooth_InSpace3D__3\';
DSAo=[];
DSA=[];
n=503;
for i=0:n
    FileFullName=strcat(FilePath,'XA_',int2str(i),'.dcm');
    I=dicomread(FileFullName);
    metadata=dicominfo(FileFullName);
    serialno=metadata.InstanceNumber;
    %DSAo(:,:,serialno)=I;
    DSA(:,:,serialno)=im2bw(imadjust(mat2gray(I),[],[]));
end
end