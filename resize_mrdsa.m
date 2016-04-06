function [MR_scale_xyz,DSA_scale_xy]=resize_mrdsa(MR,DSA)
%read DSA image and its dicominfo
dsainfo=dicominfo('XA_ACIre__MIPSubHUSmooth_InSpace3D__3/XA_0.dcm');
dsa_x_dis=dsainfo.PixelSpacing(1);
dsa_y_dis=dsainfo.PixelSpacing(2);
dsa_z_dis=dsainfo.SliceThickness;

dsa_xo=dsainfo.Width;
dsa_yo=dsainfo.Height;


%In this case dsa_x_dis==dsa_y_dis==dsa_z_dis=0.3653, so skip resize in dsa
if dsa_x_dis~=dsa_z_dis || dsa_y_dis~=dsa_z_dis
    if dsa_x_dis==dsa_y_dis
        DSA_scale_xy=imresize(DSA(:,:,:),dsa_x_dis/dsa_z_dis);
    else
        DSA_scale_xy=imresize(DSA(:,:,:),[dsa_xo*dsa_x_dis/dsa_z_dis dsa_yo*dsa_y_dis/dsa_z_dis]);
    end
else
    DSA_scale_xy=DSA;
end

%read MR image and its dicominfo
mrinfo=dicominfo('MR_TOF_3D_multi_slab_0_4mm_prae_0/MR_0.dcm');
mr_x_dis=mrinfo.PixelSpacing(1);
mr_y_dis=mrinfo.PixelSpacing(2);
mr_z_dis=mrinfo.SliceThickness;

mr_xo=mrinfo.Width;
mr_yo=mrinfo.Height;

%resize mr image according to two aspects
%1. the difference between x-y plane pixel distance and z direction thickness: mr_z_dis/mr_x_dis
%2. the difference between dsa and mr image: dsa_z_dis/mr_z_dis

%first, resize x-y plane
if mr_x_dis~=mr_z_dis || mr_y_dis~=mr_z_dis
    if mr_x_dis==mr_y_dis
        MR_scale_xy=imresize(MR(:,:,:),mr_x_dis/mr_z_dis);
    else
        MR_scale_xy=imresize(MR(:,:,:),[mr_xo*mr_x_dis/mr_z_dis mr_yo*mr_y_dis/mr_z_dis]);
    end
else
    MR_scale_xy=MR;
end

%resize on z index according to dsa and mr
%change 3-D matrix order to Z-Y-X
MR_t=permute(MR_scale_xy,[3 2 1]);
[mrt_x mrt_y mrt_z]=size(MR_t);
%resize on x only(that is z in original space)
MR_scale_xyz=imresize(MR_t, [mr_z_dis/dsa_z_dis*mrt_x mrt_y]);
MR_scale_xyz=permute(MR_scale_xyz,[3 2 1]);
end