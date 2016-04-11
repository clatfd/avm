function ynodelist=findYnode(nodelist,linkfrom,linkto)
ynodelist=nodelist;
current_ynode_size=1;
for current_node_id=1:size(nodelist)
    child_node_num=sum(linkfrom(:)==current_node_id);
    parent_node_num=sum(linkto(:)==current_node_id);
    if child_node_num>1 || parent_node_num>1
        ynodelist(current_node_id,5)=current_ynode_size;
        current_ynode_size=current_ynode_size+1;
    end
end
end