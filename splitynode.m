%todo
function [ynodelist,possynodes]=splitynode(nodelist,linkfrom,linkto,branchlist)
branchstart=[];
for bi=1:size(branchlist,2)
    branchstart=[branchstart,branchlist{bi}(1)];
end
ynodelist=unique(branchstart);
branchstartpos=nodelist(ynodelist,[2,3]);        
possynodes={};
possbranch={};
for yni=1:size(ynodelist,2)
    possynodes{yni}=[];
    for cyni=1:size(ynodelist,2)
        if yni~=cyni && pdist2(branchstartpos(yni,:),branchstartpos(cyni,:))<10
            possynodes{yni}=[possynodes{yni},cyni];   
        end
    end
end
for yni=1:size(ynodelist,2)
    if branchlist{yni}(1)==ynodelist(yni)
        possbranch{yni}=[possbranch{yni},branchlist{yni}(1)];
    end
end
linkednodes=findlinkednodes(curid,[linkfrom',linkto']);

end