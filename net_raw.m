function net_raw(DSAmain)
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

for ni=1:size(node,1)
    plot(node(ni,2),node(ni,1),'o');
    hold on 
    text(node(ni,2),node(ni,1),mat2str(node(ni,3)));
    hold on 
end
for linki=1:size(linkfrom,2)
    line([node(linkfrom(linki),2),node(linkto(linki),2)],[node(linkfrom(linki),1),node(linkto(linki),1)]);
end

% a=[linkfrom;linkto]';
% dlmwrite('net.txt',a ,'delimiter', ' ');
end