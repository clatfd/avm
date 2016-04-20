function regiNodes(t1_nodelist,t1_linkfrom,t1_linkto,t2_nodelist,t2_linkfrom,t2_linkto)
    %degi=max(t1_nodelist(:,5));
    %deg_index= t1_nodelist(:,5)==degi;
    degi=3;
    deg_index= t1_nodelist(:,5)>=degi;
    t1_subnodelist=t1_nodelist(deg_index,:);
%     t1_subnodelist=sortrows(t1_subnodelist,-7);%nsi 2nd
    t1_subnodelist=sortrows(t1_subnodelist,-6);%nsi 1st
    
    %deg_index= t2_nodelist(:,5)==degi;
    deg_index= t2_nodelist(:,5)>=degi;
    t2_subnodelist=t2_nodelist(deg_index,:);
%     t2_subnodelist=sortrows(t2_subnodelist,-7);%nsi 2nd
    t2_subnodelist=sortrows(t2_subnodelist,-6);%nsi 1st
    
    figure;
    %draw node
    t1_heatmap=t1_nodelist(:,[2,3,6]);
    t1_nodecolorR=t1_heatmap(:,3)./max(t1_heatmap(:,3));
    t1_nodecolor=[t1_nodecolorR zeros(size(t1_nodecolorR,1),1) 1-t1_nodecolorR];
    for ni=1:size(t1_heatmap,1)
       plot(t1_heatmap(ni,1),-t1_heatmap(ni,2),'o','MarkerEdgeColor','w','MarkerFaceColor',t1_nodecolor(ni,:));
       hold on
    end
    %draw link
    for linki=1:size(t1_linkfrom,2)
        linkfrom_id=t1_linkfrom(linki);
        linkto_id=t1_linkto(linki);
        line([t1_nodelist(linkfrom_id,2),t1_nodelist(linkto_id,2)],[-t1_nodelist(linkfrom_id,3),-t1_nodelist(linkto_id,3)]);
        hold on 
    end
    %subnodelist item
    for linki=1:size(t1_subnodelist,1)
        ni=t1_subnodelist(linki,1);
        text(t1_nodelist(ni,2),-t1_nodelist(ni,3),[mat2str(linki),' ',mat2str(round(t1_subnodelist(linki,7)*10)/10)]);
    end
    title('net1');
    
    figure;
    %draw node
    t2_heatmap=t2_nodelist(:,[2,3,6]);
    t2_nodecolorR=t2_heatmap(:,3)./max(t2_heatmap(:,3));
    t2_nodecolor=[t2_nodecolorR zeros(size(t2_nodecolorR,1),1) 1-t2_nodecolorR];
    for ni=1:size(t2_heatmap,1)
       plot(t2_heatmap(ni,1),-t2_heatmap(ni,2),'o','MarkerEdgeColor','w','MarkerFaceColor',t2_nodecolor(ni,:));
       hold on
    end
    %draw link
    for linki=1:size(t2_linkfrom,2)
        linkfrom_id=t2_linkfrom(linki);
        linkto_id=t2_linkto(linki);
        line([t2_nodelist(linkfrom_id,2),t2_nodelist(linkto_id,2)],[-t2_nodelist(linkfrom_id,3),-t2_nodelist(linkto_id,3)]);
        hold on 
    end
    %subnodelist item
    for linki=1:size(t2_subnodelist,1)
        ni=t2_subnodelist(linki,1);
        text(t2_nodelist(ni,2),-t2_nodelist(ni,3),[mat2str(linki),' ',mat2str(round(t2_subnodelist(linki,7)*10)/10)]);
    end
    title('net2');
end