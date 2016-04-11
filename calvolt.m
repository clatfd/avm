function voltlist=calvolt(nodelist,linkfrom,linkto)
G=zeros(size(nodelist,1),size(nodelist,1));
VI=zeros(size(nodelist,1),1);

for ni=1:size(nodelist,1)
    %find neighbour
    neigh=[];
    parent_node_index= linkto(:)==ni;
    neigh=[neigh,linkfrom(parent_node_index)];
    child_node_index= linkfrom(:)==ni;
    neigh=[neigh,linkto(child_node_index)];
    
    for neighi=1:size(neigh,2)
        Rij=nodelist(ni,4)+nodelist(neigh(neighi),4);
        G(ni,ni)=G(ni,ni)+1/Rij;
        VI(ni)=VI(ni)-(nodelist(neigh(neighi),4)-nodelist(ni,4))/Rij;  
        G(ni,neigh(neighi))=G(ni,neigh(neighi))-1/Rij;
%         Gij=1/(nodelist(ni,3)+nodelist(neigh(neighi),3));
%         G(ni,ni)=G(ni,ni)+Gij;
%         VI(ni)=VI(ni)-(nodelist(neigh(neighi),3)-nodelist(ni,3))*Gij;  
%         G(ni,neigh(neighi))=G(ni,neigh(neighi))-Gij;
    end
end
voltlist=G^-1*VI;
end