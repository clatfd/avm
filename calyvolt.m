function voltlist=calyvolt(nodelist,linkfrom,linkto)
ynodelist=findYnode(nodelist,linkfrom,linkto);
ynode_id=find(ynodelist(:,5)>0);
G=zeros(size(ynode_id,1),size(ynode_id,1));
VI=zeros(size(ynode_id,1),1);

for yni=1:size(ynode_id,1)
    current_node_id=ynode_id(yni);
    %find neighbour
    neigh=[];
    parent_node_index= linkto(:)==current_node_id;
    neigh=[neigh,linkfrom(parent_node_index)];
    child_node_index= linkfrom(:)==current_node_id;
    neigh=[neigh,linkto(child_node_index)];
    
    % self admittance and VI
    for neighi=1:size(neigh,2)
        G(yni,yni)=G(yni,yni)+1/(nodelist(neigh(neighi),4)+nodelist(current_node_id,4));
        VI(yni)=VI(yni)+(nodelist(neigh(neighi),3)-nodelist(current_node_id,3))/(nodelist(neigh(neighi),4)+nodelist(current_node_id,4));  
    end
    
    %find connected ynode--target node
    target_node=intersect(ynode_id',neigh);
    % mutual admittance
    for targeti=1:size(target_node,2)
        target_id=find(ynode_id(:)==target_node(targeti));
        Rij=nodelist(target_node(targeti),4)+nodelist(current_node_id,4);
        G(yni,target_id)=G(yni,target_id)-1/Rij;
    end
end
voltlist=G^-1*VI;
end