function paintadd(addt2branch,addt2pos)
for adbi=1:size(addt2branch,2)
    branchlist=addt2branch{adbi};
    nodelist=addt2pos{adbi};
    %nodes
    for ni=1:size(nodelist,2)
        plot(nodelist(ni,1),-nodelist(ni,2),'o','color','r');
        hold on
    end

    %links
    for linki=2:size(nodelist,2)
        link_from=linki;
        linkto_id=linki-1;
        line([nodelist(link_from,1),nodelist(linkto_id,1)],[-nodelist(link_from,2),-nodelist(linkto_id,2)],'color','r');
    end
end
end