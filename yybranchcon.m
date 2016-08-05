function [yybranch,yybranchdes]=yybranchcon(t1_linkfrom,t1_linkto,t1_ynode)
t1_DGsize=max([t1_linkfrom t1_linkto]);
DG=sparse(t1_linkfrom,t1_linkto,ones(1,size(t1_linkfrom,2)),t1_DGsize,t1_DGsize);
yybranch=[];
yybranchdes=[];
yybnum=1;
for i=1:size(t1_ynode,2)-1
    for j=i+1:size(t1_ynode,2)
        [dist path ~]=graphshortestpath(DG,t1_ynode(i),t1_ynode(j));
        if size(intersect(t1_ynode,path),2)==2
            yybranch{yybnum}=path;
            yybranchdes=[yybranchdes;[i,j]];
            yybnum=yybnum+1;
        end
    end
end
end