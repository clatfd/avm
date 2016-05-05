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

nsicompare('snake_tracing_1.swc','snake_tracing_2.swc');

%register
[t1_nodelist,t1_linkfrom,t1_linkto]=loadswc('snake_tracing_test.swc');
t1_branchlist=splitbranch(t1_nodelist,t1_linkfrom,t1_linkto);
% t1_ynodelist=splitynode(t1_nodelist,t1_linkfrom,t1_linkto);
[t1_totbranch,t1_volbranch]=calbranch(t1_nodelist,t1_branchlist);
paintbranch(t1_nodelist,t1_linkfrom,t1_linkto,t1_branchlist,t1_totbranch,t1_volbranch);
t1_subbranchid=6;
t1_RLnodelist=calRLbranch(t1_nodelist,t1_branchlist{t1_subbranchid});
t1_nsinodelist=getnsilist(t1_nodelist,t1_linkfrom,t1_linkto);
t1_RLvoltlist=calRLvol(t1_nsinodelist(t1_branchlist{t1_subbranchid}(1),1),t1_nodelist,t1_RLnodelist);
paintRLbranch(t1_nodelist,t1_branchlist{t1_subbranchid},t1_RLnodelist,t1_RLvoltlist);
axis([0 100 -100 0]);
t1_peaknodeindex=findAngPeak(t1_RLvoltlist);

[t2_nodelist,t2_linkfrom,t2_linkto]=loadswc('snake_tracing_test2.swc');
t2_branchlist=splitbranch(t2_nodelist,t2_linkfrom,t2_linkto);
[t2_totbranch,t2_volbranch]=calbranch(t2_nodelist,t2_branchlist);
paintbranch(t2_nodelist,t2_linkfrom,t2_linkto,t2_branchlist,t2_totbranch,t2_volbranch);
t2_subbranchid=9;
t2_RLnodelist=calRLbranch(t2_nodelist,t2_branchlist{t2_subbranchid});
t2_nsinodelist=getnsilist(t2_nodelist,t2_linkfrom,t2_linkto);
t2_RLvoltlist=calRLvol(t2_nsinodelist(t2_branchlist{t2_subbranchid}(1),1),t2_nodelist,t2_RLnodelist);
paintRLbranch(t2_nodelist,t2_branchlist{t2_subbranchid},t2_RLnodelist,t2_RLvoltlist);
axis([0 100 -100 0]);
t2_peaknodeindex=findAngPeak(t2_RLvoltlist);

t1_peaknodeindex=[2;t1_peaknodeindex;size(t1_branchlist{t1_subbranchid},2)];
t2_peaknodeindex=[2;t2_peaknodeindex;size(t2_branchlist{t2_subbranchid},2)];
branchpair=[];   %comp1 comp2 diserr% based-on-t~t+1
branchpair=[branchpair;[t1_peaknodeindex,t2_peaknodeindex,zeros(size(t1_peaknodeindex,1),1)],t1_peaknodeindex];
branchpair(end,4)=branchpair(end,4)-1;%avoid +1 overflow in paint
% comp1=t1_RLvoltlist(2:t1_peaknodeindex(1),1);
% comp2=t2_RLvoltlist(2:t2_peaknodeindex(1),1);
% branchipair=findbranchipair(comp1,comp2);
% branchpair=[branchpair;branchipair(2:end-1,:)];
for peaki=1:size(t1_peaknodeindex,1)-1
    comp1=t1_RLvoltlist(t1_peaknodeindex(peaki):t1_peaknodeindex(peaki+1),1);
    comp2=t2_RLvoltlist(t2_peaknodeindex(peaki):t2_peaknodeindex(peaki+1),1);
    branchipair=findbranchipair(comp1,comp2,t1_peaknodeindex(peaki)-1);
    branchpair=[branchpair;branchipair(2:end-1,:)];
end
paintcompbranch(t1_nodelist,t1_branchlisti,branchpair);
branchpair=[branchpair;branchipair(2:end-1,:)];
paintcompbranch(t1_map,t2_)