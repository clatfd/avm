function nodensi=getnodensi(nodelist,linkfrom,linkto,targetid)
ni=targetid;
    neigh=[];
    parent_node_index= linkto(:)==ni;
    neigh=[neigh,linkfrom(parent_node_index)];
    child_node_index= linkfrom(:)==ni;
    neigh=[neigh,linkto(child_node_index)];
    neighneigh=[];
    for neighi=1:size(neigh,2)
        parent_node_index= linkto(:)==neigh(neighi);
        neighneigh=[neighneigh,linkfrom(parent_node_index)];
        child_node_index= linkfrom(:)==neigh(neighi);
        neighneigh=[neighneigh,linkto(child_node_index)];
    end
    neighneigh=setdiff(neighneigh,[neigh,ni]);  %del neigh and itself
    neigh_weight=nodelist(neigh,4);
    neighneig_weight=nodelist(neighneigh,4);
    nodensi(1)=nodelist(ni,4)+sum(neigh_weight.*0.6);
    nodensi(2)=nodelist(ni,4)+sum(neigh_weight.*0.6)+sum(neighneig_weight.*0.3);
end