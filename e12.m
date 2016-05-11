[t1_nodelist,t1_linkfrom,t1_linkto]=loadswc('snake_tracing_e1.swc');
t1_branchlist=splitbranch(t1_nodelist,t1_linkfrom,t1_linkto);
% t1_ynodelist=splitynode(t1_nodelist,t1_linkfrom,t1_linkto);
[t1_totbranch,t1_volbranch,t1_direction]=calbranch(t1_nodelist,t1_branchlist);
paintbranch(t1_nodelist,t1_linkfrom,t1_linkto,t1_branchlist,t1_totbranch,t1_volbranch);

[t2_nodelist,t2_linkfrom,t2_linkto]=loadswc('snake_tracing_e2.swc');
t2_branchlist=splitbranch(t2_nodelist,t2_linkfrom,t2_linkto);
[t2_totbranch,t2_volbranch,t2_direction]=calbranch(t2_nodelist,t2_branchlist);
paintbranch(t2_nodelist,t2_linkfrom,t2_linkto,t2_branchlist,t2_totbranch,t2_volbranch);

branchgroup={[1,2,17],[3,4,22,35],[5,6,7,10,25,32],[8,9,33,34],[26,27,28,29,30,31],[23,24],[11,12,13],[14,15];[1,2,21],[3,4,8,24],[5,11,12,13,15,16],[17,18],[14,19],[9,10],[6,7,20],[]};
t1_idlist=1:size(t1_totbranch,2);
t1_branchproperties=[t1_idlist',t1_totbranch',t1_volbranch',t1_direction'];
t2_idlist=1:size(t2_totbranch,2);
t2_branchproperties=[t2_idlist',t2_totbranch',t2_volbranch',t2_direction'];
branchidpair=[];

for bgi=1:size(branchgroup,2)
    if size(branchgroup{1,bgi},2)~=size(branchgroup{2,bgi},2)
        t1_branchheads=[];
        for hi=1:size(branchgroup{1,bgi},2)
            t1_branchheads=[t1_branchheads,branchlist{branchgroup{1,bgi}(hi)}(1)];
        end
        t1_branchheads=unique(t1_branchheads);
        t1_nodensi=[];
        for hi=1:size(t1_branchheads,2)
            t1_nodensi(hi,:)=[t1_branchheads(hi),getnodensi(t1_nodelist,t1_linkfrom,t1_linkto,t1_branchheads(hi))];
        end
        t1_nodensi=sortrows(t1_nodensi,2);
        delheadid=t1_nodensi(1,1);
        
        for hi=1:size(branchgroup{1,bgi},2)
            if branchlist{branchgroup{1,bgi}(hi)}(1)==delheadid
                branchgroup{1,bgi}(hi)=0;
            end
        end
        validids=find(branchgroup{1,bgi}>0);
        branchgroup{1,bgi}=branchgroup{1,bgi}(validids);
        
    end
        t1_branchiproperties=t1_branchproperties(branchgroup{1,bgi},:);
        t1_branchiproperties=sortrows(t1_branchiproperties,4);
        t2_branchiproperties=t2_branchproperties(branchgroup{2,bgi},:);
        t2_branchiproperties=sortrows(t2_branchiproperties,4);
        branchidpair=[branchidpair;[t1_branchiproperties(:,1),t2_branchiproperties(:,1)]];
end
% branchidpair=[2,2;1,1;17,21;20,23;18,22;35,24;4,4;22,8;24,10;23,9;32,15;7,16;25,13;33,18;34,17;30,19;27,14];
figure;
title('RLbranchComp');
hold on
axis([0 200 -200 0]);

for bpi=1:size(branchidpair,1)
    branchpair=[];
    t1_subbranchid=branchidpair(bpi,1);
    t1_RLnodelist=calRLbranch(t1_nodelist,t1_branchlist{t1_subbranchid});
    t1_nsinodelist=getnsilist(t1_nodelist,t1_linkfrom,t1_linkto);
    t1_RLvoltlist=calRLvol(t1_nsinodelist(t1_branchlist{t1_subbranchid}(1),1),t1_nodelist,t1_RLnodelist);
    %paintRLbranch(t1_nodelist,t1_branchlist{t1_subbranchid},t1_RLnodelist,t1_RLvoltlist);

    t2_subbranchid=branchidpair(bpi,2);
    t2_RLnodelist=calRLbranch(t2_nodelist,t2_branchlist{t2_subbranchid});
    t2_nsinodelist=getnsilist(t2_nodelist,t2_linkfrom,t2_linkto);
    t2_RLvoltlist=calRLvol(t2_nsinodelist(t2_branchlist{t2_subbranchid}(1),1),t2_nodelist,t2_RLnodelist);
    %paintRLbranch(t2_nodelist,t2_branchlist{t2_subbranchid},t2_RLnodelist,t2_RLvoltlist);

    branchipair=findbranchipair(t1_RLvoltlist(2:end,1),t2_RLvoltlist(2:end,1),0);
    validids=find(branchipair(:,1)>0);
    branchpair=[branchpair;branchipair(validids,:)];

    paintcompbranch(t1_nodelist,t1_branchlist{t1_subbranchid},branchpair);
end