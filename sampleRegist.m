[t1_nodelist,t1_linkfrom,t1_linkto]=loadswc('snake_tracing_mt2.swc');
t1_nsinodelist=getnsilist(t1_nodelist,t1_linkfrom,t1_linkto);
% t1_ynode=splitynode(t1_nodelist,t1_linkfrom,t1_linkto);
t1_ynode=[12,25,34,40,60,64];
[t1_yybranch,t1_yybranchdes]=yybranchcon(t1_linkfrom,t1_linkto,t1_ynode);
t1_edbranchlist=splitnbranch(t1_nodelist,t1_linkfrom,t1_linkto,t1_ynode,t1_yybranch);
t1_branchlist=[t1_yybranch,t1_edbranchlist];
% t1_branchlist=splitbranch(t1_nodelist,t1_linkfrom,t1_linkto);
[t1_totbranch,t1_volbranch,t1_direction]=calbranch(t1_nodelist,t1_branchlist);
paintbranch(t1_nodelist,t1_linkfrom,t1_linkto,t1_branchlist,t1_totbranch,t1_volbranch,t1_nsinodelist,t1_ynode);
%paintswc('snake_tracing_mt2.swc');

[t2_nodelist,t2_linkfrom,t2_linkto]=loadswc('snake_tracing_mtc2.swc');
t2_nsinodelist=getnsilist(t2_nodelist,t2_linkfrom,t2_linkto);
% t2_ynode=splitynode(t2_nodelist,t2_linkfrom,t2_linkto);
t2_ynode=[12,26,36,39,54,58];
[t2_yybranch,t2_yybranchdes]=yybranchcon(t2_linkfrom,t2_linkto,t2_ynode);
t2_edbranchlist=splitnbranch(t2_nodelist,t2_linkfrom,t2_linkto,t2_ynode,t2_yybranch);
t2_branchlist=[t2_yybranch,t2_edbranchlist];
% t2_branchlist=splitbranch(t2_nodelist,t2_linkfrom,t2_linkto);
[t2_totbranch,t2_volbranch,t2_direction]=calbranch(t2_nodelist,t2_branchlist);
paintbranch(t2_nodelist,t2_linkfrom,t2_linkto,t2_branchlist,t2_totbranch,t2_volbranch,t2_nsinodelist,t2_ynode);
%paintswc('snake_tracing_mtc2.swc');

%divide branch group
branchgroup={};
for yni=1:size(t1_ynode,2)
    branchgroup{1,yni}=[];
    for bi1=1:size(t1_branchlist,2)
        if t1_branchlist{bi1}(1)==t1_ynode(yni)
            branchgroup{1,yni}=[branchgroup{1,yni},bi1];
        end
    end
    branchgroup{2,yni}=[];
    for bi2=1:size(t2_branchlist,2)
        if t2_branchlist{bi2}(1)==t2_ynode(yni)
            branchgroup{2,yni}=[branchgroup{2,yni},bi2];
        end
    end
end

%pair branch
t1_idlist=1:size(t1_totbranch,2);
t1_branchproperties=[t1_idlist',t1_totbranch',t1_volbranch',t1_direction'];
t2_idlist=1:size(t2_totbranch,2);
t2_branchproperties=[t2_idlist',t2_totbranch',t2_volbranch',t2_direction'];
branchidpair=[];

for bgi=1:size(branchgroup,2)
        t1_branchiproperties=t1_branchproperties(branchgroup{1,bgi},:);
        t1_branchiproperties=sortrows(t1_branchiproperties,4);
        t2_branchiproperties=t2_branchproperties(branchgroup{2,bgi},:);
        t2_branchiproperties=sortrows(t2_branchiproperties,4);
        
     if size(branchgroup{1,bgi},2)~=size(branchgroup{2,bgi},2)
        % todo
         dif1=t1_branchiproperties(1,4)-t2_branchiproperties(1,4);
         if dif1<-50 || dif1>50
             t1_branchiproperties(1,:)=[];
         end
     end
     
     branchidpair=[branchidpair;[t1_branchiproperties(:,1),t2_branchiproperties(:,1)]];
end

figure;
title('RLbranchComp');
hold on
axis([0 100 -100 0]);
paintbasenet(t1_nodelist,t1_linkfrom,t1_linkto);

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

addt2branch={[31 90:94]};
addt2pos={[34.6139, 38.9449;35.0427000000000,35.5706000000000;36.7700000000000,32.6497000000000;37.6451000000000,29.3669000000000;38.6355000000000,26.1130000000000;39.2853000000000,22.7753000000000]};
paintadd(addt2branch,addt2pos);