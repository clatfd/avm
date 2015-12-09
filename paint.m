% DSA=squeeze(dicomread('SEG_Objects_2/SEG_0.dcm'));
load ddd.mat;
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
	if(~mod(i,100))
		i
	end
end
%no direction
linkpart1=[linkfrom,linkto];
linkpart2=[linkto,linkfrom];
nodenum=size(linkpart1,2);
con=sparse(linkpart1,linkpart2,ones(1,nodenum),nodenum,nodenum);
%h = view(biograph(con,[],'ShowWeights','on'));
%dist= graphshortestpath(con,1,6);

% seedV=[[223 201 41];[289 161 41];[386 198 41]];
% seedA=[281 208 308];
%z-index
seedVindex=find(node(:,3)==397);
seedVindex=[seedVindex;826];
seedAindex=find(node(:,3)==131);
seedV=node(seedVindex,1:3);	%[[226 207 397];[288 170 397];[392 231 397];[390 258 397]];
seedV=[seedV;[239 107 229]];
seedA=node(seedAindex,1:3);	%[280 208 131];
Zstart=seedA(3);
Zend=seedV(1,3);
if exist('color3dc','dir')~=7
    mkdir('color3dc');
end
for i=1:size(DSAmain,3);
	paintR=zeros(size(DSAmain,1),size(DSAmain,2));
	paintG=zeros(size(DSAmain,1),size(DSAmain,2));
	paintB=zeros(size(DSAmain,1),size(DSAmain,2));
	slice=DSAmain(:,:,i);
	[slicelabel slicenodenum]=bwlabel(slice);
	if(i<Zstart)
		paintR=DSAmain(:,:,i).*255;
	elseif(i>Zend)
		paintB=DSAmain(:,:,i).*255;
	else
		indexnum=find(node(:,3)==i);
		for j=1:size(indexnum,1)
			distA=min([graphshortestpath(con,seedAindex(1),indexnum(j))]);
			distV=min([graphshortestpath(con,seedVindex(1),indexnum(j)),graphshortestpath(con,seedVindex(2),indexnum(j)),graphshortestpath(con,seedVindex(3),indexnum(j)),graphshortestpath(con,seedVindex(4),indexnum(j)),graphshortestpath(con,seedVindex(5),indexnum(j))]);
			currentnodearea=ismember(slicelabel,j);
			if(distV==inf||distA==inf)
				paintG=paintG+double(currentnodearea);
			else
				%find node area
				%in this area
				paintR=paintR+double(currentnodearea).*(1-distA/(distA+distV));
				paintB=paintB+double(currentnodearea).*(1-distV/(distA+distV));
			end
		end
	end
	outline=cat(3,paintR,paintG,paintB);
	%imshow(outline);
	if i<10
		ii=['00',int2str(i)];
	elseif i<100
		ii=['0',int2str(i)];
	else
		ii=int2str(i);
	end
	imwrite(outline,['color3dc/out',ii,'.tiff']);
	
end