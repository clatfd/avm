function branchipair=findbranchipair(comp1,comp2,offset)
branchipair=zeros(size(comp2,1),4);
    %stretch to unitify
    comp1=comp1-comp1(end);
    comp2=comp2-comp2(end);
    comp2=comp2/comp2(1)*comp1(1);
    for ci=2:size(comp2,1)-1
        maxids=find(comp1(:)>=comp2(ci));
        comtarget=maxids(end);
        if comp1(comtarget)-comp2(ci)>comp2(ci)-comp1(comtarget+1)
            comtarget=comtarget+1;
            errdis=(comp2(ci)-comp1(comtarget))/(comp1(comtarget-1)-comp1(comtarget));
            branchipair(ci,:)=[comtarget+offset,ci+offset,errdis,comtarget-1+offset];
        else
            errdis=(comp1(comtarget)-comp2(ci))/(comp1(comtarget)-comp1(comtarget+1));
            branchipair(ci,:)=[comtarget+offset,ci+offset,errdis,comtarget+offset];
        end    
    end
end