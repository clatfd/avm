function nsinodelist=getnsilist(nodelist,linkfrom,linkto)
nsinodelist=zeros(size(nodelist,1),2);
for ni=1:size(nodelist,1)
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
    nsinodelist(ni,1)=nodelist(ni,4)+sum(neigh_weight.*0.6);
    nsinodelist(ni,2)=nodelist(ni,4)+sum(neigh_weight.*0.6)+sum(neighneig_weight.*0.3);
end
end