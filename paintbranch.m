function paintbranch(nodelist,linkfrom,linkto,branchlist,totbranch,volbranch,nsinodelist,ynode)
figure;
title('branch');
hold on
%cal nsi color
nodecolorR=nsinodelist(:,2)./max(nsinodelist(:,2)); %use second nsi
nodecolor=[nodecolorR zeros(size(nodecolorR,1),1) 1-nodecolorR];
%nodes
for ni=1:size(nodelist,1)
    if size(find(ynode(:)==ni))
        plot(nodelist(ni,2),-nodelist(ni,3),'s','MarkerEdgeColor','w','MarkerFaceColor',nodecolor(ni,:));
    else
        plot(nodelist(ni,2),-nodelist(ni,3),'o','MarkerEdgeColor','w','MarkerFaceColor',nodecolor(ni,:));
    end
    hold on
    %mark id and nsi for possible y nodes
    if nodelist(ni,5)>2
        text(nodelist(ni,2)+1,-nodelist(ni,3),[mat2str(nodelist(ni,1)),' ',mat2str(round(nsinodelist(ni,2)*10)/10)],'color','r');
        hold on
    end
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
%     paint second node in branch
%     plot(nodelist(branchlist{bi}(2),2),-nodelist(branchlist{bi}(2),3),'o','markerfacecolor','r');
    hold on
    xpos=nodelist(branchnodelist',2);
    ypos=nodelist(branchnodelist',3);
    xposmean=mean(xpos);
    yposmean=mean(ypos);
    text(xposmean,-yposmean,[mat2str(bi),':',mat2str(round(totbranch(bi)*100)/100),',',mat2str(round(volbranch(bi)*10)/10)]);
end

end