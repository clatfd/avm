function RLnodelist=calRLbranch(nodelist,branchlist)
RLnodelist=zeros(size(branchlist,2),2);
startnodexy=nodelist(branchlist(1),[2,3]);
endnodexy=nodelist(branchlist(end),[2,3]);
vecA=startnodexy-endnodexy;
lvecA=(vecA(1)^2+vecA(2)^2)^0.5;
for bi=2:size(branchlist,2)
   vecB=nodelist(branchlist(bi-1),[2,3])-nodelist(branchlist(bi),[2,3]);
   lvecB=(vecB(1)^2+vecB(2)^2)^0.5;
   angAB=acos(sum(vecA.*vecB)/lvecA/lvecB);
   RLnodelist(bi,2)=angAB;%sin(angAB)*lvecB;
   RLnodelist(bi,1)=(nodelist(branchlist(bi-1),4)+ nodelist(branchlist(bi),4))/2;
   %RLnodelist(bi,3)=cos(angAB)*RLnodelist(bi,1)+1i*sin(angAB)*RLnodelist(bi,1);
end
end