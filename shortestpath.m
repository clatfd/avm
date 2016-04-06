load ddd.mat
DSA=ddd;
DSAmainlabel=bwlabeln(DSA);
props = regionprops(DSAmainlabel, 'Area');
[~,maxareaindex]=max([props.Area]);
DSAmain = ismember(DSAmainlabel,maxareaindex);
n=size(DSAmain,3);
node=[];
linkfrom=[];
linkto=[];
for i=1:n
	slice=DSAmain(:,:,i);
	[slicelabel slicenodenum]=bwlabel(slice);
	for j=1:slicenodenum
		if(i>1)
			currentnodearea=ismember(slicelabel,j);
			for k=1:size(lastnodearea,3)
				comlogic=lastnodearea(:,:,k).*currentnodearea;
				if(max(comlogic(:)))
					linkfrom=[linkfrom,size(node,1)+j];
					linkto=[linkto,lastnodeareaid(k)];
				end
			end
		end
	end
	lastnodearea=zeros(size(DSAmain,1),size(DSAmain,2),slicenodenum);
	lastnodeareaid=zeros(1,slicenodenum);
	for j=1:slicenodenum
		[d e]=find(slicelabel==j);
		if(size(d,1)>1)
		node=[node; [uint16(mean(d)),uint16(mean(e)),i,size(d,1)]];
	end
		if(i<n)
		lastnodearea(:,:,j)=ismember(slicelabel,j);
		lastnodeareaid(j)=size(node,1);
		end
	end
end

linkpart1=[linkfrom,linkto];
linkpart2=[linkto,linkfrom];
nodenum=size(linkpart1,2);
con=sparse(linkpart1,linkpart2,ones(1,nodenum),nodenum,nodenum);
%h = view(biograph(con,[],'ShowWeights','on'));
dist= graphshortestpath(con,1,6);
