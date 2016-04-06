function [newnodelist,linkfrom_trim,linkto_trim]=net_trim(DSAmain)
n=size(DSAmain,3);
slicelabel=zeros(size(DSAmain,1),size(DSAmain,2),n);%store label location in 3D map
labelindex=zeros(n,100);%max node number in each slice:100
node=[];%node=[[i j];[i j+1];;]
linkfrom=[];
linkto=[];
%compare slice
linkednum=[];
insliceid=[];
for i=1:n
	slice=DSAmain(:,:,i);
	[slicelabel(:,:,i),slicenodenum]=bwlabel(slice);
	for j=1:slicenodenum
        currentnodearea=ismember(slicelabel(:,:,i),j);
        % props = regionprops(currentnodearea, 'Area');
        node=[node;[i,j,sum(currentnodearea(:))]];
        labelindex(i,j)=size(node,1);
		if i>1
			comlogic=slicelabel(:,:,i-1).*currentnodearea;  %see whether two binary slices have common 1 area
            [linkednum,insliceid] = hist(comlogic(:),(0:max(comlogic(:)))');
			for k=1:size(linkednum,2)
               if insliceid(k)>0 && linkednum(k)>0 && labelindex(i-1,insliceid(k))>0
                   linkfrom=[linkfrom,labelindex(i,j),];
                   linkto=[linkto,labelindex(i-1,insliceid(k))];
               end
            end
		end
    end
    if(~mod(i,50))
		fprintf('%.1f\t', i/n*100);
	end
end
%del nodes
newid=1;
newnode_weight=[];
newidlist=zeros(1,size(node,1));
oldidlist=[];
linkto_trim=linkto;
linkfrom_trim=linkfrom;
for linki=size(linkfrom,2):-1:1
    current_node_id=linkfrom(linki);
    if node(current_node_id,3)<10   %parent node weight < 10
        del_from_index=find(linkfrom_trim(:)==current_node_id);
        linkfrom_trim(del_from_index)=[];    %del all current node's link pair in both linkfrom and linkto
        linkto_trim(del_from_index)=[];
        del_to_index=find(linkto_trim(:)==current_node_id);
        linkfrom_trim(del_to_index)=[];
        linkto_trim(del_to_index)=[];
    elseif size(find(linkfrom_trim(:)==current_node_id),1) ==1  && size(find(linkto_trim(:)==current_node_id),1) ==1 %has single child and parent, trim node
        parent_node_id=linkfrom_trim(find(linkto_trim(:)==current_node_id));
        child_node_id=linkto_trim(linki);
        linkfrom_trim(find(linkfrom_trim(:)==current_node_id))=parent_node_id;    %child node's parent change to current node's parent
        %del child node's pair
        del_to_index=find(linkto_trim(:)==current_node_id);
        linkfrom_trim(del_to_index)=[];
        linkto_trim(del_to_index)=[];
        newnode_weight(newidlist(parent_node_id))=newnode_weight(newidlist(parent_node_id))+node(current_node_id,3);        %node weight combined to parent
    elseif newidlist(current_node_id)==0
        newidlist(current_node_id)=newid;
        oldidlist(newid)=current_node_id;
        newnode_weight(newid)=node(current_node_id,3);
        newid=newid+1;
    end
end
%del child node with weight < 10
for linki=1:size(linkto_trim,2)
    current_node_id=linkto_trim(linki);
    if node(current_node_id,3)<10 && size(find(linkto_trim(:)==current_node_id),1) ==1 %child node weight < 10 and is single childnode
        del_to_index=find(linkto_trim(:)==current_node_id);
        linkfrom_trim(del_to_index)=[];    %del all current node's link pair in both linkfrom and linkto
        linkto_trim(del_to_index)=[];
    end
    if linki>=size(linkto_trim,2)
        break;
    end
end
    
%assign new id for linkto nodes(end of each branch) 
for linki=size(linkto_trim,2):-1:1
    current_node_id=linkto_trim(linki);
    if newidlist(current_node_id)==0
        newidlist(current_node_id)=newid;
        oldidlist(newid)=current_node_id;
        newnode_weight(newid)=node(current_node_id,3);
        newid=newid+1;
    end    
end
linkfrom_trim=newidlist(linkfrom_trim);
linkto_trim=newidlist(linkto_trim);

for ni=1:size(find(newidlist(:)>0),1)
    plot(node(oldidlist(ni),2),node(oldidlist(ni),1),'o');
    hold on 
    text(node(oldidlist(ni),2),node(oldidlist(ni),1),mat2str(newnode_weight(ni)));
    hold on 
end
for linki=1:size(linkfrom_trim,2)
    origin_from_id=find(newidlist(:)==linkfrom_trim(linki));
    origin_to_id=find(newidlist(:)==linkto_trim(linki));
    line([node(oldidlist(linkfrom_trim(linki)),2),node(oldidlist(linkto_trim(linki)),2)],[node(oldidlist(linkfrom_trim(linki)),1),node(oldidlist(linkto_trim(linki)),1)]);
end
newnodelist=node(oldidlist,:);
% a=[linkfrom;linkto]';
% dlmwrite('net.txt',a ,'delimiter', ' ');
end