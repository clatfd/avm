function [nodelist,linkfrom,linkto]=loadswc(swcfile)
SWC=load(swcfile);
%node_id=SWC(:,1)';
nodelist=SWC(:,[1 3:4 6]);
linkfrom=SWC(2:end,7)';
linkto=SWC(2:end,1)';
%degree
links=[linkfrom,linkto];
for ni=1:size(nodelist,1)
nodelist(ni,5)=size(find(links(:)==ni),1);
end
end