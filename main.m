%find vessel in original image
%[MR,DSA]=find_vessel()

%find vessel in example image, path fixed
%[MR DSA]=bwextract_ex();
%stored in mat
%load bwimage.mat;

%load segmented image
%[MR DSA]=readseg();
%stored in mat
load segimage.mat

[MR_r,DSA_r]=resize_mrdsa(MR,DSA);
convert_ply(MR_r,DSA_r);

%convert to tif
%imgtotif(DSA_r,'DSA_resize');
%imgtotif(MR_r,'MR_resize');

[DSA_nodelist,DSA_linkfrom_trim,DSA_linkto_trim]=net_trim(DSA_r);
[MR_nodelist,MR_linkfrom_trim,MR_linkto_trim]=net_trim(MR_r);

testimg1=imread('1.tif');
testimg2=imread('2.tif');

[t1_nodelist,t1_linkfrom,t1_linkto]=net_trim(testimg1);
ynodelist=findYnode(t1_nodelist,t1_linkfrom,t1_linkto);
ynode_id=find(ynodelist(:,5)>0);
voltlist=calvolt(ynode_id,ynodelist,t1_linkfrom,t1_linkto);

[t1_nodelist,t1_linkfrom,t1_linkto]=loadswc('snake_tracing_1.swc');
[t2_nodelist,t2_linkfrom,t2_linkto]=loadswc('snake_tracing_2.swc');
t1_voltlist=calvolt(t1_nodelist,t1_linkfrom,t1_linkto);
t2_voltlist=calvolt(t2_nodelist,t2_linkfrom,t2_linkto);
paintswc('snake_tracing_1.swc',t1_voltlist);
paintswc('snake_tracing_2.swc',t2_voltlist);

t1_nsinodelist=getnsilist(t1_nodelist,t1_linkfrom,t1_linkto);
t2_nsinodelist=getnsilist(t2_nodelist,t2_linkfrom,t2_linkto);

paintswc('snake_tracing_1.swc',t1_nsinodelist(:,1),t1_nsinodelist(:,2));
paintswc('snake_tracing_2.swc',t2_nsinodelist(:,1),t2_nsinodelist(:,2));

t1_nodelist=[t1_nodelist,t1_nsinodelist];
t2_nodelist=[t2_nodelist,t2_nsinodelist];
figure;
for degi=max(t1_nodelist(:,5)):-1:1
    deg_index= t1_nodelist(:,5)==degi;
    t1_subnodelist=t1_nodelist(deg_index,:);
    t1_subnodelist=sortrows(t1_subnodelist,-7);
    
    deg_index= t2_nodelist(:,5)==degi;
    t2_subnodelist=t2_nodelist(deg_index,:);
    t2_subnodelist=sortrows(t2_subnodelist,-7);
    
    
    for linki=1:size(t1_subnodelist,1)
        line([t1_subnodelist(linki,2),t2_subnodelist(linki,2)],[-t1_subnodelist(linki,3),-t2_subnodelist(linki,3)]);
    end
end