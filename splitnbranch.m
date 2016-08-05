function edbranchlist=splitnbranch(nodelist,linkfrom,linkto,ynode,yybranch)
    edbranchlist={};
    yybranchnode=[yybranch{:}];
    pyynodes=find(nodelist(:,5)>2)';
    trimyynode=setdiff(yybranchnode,pyynodes);
    ednum=1;
    branchend_index=find(nodelist(:,5)==1)';
    DGsize=max([linkfrom linkto]);
    DG=sparse([linkfrom linkto],[linkto,linkfrom],ones(1,2*size(linkfrom,2)),DGsize,DGsize);
    for yni=1:size(ynode,2)
        for bei=1:size(branchend_index,2)
            [dist,path,~]=graphshortestpath(DG,ynode(yni),branchend_index(bei));
            if size(path,2)~=0 && size(intersect(path,trimyynode),2)==0
                edbranchlist{ednum}=path;
                ednum=ednum+1;
            end
        end
    end

%     for bi=1:size(branchlist,2)
%         if nodelist(branchlist{bi}(1),4)<nodelist(branchlist{bi}(end),4)    %change direction if start from small to big
%             branchlist{bi}=branchlist{bi}(length(branchlist{bi}):-1:1);
%         end
%     end
end