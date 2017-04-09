function [t1_ynode, t2_ynode]= pairynode(t1_nodelist,t2_nodelist,t1_nsinodelist,t2_nsinodelist)
t1_deg3r=t1_nodelist(t1_nodelist(:,5)==3,1);
t2_deg3r=t1_nodelist(t2_nodelist(:,5)==3,1);
t1_deg3=t1_deg3r(1);
for i =2:length(t1_deg3r)
    if t1_deg3r(i)~=t1_deg3r(i-1)+1
        t1_deg3=[t1_deg3;t1_deg3r(i)];
    end
end
t2_deg3=t2_deg3r(1);
for i =2:length(t2_deg3r)
    if t2_deg3r(i)~=t2_deg3r(i-1)+1
        t2_deg3=[t2_deg3;t2_deg3r(i)];
    end
end

t1_ynode=[];
t2_ynode=[];
for i =1:length(t2_deg3)
    distij=zeros(1,length(t1_deg3));
    for j = 1:length(t1_deg3)
        distij(j)=pdist([t2_nodelist(t2_deg3(i),2:4);t1_nodelist(t1_deg3(j),2:4)],'euclidean');
    end
    
    distsind=find(distij<15);
    distnsi=9999*ones(1,length(distsind));
    for k=1:length(distsind)
        if (any(t1_deg3(distsind(k))==t1_ynode))
            continue;
        end
        distnsi(k)=distij(distsind(k))-t1_nsinodelist(distsind(k),2);               
    end
    [mindist,minind]=min(distnsi);
    t1_ynode=[t1_ynode,t1_deg3(distsind(minind))];
    t2_ynode=[t2_ynode,t2_deg3(i)]; 
end
