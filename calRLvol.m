function RLvoltlist=calRLvol(vol,nodelist,RLnodelist)
RLvoltlist=zeros(size(RLnodelist,1),2);
sumRL=sum(RLnodelist);
for bi=2:size(RLnodelist,1)
    cusumv=sum(RLnodelist(bi:end,1));
    cusuma=sum(RLnodelist(bi:end,2));
    RLvoltlist(bi,1)=vol*cusumv/sumRL(1);
    RLvoltlist(bi,2)=cusuma;
    for bii=2:bi-1
        RLvoltlist(bi,1)=RLvoltlist(bi,1)+sum(nodelist(bi:end,4))/sum(nodelist(bii:end,4))/(bi-2);
    end
end

end