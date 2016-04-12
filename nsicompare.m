function nsicompare(filename1,filename2)
[t1_nodelist,t1_linkfrom,t1_linkto]=loadswc(filename1);
[t2_nodelist,t2_linkfrom,t2_linkto]=loadswc(filename2);
t1_nsinodelist=getnsilist(t1_nodelist,t1_linkfrom,t1_linkto);
t2_nsinodelist=getnsilist(t2_nodelist,t2_linkfrom,t2_linkto);
paintswc(filename1,t1_nsinodelist(:,1),t1_nsinodelist(:,2));
paintswc(filename2,t2_nsinodelist(:,1),t2_nsinodelist(:,2));
t1_nodelist=[t1_nodelist,t1_nsinodelist];
t2_nodelist=[t2_nodelist,t2_nsinodelist];
regiNodes(t1_nodelist,t1_linkfrom,t1_linkto,t2_nodelist,t2_linkfrom,t2_linkto);
end
