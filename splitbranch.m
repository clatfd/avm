function branchlist=splitbranch(nodelist,linkfrom,linkto)
    branchlist={};
    degi_index=find(nodelist(:,5)>=3);
    branchend_index=find(nodelist(:,5)==1);
    %linkmap=[linkfrom',linkto'];
    branchid=1;
    branchlist{branchid}=[];
    for ni=1:size(nodelist,1)
        %linkedindex=findlinkednodes(curnode,linkmap);
        branchlist{branchid}=[branchlist{branchid},ni];   
        if ni>1 && ni<size(nodelist,1) && size(find(degi_index(:)==ni),1)
            branchid=branchid+1;
            branchlist{branchid}=ni;
        elseif ni>1 && ni<size(nodelist,1) && size(find(branchend_index(:)==ni),1)
            branchid=branchid+1;
            branchlist{branchid}=linkfrom(ni);  %link del first row ni-1+1
        end
    end
    for bi=1:size(branchlist,2)
        if nodelist(branchlist{bi}(1),4)<nodelist(branchlist{bi}(end),4)
            branchlist{bi}=branchlist{bi}(length(branchlist{bi}):-1:1);
        end
    end
end