function convert_ply(MR_scale_xyz,DSA_scale_xy)
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
end