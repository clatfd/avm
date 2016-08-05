function paintbasenet(nodelist,linkfrom,linkto)
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

end