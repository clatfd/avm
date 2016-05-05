function nearbranchgrouplist=findnearbranchgrouplist(nodelist,branchlist)
% branchstart=[];
% for bi=1:size(branchlist,2)
%     branchstart=[branchstart,branchlist{bi}(1)];
% end
% ynodelist=unique(branchstart);
% branchstartpos=nodelist(ynodelist,[2,3]);
nearbranchgrouplist={};
gro=1;
unpairedbranchindex=1:size(branchlist,2);
%del tree branch

while size(unpairedbranchindex,2)>0
    curbi=unpairedbranchindex(1);
    curstartnodeid=branchlist{curbi}(1);
    nearbranchgrouplist{gro}=[curbi];
    delid=find(unpairedbranchindex(:)==curbi);
    unpairedbranchindex(delid)=[];
    for searchbi=1:size(unpairedbranchindex,2)
        cursearchbi=unpairedbranchindex(searchbi);
        cursearchstartnodeid=branchlist{cursearchbi}(1);
        if searchbi~=curbi && pdist2(nodelist(cursearchstartnodeid,[2,3]),nodelist(curstartnodeid,[2,3]))<10
            nearbranchgrouplist{gro}=[nearbranchgrouplist{gro},cursearchbi];  
            delid=find(unpairedbranchindex(:)==cursearchbi);
            unpairedbranchindex(delid)=[];
        end
        if searchbi>=size(unpairedbranchindex,2)
            break;
        end
    end
    gro=gro+1;
end
end