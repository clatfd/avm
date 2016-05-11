function paintcompbranch(t1_nodelist,t1_branchlisti,branchpair)

%base branch
    %draw node
    for ni=1:size(t1_branchlisti,2)
       plot(t1_nodelist(t1_branchlisti(ni),2),-t1_nodelist(t1_branchlisti(ni),3),'o');
       hold on
    end
    %draw link
    for linki=1:size(t1_branchlisti,2)-1
        linkfromid=t1_branchlisti(linki);
        linktoid=t1_branchlisti(linki+1);
        line([t1_nodelist(linkfromid,2),t1_nodelist(linktoid,2)],[-t1_nodelist(linkfromid,3),-t1_nodelist(linktoid,3)]);
        hold on 
    end
%comp branch
    for compi=1:size(branchpair,1)
        basexylengthstart=t1_nodelist(t1_branchlisti(branchpair(compi,4)),[2,3]);
        basexylengthend=t1_nodelist(t1_branchlisti(branchpair(compi,4)+1),[2,3]);
        baselengthxy=basexylengthend-basexylengthstart;
        errp=branchpair(compi,3);
        errlength=baselengthxy*errp;
        basepointxy=t1_nodelist(t1_branchlisti(branchpair(compi,1)),[2,3]);
        if branchpair(compi,1)==branchpair(compi,4)
            compnodexy=basepointxy+errlength;
        else
            compnodexy=basepointxy-errlength;
        end
        plot(compnodexy(1),-compnodexy(2),'o','color','r');
        hold on
    end
end