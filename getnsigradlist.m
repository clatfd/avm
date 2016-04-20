function nsigradnodelist=getnsigradlist(nodelist,linkfrom,linkto)
    nsinodelist=getnsilist(nodelist,linkfrom,linkto);
    nsigradnodelist=zeros(size(nodelist,1),2);
    for ni=2:size(nodelist,1)
        nsigradnodelist(ni,:)=nsinodelist(ni,:)-nsinodelist(ni-1,:);
    end
end