%anti-noise
[t1_nodelist,t1_linkfrom,t1_linkto]=loadswc('snake_tracing_t.swc');
t1_branchlist=splitbranch(t1_nodelist,t1_linkfrom,t1_linkto);
[t1_totbranch,t1_volbranch]=calbranch(t1_nodelist,t1_branchlist);
subbranchid=1;
t1_RLnodelist=calRLbranch(t1_nodelist,t1_branchlist{subbranchid});
t1_nsinodelist=getnsilist(t1_nodelist,t1_linkfrom,t1_linkto);
t1_RLvoltlist=calRLvol(t1_nsinodelist(t1_branchlist{subbranchid}(1),1),t1_nodelist,t1_RLnodelist);
figure;
plot(t1_RLvoltlist(2:end,1));
t1_nodelist(t1_branchlist{subbranchid}(10),4)=0.01;
t1_nsinodelist=getnsilist(t1_nodelist,t1_linkfrom,t1_linkto);
t1_RLvoltlist_m=calRLvol(t1_nsinodelist(t1_branchlist{subbranchid}(1),1),t1_nodelist,t1_RLnodelist);
hold on;
plot(t1_RLvoltlist_m(2:end,1),'color','r');
volt_dif=t1_RLvoltlist_m-t1_RLvoltlist;