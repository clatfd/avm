function branchlist=splitbranch(nodelist,linkfrom,linkto)
%[branchlist,branchheadgroup]
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
% todo    branchheadgroup={};
%     branchheadgroupid=1;
    for bi=1:size(branchlist,2)
        if nodelist(branchlist{bi}(1),4)<nodelist(branchlist{bi}(end),4)    %change direction if start from small to big
            branchlist{bi}=branchlist{bi}(length(branchlist{bi}):-1:1);
        end
%         %divide head node into group
%         for gi=1:size(branchheadgroup,2)
%             for gii=1:size(branchheadgroup{gi},2)
%                 if pdist2(nodelist(branchheadgroup{gi}(gii),[2,3]),nodelist(branchlist{bi}(1),[2,3]))<10
%                     branchheadgroup{branchheadgroupid}=[branchheadgroup{branchheadgroupid},bi];
%                     break;
%                 end
%             end
%         end
    end
end