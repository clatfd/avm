function linkedindex=findlinkednodes(id,linkmap)
    linkedindex=[];
    curid=find(linkmap(:,1)==id);
    if size(curid,1)
        linkedindex=[linkedindex;linkmap(curid,2)];
    end
    curid=find(linkmap(:,2)==id);
    if size(curid,1)
        linkedindex=[linkedindex;linkmap(curid,1)];
    end
end