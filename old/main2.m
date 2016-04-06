
%read DSA image and its dicominfo
dsainfo=dicominfo('XA_ACIre__MIPSubHUSmooth_InSpace3D__3/XA_0.dcm');
dsa_x_dis=dsainfo.PixelSpacing(1);
dsa_y_dis=dsainfo.PixelSpacing(2);
dsa_z_dis=dsainfo.SliceThickness;

dsa_xo=dsainfo.Width;
dsa_yo=dsainfo.Height;

DSA=squeeze(dicomread('SEG_Objects_2/SEG_0.dcm'));

%dsa_x_dis==dsa_y_dis==dsa_z_dis=0.3653
%skip resize
% if(dsa_x_dis==dsa_y_dis)
%     DSA_scale_xy=imresize(DSA(:,:,:),dsa_z_dis/dsa_x_dis);
% else
%     DSA_scale_xy=imresize(DSA(:,:,:),[dsa_xo*dsa_z_dis/dsa_x_dis dsar_yo*dsa_z_dis/dsa_y_dis]);
% end

DSA_scale_xy=DSA;

[dsa_x dsa_y dsa_z]=size(DSA_scale_xy);  %512 512 436

%convert 3D image to xyz format
x=[];
y=[];
z=[];
ind=find(DSA_scale_xy==1);
for k=1:length(ind)
[x(k),y(k),z(k)] = ind2sub(size(DSA_scale_xy),ind(k));
end
oneline=ones(1,length(ind));
pt_dsa=[x;y;z;255*oneline;0*oneline;0*oneline;255*oneline];
pt_dsa=pt_dsa';
header='ply\nformat ascii 1.0\ncomment VCGLIB generated\nelement vertex %d\nproperty float x\nproperty float y\nproperty float z\nproperty uchar red\nproperty uchar green\nproperty uchar blue\nproperty uchar alpha\nelement face 0\nproperty list uchar int vertex_indices\nend_header\n';
fid = fopen('DSA.ply','w');
fprintf(fid,header,length(ind));
dlmwrite('DSA.ply',pt_dsa,'-append','delimiter',' ');

%read MR image and its dicominfo
mrinfo=dicominfo('MR_TOF_3D_multi_slab_0_4mm_prae_0/MR_0.dcm');
mr_x_dis=mrinfo.PixelSpacing(1);
mr_y_dis=mrinfo.PixelSpacing(2);
mr_z_dis=mrinfo.SliceThickness;

mr_xo=mrinfo.Width;
mr_yo=mrinfo.Height;

MR=squeeze(dicomread('SEG_Objects_1/SEG_0.dcm'));

%resize mr image according to two aspects
%1. the difference between x-y plane pixel distance and z direction thickness: mr_z_dis/mr_x_dis
%2. the difference between dsa and mr image: dsa_z_dis/mr_z_dis

%first, resize x-y plane

% MR_scale_xy=imresize(MR,mr_z_dis/mr_x_dis * dsa_z_dis/mr_z_dis);%
MR_scale_xy=imresize(MR,mr_x_dis/mr_z_dis);

%resize on z index according to dsa and mr
%change 3-D matrix order to Z-Y-X
MR_t=permute(MR_scale_xy,[3 2 1]);
% [mrt_x mrt_y mrt_z]=size(MR_t);
%resize on x only(that is z in original space)
% MR_scale_xyz=imresize(MR_t, [dsa_z_dis/mr_z_dis*mrt_x mrt_y]);%
% [mr_x mr_y mr_z]=size(MR_scale_xyz);%
MR_scale_xyz1=imresize(MR_t,mr_z_dis/dsa_z_dis);
MR_scale_xyz2=permute(MR_scale_xyz1,[3 2 1]);
[mr_x mr_y mr_z]=size(MR_scale_xyz2);
MR_scale_xyz=imresize(MR_scale_xyz2,[mr_z_dis/dsa_z_dis*mr_x mr_y]);


%convert 3D image to xyz format
xx=[];
yy=[];
zz=[];
ind=find(MR_scale_xyz==1);
for k=1:length(ind)
[xx(k),yy(k),zz(k)] = ind2sub(size(MR_scale_xyz),ind(k));
end
oneline=ones(1,length(ind));
pt_mr=[xx;yy;zz;0*oneline;0*oneline;255*oneline;255*oneline];
pt_mr=pt_mr';
fid = fopen('MR.ply','w');
fprintf(fid,header,length(ind));
dlmwrite('MR.ply',pt_mr,'-append','delimiter',' ');

