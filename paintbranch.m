function paintbranch(nodelist,linkfrom,linkto,branchlist,totbranch,volbranch)
figure;
title('branch');
hold on
%nodes
for ni=1:size(nodelist,1)
    plot(nodelist(ni,2),-nodelist(ni,3),'o');
    hold on
end
%links
for linki=1:size(linkfrom,2)
    link_from=linkfrom(linki);
    linkto_id=linkto(linki);
    if linkto_id > 0
        line([nodelist(link_from,2),nodelist(linkto_id,2)],[-nodelist(link_from,3),-nodelist(linkto_id,3)]);
    end
end
%branch
for bi=1:size(branchlist,2)
    branchnodelist=branchlist{bi}([1,end]);
    xpos=nodelist(branchnodelist',2);
    ypos=nodelist(branchnodelist',3);
    xposmean=mean(xpos);
    yposmean=mean(ypos);
    text(xposmean,-yposmean,[mat2str(bi),':',mat2str(round(totbranch(bi)*100)/100),',',mat2str(round(volbranch(bi)*10)/10)]);
end

end