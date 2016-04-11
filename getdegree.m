function degnodelist=getdegree(nodelist,linkfrom,linkto)
degnodelist=nodelist;
links=[linkfrom,linkto];
for ni=1:size(nodelist,1)
degnodelist(ni,4)=size(find(links(:)==11),1);
end
end