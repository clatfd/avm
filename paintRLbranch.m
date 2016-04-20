function paintRLbranch(nodelist,branchlist,RLnodelist,RLvoltlist)
figure;
title('RLbranch');
hold on
%first node
plot(nodelist(branchlist(1),2),-nodelist(branchlist(1),3),'o');
for bi=2:size(branchlist,2)
    plot(nodelist(branchlist(bi),2),-nodelist(branchlist(bi),3),'o');%nodes
    hold on
    line([nodelist(branchlist(bi),2),nodelist(branchlist(bi-1),2)],[-nodelist(branchlist(bi),3),-nodelist(branchlist(bi-1),3)]);%links
    hold on
    RL=[mat2str(round(RLnodelist(bi,1)*10)/10),'б╧',mat2str(round(RLnodelist(bi,2)*10)/10),'бу'];
    text((nodelist(branchlist(bi),2)+nodelist(branchlist(bi-1),2))/2,(-nodelist(branchlist(bi),3)-nodelist(branchlist(bi-1),3))/2,RL,'color','r');
    RLvol=[mat2str(round(RLvoltlist(bi,1)*10)/10),'б╧',mat2str(round(RLvoltlist(bi,2)*10)/10),'бу'];
    text(nodelist(branchlist(bi),2),-nodelist(branchlist(bi),3),RLvol);
%     weight=round(RLnodelist(bi,1)*10)/10;
%     tot=round(RLnodelist(bi,2)*10)/10;
%     text((nodelist(branchlist(bi),2)+nodelist(branchlist(bi-1),2))/2,(-nodelist(branchlist(bi),3)-nodelist(branchlist(bi-1),3))/2,[mat2str(weight),' ',mat2str(tot)]);
end

end